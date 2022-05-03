#!/bin/bash
menu(){
ipweb=$(curl https://bigbolgames.com)
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "INSTALAR PAINELWEB GESTOR-SSH CENTOS 7" ; tput sgr0 ; echo ""
echo "Continuar? S\n"
echo -n "> "
read option
if [ $option = "S" ]; then
install
elif [ $option = "s" ]; then
install
elif [ $option = "n" ]; then
pweb
elif [ $option = "N" ]; then
pweb
else
pweb
fi
}
install(){
clear
yum update -y > /dev/null 2>&1
yum upgrade -y > /dev/null 2>&1
yum install epel-release -y > /dev/null 2>&1 
yum install php htop zip nload nano phpmyadmin httpd mysql mariadb-server php-pecl-ssh2 -y --skip-broken
yum install gcc php-devel libssh2 libssh2-devel php-pear make php-mcrypt unzip wget screen -y --skip-broken
setsebool -P httpd_can_network_connect 1
systemctl enable httpd > /dev/null 2>&1
systemctl enable mariadb > /dev/null 2>&1
service httpd restart
service mariadb start
dbconfig
}
dbconfig(){
clear
echo "Insira a senha do ROOT Banco de dados"
echo -n "> "
read root_password
if [ -z $root_password ]; then
clear 
echo "Por favor coloque uma senha"
sleep 2
dbconfig
else
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$root_password') WHERE User = 'root'"
mysql -e "FLUSH PRIVILEGES"
phpmyadminfix
fi
}
phpmyadminfix(){
rm /etc/httpd/conf.d/phpMyAdmin.conf
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/phpMyAdmin.conf -O /etc/httpd/conf.d/phpMyAdmin.conf
chmod 777 /etc/httpd/conf.d/phpMyAdmin.conf
service httpd restart
installweb
}
installweb(){
cd /var/www/html || exit
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/gestorssh.zip > /dev/null 2>&1
unzip gestorssh.zip > /dev/null 2>&1
sed -i "s;1020;$root_password;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
rm gestorssh.zip > /dev/null 2>&1
chmod 777 -R /var/www/ > /dev/null 2>&1
cd || exit
createdb
}
createdb(){
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/bdgestorssh.sql
mysql -h localhost -u root -p$root_password -e "CREATE DATABASE sshplus"
mysql -h localhost -u root -p$root_password --default_character_set utf8 sshplus < bdgestorssh.sql
rm bdgestorssh.sql
croninstall
}
croninstall(){
crontab -l > cronset
echo "
* * * * * /bin/usersteste.sh
*/5 * * * * /bin/autobackup.sh
* * * * * /usr/bin/php /var/www/html/pages/system/cron.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.ssh.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.servidor.php
* * * * * /usr/bin/php /var/www/html/pages/system/cron.rev.php
*/1 * * * * /usr/bin/php /var/www/html/pages/system/cron.limpeza.php
0 */12 * * * cd /var/www/html/pages/system/ && bash cron.backup.sh && cd /root
5 */12 * * * cd /var/www/html/pages/system/ && /usr/bin/php cron.backup.php && cd /root" > cronset
crontab cronset && rm cronset > /dev/null 2>&1
cd $HOME || exit
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/uteste > /bin/usersteste.sh
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/backupauto > /bin/autobackup.sh
chmod 777 /bin/usersteste.sh
chmod 777 /bin/autobackup.sh
mkdir /root/backupsql
final
}
final(){
clear
echo "Login Painel ADMIN: admin"
echo "Senha Painel ADMIN: admin"
echo "Acesso Painel ADMIN: $ipweb/admin"
echo "Acesso PHPMYADMIN: $ipweb/phpmyadmin"
echo "Login PHPMYADMIN: root" 
echo "senha PHPMYADMIN: $root_password"
echo "Backup dos dados do PHPMyadmin se encontra no /root/PHPMYADMIN.txt"
echo "Acesso PHPMYADMIN: $ipweb/phpmyadmin" >> PHPMYADMINDATA.txt
echo "Login PHPMYADMIN: root" >> PHPMYADMINDATA.txt
echo "senha PHPMYADMIN: $root_password" >> PHPMYADMINDATA.txt
sleep 10
}
pweb