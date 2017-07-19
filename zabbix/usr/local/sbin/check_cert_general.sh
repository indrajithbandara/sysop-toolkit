#!/bin/bash
#
for CERT in \
  www.yourdomain.com:443 \
  ldap.yourdomain.com:636 \
  imap.yourdomain.com:993
do
  openssl s_client -connect  ${CERT}|sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'|openssl verify
done
