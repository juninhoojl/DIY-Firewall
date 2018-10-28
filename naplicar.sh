# Programa para Aplicar (Regras no IpTables)
# José Luiz Corrêa Junior - juninhoojl
# Escrito em ShellScript
# ----------------------------------------
#!/bin/bash

#OBS. Bloqueia destino, por serem muitos
# -A (Acrescenta Regra)
# -m (Especifica que esta solicitando modulo)
# -j (Acao para uma dada situacao)
# -p (Especifica um protocolo)
# --(Modulo conntrack, para checar conexao)

#Caminho e nome montar arquivos
montar=montar.rb

#Executa modulo para montar
ruby montar.rb

#Caminhos paises e nome
set_paises=setpaises
rest_paises=./out/lista.paises
#Caminhos ataques e nome
set_ataques=setataques
rest_ataques=./out/lista.ataques
#Caminhos black e nome
set_black=setblack
rest_black=./out/lista.black
#Caminhos white e nome
set_white=setwhite
rest_white=./out/lista.white


#Limpa todas as regras do iptables (para nao estar em uso, os sets)
iptables -F

#Confere se o ipset de paises existe
ipset -L "$set_paises" >/dev/null 2>&1
if [ $? -ne 0 ]; then #Se nao existir

	#Cria o set
	ipset create "$set_paises" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_paises"
	
else #Se existir

	#Tem que limpar
	ipset flush "$set_paises"

	#Deleta o set
	ipset destroy "$set_paises"

	#Cria o set
	ipset create "$set_paises" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_paises"

fi


#Confere se o ipset de ataques existe
ipset -L "$set_ataques" >/dev/null 2>&1
if [ $? -ne 0 ]; then #Se nao existir

	#Cria o set com tamanho 999999
	ipset create "$set_ataques" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_paises"
	
else #Se existir

	#Tem que limpar
	ipset flush "$set_ataques"

	#Deleta o set
	ipset destroy "$set_ataques"

	#Cria o set com tamanho maximo 999999
	ipset create "$set_ataques" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_ataques"

fi


#Confere se o ipset black manual existe
ipset -L "$set_black" >/dev/null 2>&1
if [ $? -ne 0 ]; then #Se nao existir

	#Cria o set com tamanho 999999
	ipset create "$set_black" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_black"
	
else #Se existir

	#Tem que limpar
	ipset flush "$set_black"

	#Deleta o set
	ipset destroy "$set_black"

	#Cria o set com tamanho maximo 999999
	ipset create "$set_black" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_black"

fi


#Confere se o ipset white manual existe
ipset -L "$set_white" >/dev/null 2>&1
if [ $? -ne 0 ]; then #Se nao existir

	#Cria o set com tamanho 999999
	ipset create "$set_white" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_white"
	
else #Se existir

	#Tem que limpar
	ipset flush "$set_white"

	#Deleta o set
	ipset destroy "$set_white"

	#Cria o set com tamanho maximo 999999
	ipset create "$set_white" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_white"

fi


#Para State Full
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#Ja bloqueia o que considere invalido, sabe que é inutil
iptables -A FORWARD -m conntrack --ctstate INVALID -j DROP

#Regra que bloqueia black manual do set especifico
iptables -A FORWARD -m physdev --physdev-in eth1 -m set --match-set "$set_black" dst,dst -j DROP

#Regra que bloqueia paises do set especifico
iptables -A FORWARD -m physdev --physdev-in eth1 -m set --match-set "$set_paises" dst,dst -j DROP

#Regra que bloqueia ataques do set especifico
iptables -A FORWARD -m physdev --physdev-in eth1 -m set --match-set "$set_ataques" dst,dst -j DROP
