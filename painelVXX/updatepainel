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
clear
#
clear
echo -e "\E[44;1;37m    ATUALIZANDO O PAINEL SSH/DROP/SSL V.XX GESTOR-SSH     \E[0m"
echo ""
echo -e "                              \033[1;31mBy @nandoslayer\033[1;36m"
echo -e "   VIP-vps" | figlet
echo ""
echo -e "\033[1;31m ATENCAO \033[1;33m!!!"
echo ""
echo -ne "\033[1;32m INFORME A SENHA DO MYSQL\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
echo ""
clear
#
echo -e "           \033[1;33m● \033[1;32mFINALIZANDO A ATUALIZAÇÃO, PODE DEMORAR \033[1;33m● \033[1;33mAGUARDE...\033[0m"
cd /var/www/html
rm -rf *.php *.png *.ico *.zip *.jpg *.sql *.html admin app-assets arquivos assets lib pages phpmailer scripts src > /dev/null 2>&1
wget https://github.com/nandoslayer/plusnssh/raw/ntech/painelVXX/PAINEL01-V.XX.zip > /dev/null 2>&1
wget https://github.com/nandoslayer/plusnssh/raw/ntech/painelVXX/PAINEL02-V.XX.zip > /dev/null 2>&1
sleep 1
unzip PAINEL01-V.XX.zip > /dev/null 2>&1
unzip PAINEL02-V.XX.zip > /dev/null 2>&1
rm -rf PAINEL01-V.XX.zip PAINEL02-V.XX.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;1010;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
#
clear
IP=$(wget -qO- ipv4.icanhazip.com)
clear
echo -e "   Painel-SSH" | figlet
echo -e "      V.XX" | figlet
echo -e "                 \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
echo -e "\033[1;36m SEU PAINEL:\033[1;37m http://$IP/\033[0m"
echo ""
sed -i "s;upload_max_filesize = 2M;upload_max_filesize = 300M;g" /etc/php5/apache2/php.ini > /dev/null 2>&1
service apache2 restart
echo ""
echo -e "\033[1;31m A VPS SERA REINICIADO EM 10 SEGUNDOS...\033[0m"
sleep 15
echo -e "\033[1;31mREINICIANDO...\033[0m"
shutdown -r now
cat /dev/null > ~/.bash_history && history -c
rm /root/install > /dev/null 2>&1
rm /root/updatepainel > /dev/null 2>&1
rm /root/PAINEL01-V.XX.zip > /dev/null 2>&1
rm /root/PAINEL02-V.XX.zip > /dev/null 2>&1
