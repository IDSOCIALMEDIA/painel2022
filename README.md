# SINCRONIZAR NA VPS, COMPATÍVEL COM O PAINEL GESTOR-SSH!
# ATUALIZAÇÃO 29/04/2022.
```
apt install dos2unix -y; wget https://raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/sincpainel && chmod +x sincpainel && dos2unix sincpainel && ./sincpainel
```

# INSTALAR OU ATUALIZAR PAINELWEB GESTOR-SSH DEBIAN 8! ATUALIZAÇÃO 29/04/2022.
```
apt-get update -y; apt-get upgrade -y apt-get install dos2unix -y; bash <(wget -qO- raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/instpainel)
```

# DEFINIR/ALTERAR SENHA ROOT
```
wget raw.githubusercontent.com/nandoslayer/plusnssh/ntech/gestorssh/senharoot ; bash senharoot
```
