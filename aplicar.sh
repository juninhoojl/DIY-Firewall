# Programa para Aplicar (Regras no IpTables)
# José Luiz Corrêa Junior - juninhoojl
# Escrito em ShellScript
# ----------------------------------------
#!/bin/bash

#Limpa todas as regras
iptables -F

#Caminhos
IPT=/sbin/iptables
paises=./out/lista.paises
ataques=./out/lista.paises
#Falta implementar

white=./out/lista.paises #Lista a permitir
black=./out/lista.black #Lista a parte


#OBS. Bloqueia destino, por serem muitos
# -A (Acrescenta Regra)
# -m (Especifica que esta solicitando modulo)
# -j (Acao para uma dada situacao)
# -p (Especifica um protocolo)
# --(Modulo conntrack, para checar conexao)

#Para State Full
$IPT -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#Ja bloqueia o que considere invalido, sabe que é inutil
$IPT -A FORWARD -m conntrack --ctstate INVALID -j DROP

#Acao utilizando diretamente IP ou Rede
#$IPT -A FORWARD -d ipOUrede -j DROP

#!IMPORTANTE
#Bloqueia um dos protocolos usados em VPN
#$IPT -A FORWARD -p gre -j DROP

#Acrescentar Bloquear VPN ou nao
#Por meio de condicao de comparacao da primeira linha do arquivo

#Acrescentar listas aceitar aqui

#Acrescentar listas negar aqui

for linhas in `cat $black`; do

	#Bloqueia um destino todo, independente do protocolo
	$IPT -A FORWARD -m physdev --physdev-in eth0 -s "$linhas" -j DROP

done

#!!!!Lembrar de verificar se arquivo nao esta vazio

#Laco para aplicar regras dos paises
for linhas in `cat $paises`; do

	#Bloqueia um destino todo, independente do protocolo
	$IPT -A FORWARD -m physdev --physdev-in eth0 -s "$linhas" -j DROP

done

#Laco para aplicar regras dos ataques
for linhas in `cat $paises`; do

	#Bloqueia um destino todo, independente do protocolo
	$IPT -A FORWARD -m physdev --physdev-in eth0 -s "$linhas" -j DROP

done

#Somente garante que aceita o resto
#$IPT -A FORWARD -j ACCEPT



	
