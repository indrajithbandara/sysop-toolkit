#!/bin/bash

BUILD_CONFIG=$3
exitcode=0

source $BUILD_CONFIG

msgPrint info "==== Настраиваем логирование выполняемых пользователем команд ===="

sed -i '/# logging all user activity to syslog/,/trap log2syslog DEBUG/d' /etc/profile
if [ ${?} != 0 ]; then ((exitcode++)); ((i++)); echo "${i}: ${exitcode}" >> ${0}.log; exit ${exitcode}; else ((i++)); fi

cat >> /etc/profile << "EOF"

# logging all user activity to syslog
function log2syslog {
	declare command
	command="`fc -ln -0 | sed 's/^[[:space:]]*//'`"
	logger -t SESSIONLOG -p user.notice - "SESSION=$$, USER=$LOGNAME, CMD=$command"
}
trap log2syslog DEBUG

EOF

exit $exitcode

