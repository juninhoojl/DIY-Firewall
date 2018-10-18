# Transforma lista de IPs e Links em somente IPs no caso dos whites
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

require "resolv" #lib para transformar links em ips
require "ipaddress" # exige instalar:  gem install ipaddress

#caminhos
arq_entrada = '../manual/manual.white'
arq_saida = '../out/lista.white'

#lendo arquivo com entradas
val_entrada = File.readlines(arq_entrada).map do |line|
	  line.split.map(&:to_s)
	end
#selecionando somente a coluna 0
val_entrada.map! {|row| row[0]}

#lista dos que ja sao ips
ja_ip = []
#lista dos que ainda nao sao ips
n_ip = []
#lista escrita final
som_ips = []
#lista dos retornos sem conferir 
retornos = []
##lista ok recebe somente os que sao ips
lista_ok = []

#conferindo quais ja sao ips
val_entrada.each do |item|

	if IPAddress.valid?(item)	#se ja for IP
		ja_ip << item
	else		#se nao for IP
		n_ip << item
	end

end

#recebe os retornos/ips de cada host
n_ip.each do |item|
	retornos += Resolv.getaddresses(item)
end

#confere se existia algum que ja era ip
som_ips += ja_ip if ja_ip != []

#somente se existir algum retorno
if retornos != []

	retornos.each do |item| 
		#confere se todos os retornos sao realmente ips
		lista_ok << item if IPAddress.valid?(item)
	end

end

#junta o som-ips com a lista ok se ela nao for nula
som_ips += lista_ok if lista_ok != []

#criar arquivo de saida
saida_arquivo = File.new(arq_saida, "w")

#escreve no arquivo caso tenha algo e somente entradas diferentes
saida_arquivo.puts som_ips.uniq if som_ips != []
	
#fechando arquivo de saida
saida_arquivo.close


