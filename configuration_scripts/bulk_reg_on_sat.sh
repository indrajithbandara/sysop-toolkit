#!/bin/bash

bpoint=1

cat >> /etc/hosts <<"EOF"
X.X.X.X      satellite.localdomain
EOF

yum install -y subscription-manager > /dev/null 2>&1
if [[ ${?} == 0 ]]; then ((bpoint++)); else echo -e "\e[00;31m ERROR on breakpoint: ${bpoint}\e[00m"; exit 1; fi

subscription-manager unregister > /dev/null 2>&1
if [[ ${?} == 0 ]]; then ((bpoint++)); else echo -e "\e[00;31m ERROR on breakpoint: ${bpoint}\e[00m"; exit 1; fi
subscription-manager clean > /dev/null 2>&1
if [[ ${?} == 0 ]]; then ((bpoint++)); else echo -e "\e[00;31m ERROR on breakpoint: ${bpoint}\e[00m"; exit 1; fi

for repofile in $(find /etc/yum.repos.d/ -type f -name '*.repo' ! -name 'redhat.repo' 2>/dev/null)
 do sed -i 's/^\s*enabled\s*=.*$/enabled=0/g' ${repofile}
done

rpm --force -Uvh http://satellite.localdomain/pub/katello-ca-consumer-latest.noarch.rpm > /dev/null 2>&1
if [[ ${?} == 0 ]]; then ((bpoint++)); else echo -e "\e[00;31m ERROR on breakpoint: ${bpoint}\e[00m"; exit 1; fi
rm -f /etc/rhsm/facts/katello.facts 2>/dev/null
subscription-manager register --org="ORGANIZATION" --activationkey="Reg_to_RHEL_ENVIROMENT" > /dev/null 2>&1
if [[ ${?} == 0 ]]; then ((bpoint++)); else echo -e "\e[00;31m ERROR on breakpoint: ${bpoint}\e[00m"; exit 1; fi
yum install -y --nogpgcheck katello-agent puppet > /dev/null 2>&1
if [[ ${?} == 0 ]]; then ((bpoint++)); else echo -e "\e[00;31m ERROR on breakpoint: ${bpoint}\e[00m"; exit 1; fi

exit 0
