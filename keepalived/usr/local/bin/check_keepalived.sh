#!/bin/bash

/usr/bin/ps -ef | grep [h]ttpd > /dev/null
if [[ "$?" -ne "0" ]]; then
    /usr/bin/logger "httpd not running. Setting keepalived state to FAULT." 
    exit 1
fi
