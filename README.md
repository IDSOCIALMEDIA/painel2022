# ACESSO ROOT!

bash <(wget -qO- github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/senharoot)

# INSTALAR PAINELWEB GESTOR-SSH DEBIAN 8!

apt upgrade -y && apt install dos2unix -y && wget -o- https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/install && chmod 777 install &&./install

# SINCRONIZAR NA VPS, COMPATÍVEL COM O PAINEL GESTOR-SSH!

apt install dos2unix -y && wget -o- github.com/nandoslayer/plusnssh/raw/ntech/gestorssh/inst && chmod 777 inst &&./inst

# ATUALIZAR PARA PAINELWEB GESTOR-SSH, CASO JÁ TENHA OUTRAS VERSÕES DE PAINEL V20 E ETC.. EM DEBIAN 8!
# NÂO TEM NESSECIDADE SE ACABOU DE INSTALAR, JÁ VAI ESTÁ ATUALIZADO!
# TBM ATUALIZA CASO TENHA NOVAS CONFIGURAÇÕES NO V2022!

apt install dos2unix -y && wget -o- https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/update && chmod 777 update &&./update
