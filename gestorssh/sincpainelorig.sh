#!/bin/bash
clear
echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
rm *.sh* > /dev/null 2>&1
rm *.zip* > /dev/null 2>&1
apt install unzip -y > /dev/null 2>&1
wget github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/sshplus.zip.001 > /dev/null 2>&1
wget github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/sshplus.zip.002 > /dev/null 2>&1
wget github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/sshplus.zip.003 > /dev/null 2>&1
sleep 2
cat sshplus.zip* > monitor.zip && zip -F monitor.zip > /dev/null 2>&1
rm -rf /opt/sshplus > /dev/null 2>&1
unzip monitor.zip -d  /opt/sshplus/ > /dev/null 2>&1
chmod 777 /opt/sshplus/*-sync > /dev/null 2>&1
sleep 2
if [[ -e "/opt/sshplus/licenca.txt" ]]; then
sed -i "s;NAND-OCRA-CKED;$crack;g" /opt/sshplus/licenca.txt > /dev/null 2>&1
else  [[ -e "/opt/sshplus/licenca.txt" ]];
sed -i "s;NAND-OCRA-CKED;NAND-OCRA-CKED;g" /opt/sshplus/licenca.txt > /dev/null 2>&1
fi
wget github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/sincpainel.zip > /dev/null 2>&1
unzip sincpainel.zip > /dev/null 2>&1
chmod 777 *sh
service ssh restart
echo -e "\n\033[1;32mCONCLUIDO!\033[0m"
sleep 1.5
cat /dev/null > ~/.bash_history && history -c && clear
echo -e "\033[1;36mENTRE NO PAINEL E CRIE UMA CONTA SSH PRA VER SE ESTA TUDO OK!\033[0m"
rm -rf sincpainel* *.zip* > /dev/null 2>&1
clear
menu
