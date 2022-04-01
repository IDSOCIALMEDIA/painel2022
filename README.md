#Acessa Root!

wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/senharoot.sh && chmod 777 senharoot.sh && ./senharoot.sh

#Instalar painel versões!

apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/painelVXX/painelvXX.sh /dev/null 2>&1; chmod +x painelvXX.sh; ./painelvXX.sh

#Sincronizador de painel SSH atualizado!

wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/sincpainel/install && chmod 777 install && ./install
