#!/bin/bash
clear
rm /root/backupsql/sshplus.sql > /dev/null 2>&1
senha=$(cat /var/www/html/pages/system/pass.php |cut -d"'" -f2)
mysqldump -u root -p$senha sshplus > /root/backupsql/sshplus.sql
