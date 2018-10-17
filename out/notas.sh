#Limpa as regras
iptables -F


. /caminhoarquivo

	Meu arquivo


	#comeca aqui

	#State Full

	IPT=/sbin/iptables


	#Acrescenta regra (a)
	#(j) o que faz depois (acao)
	#(m) modulo
	#conntrack para checar pacote por pacote
	$IPT -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	#-p diz o protocolo
	#gre protocolo usado em vpn
	#bloqueia vpn
	$IPT -A FORWARD -p gre -j DROP

	#Ja bloqueia o que considere invalido, sabe que é inutil

	$IPT -A FORWARD -m conntrack --ctstate INVALID -j DROP

	#Aqui comecaria o arquivo

	#
	$IPT -A FORWARD -d ipOUrede -j DROP

	for variavel in `cat /caminhoarquivo/nome; do

		#o 
			$IPT -A FORWARD -d "$variavel" -j DROP
	done

	#SEMPRE ACEITA O RESTO
	$IPT -A FORWARD -j ACCEPT



	
