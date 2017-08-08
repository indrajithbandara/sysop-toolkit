#!/bin/bash
# Simple SSL cert get-issuer-O
# by Glen Scott, www.glenscott.net

openssl_output=$(echo ”
GET / HTTP/1.0
EOT” \
| openssl s_client -connect $1:443 2>&1);

if [[ “$openssl_output” = *”—–BEGIN CERTIFICATE—–“* ]]; then

cert_issuer=$(echo “$openssl_output” \
| sed -n ‘/—–BEGIN CERTIFICATE—–/,/—–END CERTIFICATE—–/p’ \
| openssl x509 -noout -issuer -nameopt sname \
| tr ‘/’ ‘\n’ | grep O= | cut -c3- );

echo “$cert_issuer”;
exit 0
else
echo “NOT_FOUND”;
exit 1
fi
