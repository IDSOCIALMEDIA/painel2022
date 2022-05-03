#!/bin/bash
clear
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
clear
echo -e "\E[44;1;37m    INSTALAR PAINEL PWEB GESTOR-SSH     \E[0m" 
echo ""
echo -e "                 \033[1;31mBy @nandoslayer\033[1;36m"
echo ""
echo -ne "\n\033[1;32mDE UM ENTER PARA \033[1;33mCONTINUAR...\033[1;37m: "; read -r
clear
echo -e "\n\033[1;36mINICIANDO INSTALAÇÃO \033[1;33mAGUARDE..."
yum update -y
yum upgrade -y
yum install epel-release -y
yum install figlet -y
rm /bin/pweb
sleep 5
cd /bin || exit
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/cent7/pweb
chmod 777 pweb
clear
mkdir /bin/ppweb
cd /bin/ppweb || exit
rm *.sh
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/cent7/instcent7.sh
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/cent7/senharoot.sh 
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/cent7/restbanco.sh
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/cent7/empresa.sh
wget https://github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/cent7/updatepainel.sh
chmod -R 777 /bin/ppweb
clear
echo -e "        \033[1;33m • \033[1;32mINSTALAÇÃO CONCLUÍDA\033[1;33m • \033[0m"
echo ""
echo -e "\033[1;31m \033[1;33mCOMANDO PRINCIPAL: \033[1;32mpweb\033[0m"
echo -e "\033[1;33m MAIS INFORMAÇÕES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@nandoslayer\033[0m"
cat /dev/null > ~/.bash_history && history -c
rm *.sh
exit