#!/bin/bash
STATE=$3
case $STATE in
        "MASTER") /usr/local/sbin/ipip.sh
                  ;;
        "BACKUP") ip tunnel del qrtun
                  ;;
        "FAULT")  ip tunnel del qrtun
                  exit 0
                  ;;
#        *)        /sbin/logger "ipip unknown state"
#                  exit 1
#                  ;;
esac
