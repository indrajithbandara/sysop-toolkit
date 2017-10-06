#!/bin/bash
######################################################################################################################################################################
#
# Script for remoute cert checking v0.0.1 2017
#
######################################################################################################################################################################
if [ "$#" -lt 3 ]
    then echo "use check_cert.sh <server> <port> <dys before certificate expired>" && exit 1;
fi

date_tmp="$(echo "q"|openssl s_client -servername $1 -connect $1:$2 2>/dev/null|openssl x509 -noout -enddate 2>/dev/null|grep notAfter|cut -d= -f 2)"
date_cert=$(date '+%y%m%d' --date="$date_tmp")
date_host="$(date '+%y%m%d')"
let "date_shift=$date_cert-$3"
if [ "$date_shift" -gt "$date_host" ]
    then echo 0;
    else echo 1;
    fi
exit 0;
