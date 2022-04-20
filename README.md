#Acessa Root!

wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/senharoot.sh && chmod 777 senharoot.sh && ./senharoot.sh

#INSTALAR PAINELWEB GESTOR-SSH!

apt update && apt upgrade -y && apt install dos2unix -y && wget -o- https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/painelVXX/install && chmod 777 install &&./install

#ATUALIZAR PAINELWEB GESTOR-SSH!

apt update && apt upgrade -y && apt install dos2unix -y && wget -o- https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/painelVXX/update && chmod 777 update &&./update

#Sincronizador de painel SSH atualizado!

apt update && apt upgrade -y && apt install dos2unix -y && wget -o- https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/sincpainel/inst.sh && chmod 777 inst.sh &&./inst.sh
