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
echo -e "\E[44;1;37m    RESTAURAR BANCO DE DADOS     \E[0m"
echo ""
echo -e "\E[44;1;37m    Copie o arquivo (sshplus.sql) para dendro da pasta root     \E[0m"
echo ""
echo -e "                              \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
echo -e "\033[1;31m ATENÇÃO \033[1;33m!!!"
echo ""
echo -ne "\033[1;32m INFORME A SENHA DO MYSQL\033[1;37m: "; read senha
echo -e "   \033[1;32mOK\033[1;37m"
echo ""
clear
#
cd
mysql -h localhost -u root -p$senha -e "DROP DATABASE sshplus"
mysql -h localhost -u root -p$senha -e "CREATE DATABASE sshplus"
if [[ -e "$HOME/sshplus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 sshplus < sshplus.sql
else
    clear
    echo -e "\033[1;31m ERRO AO IMPORTAR BANCO DE DADOS\033[0m"
    sleep 2
     sudo rm -rf /root/restbanco.sh > /dev/null 2>&1
wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/restbanco.sh > /dev/null 2>&1
chmod +x restbanco.sh; ./restbanco.sh
    exit
fi
echo ""
echo -e "\033[1;31m REINICIANDO A VPS EM 10 SEGUNDOS...\033[0m"
sleep 10
echo -e "\033[1;31mREINICIANDO...\033[0m"
shutdown -r now
cat /dev/null > ~/.bash_history && history -c
rm /root/install.sh > /dev/null 2>&1
rm /root/restbanco.sh > /dev/null 2>&1
rm /root/painelweb.sh > /dev/null 2>&1
exit
