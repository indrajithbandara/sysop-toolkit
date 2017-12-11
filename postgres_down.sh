#!/bin/bash
# v0.0.1
su -l postgres -c "pg_ctl stop -D /var/lib/pgsql/9.5/data"
ip addr del 10.10.1.20/24 dev ens3 label ens3:0
su -l postgres -c "/usr/bin/pg_rewind -D  /var/lib/pgsql/9.5/data/ --source-server='host=10.10.1.12 port=5432 user=postgres password=P@ssw0rd'"
#
su -l postgres -c "cp /var/lib/pgsql/9.5/data/recovery.done /tmp/recovery.conf"
su -l postgres -c "mv /var/lib/pgsql/9.5/data/recovery.done /var/lib/pgsql/9.5/data/recovery.conf"
#
su -l postgres -c "pg_ctl start -D /var/lib/pgsql/9.5/data"
