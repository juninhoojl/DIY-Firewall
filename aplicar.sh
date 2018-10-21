# Programa para Aplicar (Regras no IpTables)
# José Luiz Corrêa Junior - juninhoojl
# Escrito em ShellScript
# ----------------------------------------
#!/bin/bash

black=./out/lista.black
paises=./out/lista.paises

#OBS. Bloqueia destino, por serem muitos
# -A (Acrescenta Regra)
# -m (Especifica que esta solicitando modulo)
# -j (Acao para uma dada situacao)
# -p (Especifica um protocolo)
# --(Modulo conntrack, para checar conexao)

#Caminhos paises
set_paises=setpaises
rest_paises=./out/lista.paises
#Caminhos ataques
set_ataques=setataques
rest_ataques=./out/lista.ataques
#Caminhos black
set_black=setblack
rest_black=./out/lista.black
#Caminhos white
set_white=setwhite
rest_white=./out/lista.white

#Confere se o ipset de paises existe
ipset -L "$set_paises" >/dev/null 2>&1
if [ $? -ne 0 ]; then #Se nao existir

	#Cria o set
	ipset create "$set_paises" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_paises"
	
else #Se existir

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

	#Deleta o set
	ipset destroy "$set_black"

	#Cria o set com tamanho maximo 999999
	ipset create "$set_black" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_black"

fi


#Confere se o ipset white manual existe
ipset -L "$set_black" >/dev/null 2>&1
if [ $? -ne 0 ]; then #Se nao existir

	#Cria o set com tamanho 999999
	ipset create "$set_white" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_white"
	
else #Se existir

	#Deleta o set
	ipset destroy "$set_white"

	#Cria o set com tamanho maximo 999999
	ipset create "$set_white" hash:net maxelem 999999

	#Carrega ipset com restore
	ipset restore < "$rest_white"

fi

#Limpa todas as regras do iptables
iptables -F

#Para State Full
$IPT -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#Ja bloqueia o que considere invalido, sabe que é inutil
$IPT -A FORWARD -m conntrack --ctstate INVALID -j DROP

#Regra que aceita white manual do set especifico
iptables -A FORWARD -m set --match-set "$set_white" dst -j ACCEPT

#Regra que bloqueia black manual do set especifico
iptables -A FORWARD -m set --match-set "$set_black" dst -j DROP

#Regra que bloqueia paises do set especifico
iptables -A FORWARD -m set --match-set "$set_paises" dst -j DROP

#Regra que bloqueia ataques do set especifico
iptables -A FORWARD -m set --match-set "$set_ataques" dst -j DROP
