#!/bin/bash
barra="\033[0m🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀\033[0m"

fun_prog ()
{
	comando[0]="$1" 
    ${comando[0]}  > /dev/null 2>&1 & 
	tput civis
	echo -ne "\033[1;32m.\033[1;33m.\033[1;31m. \033[1;32m"
    while [ -d /proc/$! ]
	do
		for i in / - \\ \|
		do
			sleep .1
			echo -ne "\e[1D$i"
		done
	done
	tput cnorm
	echo -e "\e[1DOK"
}

fun_update () {
    sudo apt-get update -y
}

fun_upgrade () {
    sudo apt-get upgrade -y
}

fun_limpiarepositorios () {
##LIMPA ROOT
sudo rm -rf /root/install.sh > /dev/null 2>&1
##LIMPA HTML
sudo rm -rf /var/www/html
[[ ! -d /var ]] && mkdir /var
[[ ! -d /var/www ]] && mkdir /var/www
[[ ! -d /var/www/html ]] && mkdir /var/www/html
}

##INSTALAR PAINEL
painel_inst () {
    wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/install.sh > /dev/null 2>&1; chmod +x install.sh; ./install.sh
}
painel_att () {
    wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/update.sh > /dev/null 2>&1; chmod +x update.sh; ./update.sh
}

##PAINIL REMOVE
remove_painel () {
clear
echo -e "$barra"
echo -e "\033[1;32m SEMPRE CONFIRME COM \033[1;37mY"
echo -e "\033[1;32m PROSSIGA COM \033[1;37mENTER"
echo -e "$barra"
sleep 7
sudo service apache2 stop
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo rm -rf /etc/mysql /var/lib/mysql
sudo rm -rf /var/www/html
sudo apt-get autoremove
sudo apt-get autoclean
apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
sudo service apache2 stop
[[ ! -d /var/www ]] && mkdir /var/www
[[ ! -d /var/www/html ]] && mkdir /var/www/html
echo -e "$barra"
echo -e "\033[1;36mPAINEL REMOVIDO COM ÊXITO \033[1;32m[!OK]"
echo -e "$barra"
}

##CLEAN HTML FOLDER
clean_htmlfolder () {
clear
echo -e "$barra"
echo -e "\E[41;1;37m        â‡± LIMPAR A PASTA HTML â‡²                  \E[0m"
echo -e "$barra"
echo -e " "
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mATUALIZANDO... "; fun_prog 'fun_update'
echo -e " "
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mOTIMIZANDO... "; fun_prog 'fun_upgrade'
echo -e " "
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mLIMPANDO PASTA HTML... "; fun_prog 'fun_limpiarepositorios'
echo -e " "
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mRETORNANDO... "; fun_prog 'sleep 3'
sleep 1
echo -e " "
sudo rm -rf /root/painelweb.sh > /dev/null 2>&1
wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/painelweb.sh > /dev/null 2>&1
chmod +x painelweb.sh; ./painelweb.sh
}

while true $x != "ok"
do
clear
echo -e "$barra"
echo -e "\E[41;1;37m         INSTALAR E ATUALIZAR PAINEL GESTOR-SSH         \E[0m"
echo -e "$barra"
echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37 \033[1;33mINSTALAR PAINEL GESTOR-SSH      \033[1;31m(FINAL) 
\033[1;31m[\033[1;36m02\033[1;31m] \033[1;37 \033[1;33mATUALIZAR PAINEL GESTOR-SSH    \033[1;32m(BETA) 
\033[1;31m[\033[1;36m03\033[1;31m] \033[1;37 \033[1;33mLIMPAR A PASTA HTML 
\033[1;31m[\033[1;36m04\033[1;31m] \033[1;37 \033[1;33mREMOVER PAINEL
\033[1;31m[\033[1;36m00\033[1;31m] \033[1;37 \033[1;33mSAIR \033[1;32m<\033[1;33m<\033[1;31m<\033[0m \033[0m"
echo -e "$barra"
echo ""
echo -ne "\033[1;32mO QUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
   1 | 01)
   clear
   painel_inst
   exit;
   ;;
   2 | 02)
   clear
   painel_att
   exit;
   ;;
   3 | 03)
   clear
   clean_htmlfolder
   exit;
   ;;
   4 | 04)
   clear
   remove_painel
   exit;
   ;;
   0 | 00)
   echo -e "\033[1;31mSaindo...\033[0m"
   sleep 2
   clear
   exit;
   ;;
   *)
   echo -e "\n\033[1;31mOpcao inválida !\033[0m"
   sleep 2
esac
done
}
#fim
