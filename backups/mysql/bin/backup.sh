#!/bin/sh

cd /home/backup/bin

for db in `/bin/cat db_list`
do
     d_time=`/bin/date '+%d.%m.%Y'`
     f_time=`/bin/date '+%d.%m.%Y-%H-%M'`
     filepath=../files/$d_time/$db-db-$f_time.sql.gz
     /bin/mkdir -p ../files/$d_time
     /usr/bin/mysqldump --routines --single-transaction --quick --databases $db | pigz -c > $filepath
done

/usr/bin/find /home/backup/files/ -type d -mtime +10 -exec /bin/rm -rf {} \;
