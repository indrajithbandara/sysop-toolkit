#!/bin/bash
#----------------------------------------------------------------------#

systemctl enable auditd

# сначала чистим директорию с рулями
find /etc/audit/rules.d/ ! -name audit.rules ! -type d -delete
# делаем симлинки на выбранный набор правил
ln -s $(find /usr/share/doc/ -iname 'audit-*' | tail -n1)/rules/{10-base-config.rules,30-pci-dss-v31.rules,30-nispom.rules,30-stig.rules,32-power-abuse.rules,42-injection.rules,43-module-load.rules,99-finalize.rules} /etc/audit/rules.d/

echo '# At a minimum the audit system should collect the execution of privileged commands for all users and root' > /etc/audit/rules.d/31-privileged.rules
for priv_bin in $(find / -type f -perm -4000 -o -type f -perm -2000 2>/dev/null)
 do echo "-a always,exit -F path=${priv_bin} -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged" >> /etc/audit/rules.d/31-privileged.rules
done

cat > /etc/audit/rules.d/40-local.rules <<"EOF"
# time adjustment
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S stime -k audit_time_rules
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k audit_time_rules
# network settings
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k audit_rules_networkconfig_modification -w /etc/issue -p wa -k audit_rules_networkconfig_modification -w /etc/issue.net -p wa -k audit_rules_networkconfig_modification -w /etc/hosts -p wa -k audit_rules_networkconfig_modification -w /etc/sysconfig/network -p wa -k audit_rules_networkconfig_modification
# Modify the System's Mandatory Access Controls
-w /etc/selinux/ -p wa -k MAC-policy
# At a minimum the audit system should collect file permission changes for all users and root
-a always,exit -F arch=b64 -S chmod -S chown -S fchown -S fchownat -S fchmod -S fchmodat -S fremovexattr -S lremovexattr -S removexattr -S fsetxattr -S lsetxattr -S setxattr -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chmod -S chown -S fchown -S fchownat -S fchmod -S fchmodat -S fremovexattr -S lremovexattr -S removexattr -S fsetxattr -S lsetxattr -S setxattr -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
# At a minimum the audit system should collect unauthorized file accesses for all users and root
-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access -a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access -a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
# At a minimum the audit system should collect media exportation events for all users and root
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k export
-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k export
# At a minimum the audit system should collect file deletion events for all users and root
-a always,exit -F arch=b64 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
-a always,exit -F arch=b32 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
# capture kernel module loading and unloading events
-w /usr/sbin/insmod -p x -k modules -w /usr/sbin/rmmod -p x -k modules -w /usr/sbin/modprobe -p x -k modules -a always,exit -F arch=b64 -S init_module -S delete_module -k modules
EOF
augenrules
systemctl reload auditd.service

#----------------------------------------------------------------------#
