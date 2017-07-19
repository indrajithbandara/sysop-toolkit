#!/bin/bash

    export LC_TIME=en_US.utf8
    current_date_y=`date +"%b %d %H:%M:%S %Y %Z" --utc|cut -c 17-21`
    current_date_m=`date +"%b %d %H:%M:%S %Y %Z" --utc|cut -c -4`
    current_date_d=`date +"%b %d %H:%M:%S %Y %Z" --utc|cut -c 5-6`
    
    
    cert_date_y=`openssl s_client -connect localhost:443 2>/dev/null|sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'|openssl x509 -subject -noout -dates 2>/dev/null|grep After|cut -c 26-30`
    cert_date_m=`openssl s_client -connect localhost:443 2>/dev/null|sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'|openssl x509 -subject -noout -dates 2>/dev/null|grep After|cut -c 10-13`
    cert_date_d=`openssl s_client -connect localhost:443 2>/dev/null|sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'|openssl x509 -subject -noout -dates 2>/dev/null|grep After|cut -c 14-16`
    
    
    if [ $cert_date_y -eq $current_date_y ]
	then if [ $cert_date_m -eq $current_date_m]
	    then if [ $cert_date_d+5 > $current_date_d]
	    then echo 1 && exit 1
	    fi
	fi
    fi
    
    echo 0
    exit 0