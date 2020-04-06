# Atualização do arquivo das faixas de cada país
# José Luiz Corrêa Junior - juninhoojl
# Escrito em ShellScript
# ----------------------------------------
#!/bin/bash

#caminhos
link_ping=www.google.com
link=https://www.ipdeny.com/ipblocks/data/countries/all-zones.tar.gz
pasta_atual=../data/all-zones

#Antes de executar checa se está conectado
if ping -c 1 $link_ping ; then

	#download do arquivo compactado com as listas
	wget $link --no-check-certificate

	#Verifica se existe pasata atual
	if [ -d "$pasta_atual" ]; then
		#deletar pasta atual
		rm -r $pasta_atual
	fi
		#criar pasta nova
		mkdir $pasta_atual

	#descompactar arquivo baixado
	tar -xvzf all-zones.tar.gz -C $pasta_atual

	#remove o arquivo sem descompactar
	rm all-zones.tar.gz

fi

exit
