#!/bin/bash
#
for CERT in \
  www.yourdomain.com:443 \
  ldap.yourdomain.com:636 \
  imap.yourdomain.com:993
do
  echo |\
  openssl s_client -connect ${CERT} 2>/dev/null |\
  sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' |\
  openssl x509 -noout -subject -dates                       # openssl verify remote.site.pem
done
