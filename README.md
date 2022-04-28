# ATUALIZAR PACOTES DO SISTEMA
```
apt-get update -y; apt-get upgrade -y;
```

# SINCRONIZAR NA VPS, COMPATÍVEL COM O PAINEL GESTOR-SSH!
# ATUALIZAÇÃO 28/04/2022.
```
apt install dos2unix -y; wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/sincpainel && chmod +x sincpainel && dos2unix sincpainel && ./sincpainel
```

# ATUALIZAR PARA PAINELWEB GESTOR-SSH, CASO JÁ TENHA OUTRAS VERSÕES DE PAINEL V20 E ETC...
# EM DEBIAN 8 OU UBUNTU 14! NÂO TEM NESSECIDADE SE ACABOU DE INSTALAR, JÁ VAI ESTÁ ATUALIZADO!
# ATUALIZAÇÃO 28/04/2022.
```
apt install dos2unix -y; wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/update && chmod +x update && dos2unix update && ./update
```

# INSTALAR PAINELWEB GESTOR-SSH DEBIAN 8 OU UBUNTU 14!
```
wget raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/install ; bash install
```

# DEFINIR/ALTERAR SENHA ROOT
```
wget raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/senharoot ; bash senharoot
```
