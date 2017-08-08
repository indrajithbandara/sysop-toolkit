#!/bin/bash
# Simple SSL cert days-till-expiry check script
# by Glen Scott, www.glenscott.net
# https://www.glenscott.net/2011/12/09/checking-ssl-certificate-expiry-date-and-issuer-an-openssl-wrapper-in-bash/


openssl_output=$(echo ”
GET / HTTP/1.0
EOT” \
| openssl s_client -connect $1:443 2>&1);

if [[ “$openssl_output” = *”—–BEGIN CERTIFICATE—–“* ]]; then

cert_expiry_date=$(echo “$openssl_output” \
| sed -n ‘/—–BEGIN CERTIFICATE—–/,/—–END CERTIFICATE—–/p’ \
| openssl x509 -enddate \
| awk -F= ‘ /notAfter/ { printf(“%s\n”,$NF); } ‘);

seconds_until_expiry=$(echo “$(date –date=”$cert_expiry_date” +%s) – $(date +%s)” |bc);
days_until_expiry=$(echo “$seconds_until_expiry/(60*60*24)” |bc);

if [[ $days_until_expiry -ge 0 ]]; then

echo “$days_until_expiry”;
exit 0

else

echo “EXPIRED ($days_until_expiry days)”;

exit 0
fi

else
echo “NOT_FOUND”;
exit 1
