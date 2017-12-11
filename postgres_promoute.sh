#!/bin/bash
# v0.0.1
ip addr add 10.10.1.20/32 dev ens3 label ens3:0
su -l postgres -c "/usr/bin/pg_ctl promote -D /var/lib/pgsql/9.5/data/"
