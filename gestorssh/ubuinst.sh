#!/bin/bash
function inst_base {
apt update > /dev/null 2>&1
apt dist-upgrade -y > /dev/null 2>&1
apt install unzip > /dev/null 2>&1
apt install apache2 -y > /dev/null 2>&1
apt install cron curl unzip dirmngr -y > /dev/null 2>&1
apt install lsb-release ca-certificates apt-transport-https software-properties-common -y > /dev/null 2>&1
add-apt-repository ppa:ondrej/php -y > /dev/null 2>&1
apt update > /dev/null 2>&1
apt apt install php8.0 libapache2-mod-php8.0 php8.0-xml php8.0-mcrypt php8.0-curl php8.0-mbstring -y > /dev/null 2>&1
systemctl restart apache2
apt install mariadb-server -y > /dev/null 2>&1
cd || exit
mysql -u root -p"$pwdroot" -e "UPDATE mysql.user SET Password=PASSWORD('$pwdroot') WHERE User='root'"
mysql -u root -p"$pwdroot" -e "DELETE FROM mysql.user WHERE User=''"
mysql -u root -p"$pwdroot" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
mysql -u root -p"$pwdroot" -e "FLUSH PRIVILEGES"
mysql -u root -p"$pwdroot" -e "CREATE USER 'gestor'@'localhost';'"
mysql -u root -p"$pwdroot" -e "CREATE DATABASE sshplus;"
mysql -u root -p"$pwdroot" -e "GRANT ALL PRIVILEGES ON sshplus.* To 'gestor'@'localhost' IDENTIFIED BY '$pwdroot';"
mysql -u root -p"$pwdroot" -e "FLUSH PRIVILEGES"
echo '[mysqld]
max_connections = 1000' >> /etc/mysql/my.cnf
apt install php8.0-mysql -y > /dev/null 2>&1
phpenmod mcrypt
systemctl restart apache2
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt install php7.4-ssh2 -y > /dev/null 2>&1
php -m | grep ssh2 > /dev/null 2>&1
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
cd /var/www/html || exit
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/gestorssh.zip> /dev/null 2>&1
unzip gestorssh.zip > /dev/null 2>&1
chmod -R 777 /var/www/html
rm gestorssh.zip index.html > /dev/null 2>&1
(echo yes; echo yes; echo yes; echo yes) | composer install > /dev/null 2>&1
(echo yes; echo yes; echo yes; echo yes) | composer require phpseclib/phpseclib:~2.0 > /dev/null 2>&1
systemctl restart mysql
clear
}
function phpmadm {
cd /usr/share || exit
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip > /dev/null 2>&1
unzip phpMyAdmin-5.1.0-all-languages.zip > /dev/null 2>&1
mv phpMyAdmin-5.1.0-all-languages phpmyadmin
chmod -R 0755 phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
service apache2 restart 
rm phpMyAdmin-5.1.0-all-languages.zip
cd /root || exit
}
function pconf { 
sed "s/1020/$pwdroot/" /var/www/html/pages/system/pass.php > /tmp/pass
mv /tmp/pass /var/www/html/pages/system/pass.php
}
function inst_db { 
IP=$(wget -qO- ipv4.icanhazip.com)
curl $IP/create.php > /dev/null 2>&1
rm /var/www/html/create.php /var/www/html/sshplus.sql
}
function cron_set {
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
crontab cronset && rm cronset
}
function fun_swap {
            swapoff -a
            rm -rf /bin/ram.img > /dev/null 2>&1
            fallocate -l 4G /bin/ram.img > /dev/null 2>&1
            chmod 600 /bin/ram.img > /dev/null 2>&1
            mkswap /bin/ram.img > /dev/null 2>&1
            swapon /bin/ram.img > /dev/null 2>&1
            echo 50  > /proc/sys/vm/swappiness
            echo '/bin/ram.img none swap sw 0 0' | sudo tee -a /etc/fstab > /dev/null 2>&1
            sleep 2
}
function tst_bkp {
cd $HOME || exit
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/uteste > /bin/usersteste.sh
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/backupauto > /bin/autobackup.sh
chmod 777 /bin/usersteste.sh
chmod 777 /bin/autobackup.sh
mkdir /root/backupsql
}

echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo ""
echo -e "\E[44;1;37m    INSTALAR O PAINELWEB GESTOR-SSH     \E[0m"
echo ""
echo -e "                              \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
read -r -p "Digite sua senha de root: " pwdroot
echo "root:$pwdroot" | chpasswd
echo "Prosseguindo..." 
echo "..."
echo -e "           \033[1;33m● \033[1;32mINSTALAÇÃO EM ANDAMENTO, PODE DEMORAR, \033[1;33m● \033[1;33mAGUARDE...\033[0m"
sleep 2
inst_base
phpmadm
pconf
inst_db
cron_set
fun_swap
tst_bkp
clear
IP=$(wget -qO- ipv4.icanhazip.com)
clear
echo -e "\E[44;1;37m    PAINELWEB INSTALADO COM SUCESSO     \E[0m"
echo -e "                 \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
echo -e "\033[1;36m IP DO SEU PAINELWEB:\033[1;37m http://$IP/admin\033[0m"
echo -e "\033[1;36m USUÁRIO:\033[1;37m admin\033[0m"
echo -e "\033[1;36m SENHA:\033[1;37m admin\033[0m"
echo ""
echo -e "\033[1;33m Altere a senha quando logar no painel>> Configuracoes>> Senha Antiga: admin >> Nova Senha: \033[0m"
echo ""
echo -e "\033[1;31m A VPS SERÁ REINICIADA EM 10 SEGUNDOS...\033[0m"
sleep 15
echo -e "\033[1;31mREINICIANDO...\033[0m"
shutdown -r now
cat /dev/null > ~/.bash_history && history -c
cd $HOME || exit; rm instubuntu > /dev/null 2>&1