# sysop-toolkit

This is scripts and ansible playboks for lerning  linux

All files, exceptions swap_prosmotr.sh  and movefromswap.sh  licensed by GPL version 2.0 or higer

swap_prosmotr.sh  and movefromswap.sh  - orphan work

Linux lessons - https://github.com/evgeny-lityushkin/Linux-lessons

Author - Eugene Lityushkin 2017

evgeny.lityushkin@gmail.com

1.  swap_prosmotr.sh - listing most "swaping" process in linux
2.  movefromswap.sh - move process from swap
3.  add-to-groups.yml - add linux user to any groups
4.  add-zabbix-server.yml - add zabbix server to zabbix agent configuration file
5.  check-version.yml - check version, status and restarting zabbix agent
6.  check-zabbix-agent-version-and-status.yml - check version, running process, servivce status and restarting zabbix agent
7.  deploy-ssh-key.yml - deploy ssh key to remoute hosts
8.  deploy-ssh-user.yml - deploy user to remoute hosts
9.  zabbix-update.yml - update zabbix agent (and keep it config)
10. rm-bad-zabbix-config-after-agent-update.yml - remove bad zabbix agent configuration files after agent update
11. deploy-application-file-to-remoute-hosts.yml - deploy applications files to remoute hosts
12. auditd_tuning.sh  - tunned security in new system. Configure Auditd daemon
13. zabbix-update-rpm.yml - simple playbook for update zabbix agents on rpm-based linux systems
14. zabbix-update.yml - - simple playbook for update zabbix agents on deb-based linux systemd
15. jks-certificate-expiry-checker.sh - Script for check certificates inside a java keystore
16. sslcheck-expiry.bash - Simple SSL cert days-till-expiry check script by Glen Scott, www.glenscott.net
17. sslcheck-issuer-cn.bash Simple SSL cert get-issuer-CN by Glen Scott
18. sslcheck-issuer-o.bash # Simple SSL cert get-issuer-O by Glen Scott
19. hosts.inv - simple example of ansible inventory file
20. http.sh - simple http server with regulated latency
21. bulk_reg_on_sat.sh - script for registration redhat based host on satellite
22. user_command_logging.sh - script for conguration logging all user command to syslog
23. ./backups/mysql/bin/backup.sh - simple script for backup mysql database
24. ./galera - examples of configuration files of galera cluster
25. ./ipip - examples of script for ipip tunnel and script for keepalived
26. ./keepalived - examples of configuration files of keepalived daemon
27. ./zabbix - exampled of scripts and configuration files for  zabbix agent
28. zabbix-update2.yml - simple playbook for update zabbix agents
