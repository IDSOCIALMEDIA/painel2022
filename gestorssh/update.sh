#!/bin/bash
clear
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
echo ""
echo -e "           \033[1;33m● \033[1;32mATUALIZANDO LINUX, Pode Demorar \033[1;33m●\033[0m"
fun_update () {
    apt-get update -y > /dev/null 2>&1 
	apt-get install figlet -y > /dev/null 2>&1
}
fun_bar 'fun_update'
echo ""
clear
#
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m    ATUALIZANDO O PAINELWEB SSH/DROP/SSL GESTOR-SSH     \E[0m"
echo ""
echo -e "                              \033[1;31mBy @nandoslayer\033[1;36m"
echo -e "   GESTOR-SSH" | figlet
echo ""
senha=$(cut -d"'" -f2 /var/www/html/pages/system/pass.php)
echo ""
clear
#
echo -e "           \033[1;33m● \033[1;32mFINALIZANDO A ATUALIZAÇÃO, PODE DEMORAR \033[1;33m● \033[1;33mAGUARDE...\033[0m"
cd /var/www/html
rm -rf *.php *.png *.ico *.zip *.jpg *.sql *.html logo admin app-assets arquivos assets lib pages phpmailer scripts src > /dev/null 2>&1
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/gestorssh.zip > /dev/null 2>&1
sleep 1
unzip -o gestorssh.zip > /dev/null 2>&1
rm -rf gestorssh.zip index.html create.php sshplus.sql > /dev/null 2>&1
clear
cd /etc
rm -rf crontab > /dev/null 2>&1
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/crontab > /dev/null 2>&1
chmod 777 /etc/crontab
sleep 1
clear
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.rev.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
echo '0 */12 * * * root cd /var/www/html/pages/system/ && bash cron.backup.sh && cd /root' >> /etc/crontab
echo '5 */12 * * * root cd /var/www/html/pages/system/ && /usr/bin/php cron.backup.php && cd /root' >> /etc/crontab
# LIMPEZA HISTORICO USUARIOS ONLINE A CADA 1 MINUTO #
echo '*/1 * * * * root /usr/bin/php /var/www/html/pages/system/cron.limpeza.php' >> /etc/crontab
# BACKUP BANCO DE DADOS DATABASE SQL A CADA 5 MINUTOS #
echo '*/5 * * * * root /bin/autobackup.sh' >> /etc/crontab
echo '* * * * * /bin/usersteste.sh' >> /etc/crontab
rm /bin/usersteste.sh > /dev/null 2>&1
rm /bin/autobackup.sh > /dev/null 2>&1
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/backupauto > /bin/autobackup.sh
wget -qO- https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/uteste > /bin/usersteste.sh
chmod 777 /bin/usersteste.sh
chmod 777 /bin/autobackup.sh
_bnco=$(echo $(openssl rand -hex 5))
sed -i "s;bancodir;$_bnco;g" /var/www/html/pages/system/config.php > /dev/null 2>&1
mkdir /root/backupsql > /dev/null 2>&1
chmod 777 /root/backupsql
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
chmod 777 /var/www/html/backups
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;1020;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
#
clear
IP=$(wget -qO- ipv4.icanhazip.com)
clear
echo -e "   PAINELWEB" | figlet
echo -e "      GESTOR-SSH" | figlet
echo -e "                 \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
echo -e "\033[1;36m PAINELWEB DIGITE ESSE IP NO NAVEGADOR:\033[1;37m http://$IP/admin\033[0m"
echo ""
echo -e "\033[1;31m REINICIANDO O APACHE EM 10 SEGUNDOS...\033[0m"
sleep 10
echo -e "\033[1;31mREINICIANDO...\033[0m"
service apache2 restart > /dev/null 2>&1
cat /dev/null > ~/.bash_history && history -c
rm /root/*.sh* > /dev/null 2>&1
clear
wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/empresa.sh > /dev/null 2>&1
chmod +x empresa.sh && dos2unix empresa.sh && ./empresa.sh
exit

