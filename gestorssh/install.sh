#!/bin/bash
clear
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
IP=$(wget -qO- ipv4.icanhazip.com)
clear
echo -e "\E[44;1;37m    INSTALAR PAINELWEB GESTOR-SSH     \E[0m" 
echo ""
echo -e "                 \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
echo -ne "\n\033[1;32mDEFINA UMA SENHA PARA O\033[1;33m MYSQL\033[1;37m: "; read senha
echo -e "\n\033[1;36mINICIANDO INSTALAÇÃO \033[1;33mAGUARDE..."
apt-get update -y > /dev/null 2>&1
apt-get install cron curl unzip -y > /dev/null 2>&1
echo -e "\n\033[1;36mINSTALANDO O APACHE2 \033[1;33mAGUARDE...\033[0m"
apt-get install apache2 -y > /dev/null 2>&1
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
echo -e "\n\033[1;36mINSTALANDO O MySQL \033[1;33mAGUARDE...\033[0m"
echo "debconf mysql-server/root_password password $senha" | debconf-set-selections
echo "debconf mysql-server/root_password_again password $senha" | debconf-set-selections
apt-get install mysql-server -y > /dev/null 2>&1
mysql_install_db > /dev/null 2>&1
(echo $senha; echo n; echo y; echo y; echo y; echo y)|mysql_secure_installation > /dev/null 2>&1
echo -e "\n\033[1;36mINSTALANDO O PHPMYADMIN \033[1;33mAGUARDE...\033[0m"
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $senha" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $senha" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $senha" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
apt-get install phpmyadmin -y > /dev/null 2>&1
php5enmod mcrypt > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
if [ "$(php -m |grep ssh2)" = "ssh2" ]; then
  true
else
  clear
  echo -e "\033[1;31m ERRO CRÍTICO\033[0m"
  rm /root/*.sh* > /dev/null 2>&1
wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/painelweb.sh > /dev/null 2>&1
chmod +x painelweb.sh && dos2unix painelweb.sh && ./painelweb.sh
  exit
fi
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
clear
echo ""
echo -e "\033[1;31m ATENÇÃO \033[1;33m!!!"
echo ""
echo -ne "\033[1;32m INFORME A MESMA SENHA\033[1;37m: "; read senha
sleep 1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE sshplus"
clear
echo -e "\033[1;36m FINALIZANDO INSTALAÇÃO\033[0m"
echo ""
echo -e "\033[1;33m AGUARDE..."
echo ""

cd /var/www/html
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/gestorssh.zip > /dev/null 2>&1
unzip gestorssh.zip > /dev/null 2>&1
rm -rf gestorssh.zip index.html > /dev/null 2>&1
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;1020;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
IP=$(wget -qO- ipv4.icanhazip.com)
curl $IP/create.php > /dev/null 2>&1
rm /var/www/html/create.php /var/www/html/sshplus.sql
sleep 1
clear
echo '* * * * * /bin/usersteste.sh' >> /etc/crontab
echo '0 */4 * * * /bin/autobackup.sh' >> /etc/crontab
echo '* * * * * /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * /usr/bin/php /var/www/html/pages/system/cron.ssh.php' >> /etc/crontab
echo '* * * * * /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '* * * * * /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
echo '* * * * * /usr/bin/php /var/www/html/pages/system/cron.rev.php' >> /etc/crontab
echo '0 */1 * * * /usr/bin/php /var/www/html/pages/system/cron.limpeza.php' >> /etc/crontab
echo '0 */12 * * * cd /var/www/html/pages/system/ && bash cron.backup.sh && cd /root' >> /etc/crontab
echo '5 */12 * * * cd /var/www/html/pages/system/ && /usr/bin/php cron.backup.php && cd /root' >> /etc/crontab
rm /bin/usersteste.sh > /dev/null 2>&1
rm /bin/autobackup.sh > /dev/null 2>&1
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/uteste > /bin/usersteste.sh
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/backupauto > /bin/autobackup.sh
chmod 777 /bin/usersteste.sh
chmod 777 /bin/autobackup.sh
_bnco=$(echo $(openssl rand -hex 5))
sed -i "s;bancodir;$_bnco;g" /var/www/html/pages/system/config.php > /dev/null 2>&1
mkdir /root/backupsql
chmod 777 /root/backupsql
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
chmod 777 /var/www/html/backups
sleep 1
echo -e "\033[1;32m GESTOR-SSH INSTALADO COM SUCESSO!"
echo ""
echo -e "                 \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
echo -e "\033[1;36m SEU PAINEL:\033[1;37m http://$IP/admin\033[0m"
echo -e "\033[1;36m USUÁRIO:\033[1;37m admin\033[0m"
echo -e "\033[1;36m SENHA:\033[1;37m admin\033[0m"
echo ""
echo -e "\033[1;31m REINICIANDO O APACHE...\033[0m"
sleep 1
echo -e "\033[1;31mREINICIANDO...\033[0m"
service apache2 restart > /dev/null 2>&1
cat /dev/null > ~/.bash_history && history -c
rm /root/*.sh* > /dev/null 2>&1
clear
wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/empresa.sh > /dev/null 2>&1
chmod +x empresa.sh && dos2unix empresa.sh && ./empresa.sh
exit
