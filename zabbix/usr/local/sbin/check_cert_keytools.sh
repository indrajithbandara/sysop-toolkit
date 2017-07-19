#!/bin/bash
#
   keytool -list -v -keystore /home/jetty/etc/keystore -storepass 1234567890Rr |egrep "Alias|Valid"
