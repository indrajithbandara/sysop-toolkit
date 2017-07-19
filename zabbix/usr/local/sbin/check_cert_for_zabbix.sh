#!/bin/bash
  openssl s_client -connect  localhost:443 2>/dev/null|sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'|openssl verify 2>/dev/null
  exit $?
