#Acessa Root!

wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/senharoot.sh && chmod 777 senharoot.sh && ./senharoot.sh

#INSTALAR PAINEL Vxx!

apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/painelVXX/install && chmod 777 install && ./install

#ATUALIZAR PAINEL Vxx!

wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/painelVXX/update && chmod 777 update && ./update

#Sincronizador de painel SSH atualizado!

apt-get install dos2unix && wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/sincpainel/inst.sh && dos2unix inst.sh && chmod +x inst.sh && ./inst.sh
