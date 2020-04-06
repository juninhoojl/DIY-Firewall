# Função Para Resetar Arquivos e Listas do Sistema
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#Modulo para lidar com arquivos
require 'fileutils'

#Caminhos
out='out' #Diretorio resultado
flagsPaises='./flags/paises.flag'
flagVpn='./flags/vpn.flag'
flagAtaques='./flags/ataques.flag'
black='./manual/manual.black' #Manual black
white='./manual/manual.white' #Manual white
misto='./manual/manual.misto' #Manual misto
#Caminhos quantidades a criar
qtdcod='./data/paises.cod' #Paises
qtdatk='./data/nomes.ataques' #Ataques
#Caminho arquivos out, criar vazios
whiteout='./out/lista.white'
blackout='./out/lista.black'
paisesout='./out/lista.paises'
ataquesout='./out/lista.ataques'

t1 = Thread.new{
	#Recria arquivo com flag VPN
	File.open(flagVpn, 'w') { |file| file.write 0 }
	#Deleta arquivos de saida
	FileUtils.rm_rf Dir.glob("#{out}/*")
}

t2 = Thread.new{
	#Cria flags resetadas para paises
	File.open(flagsPaises, 'w') { |file| (`wc -l "#{qtdcod}"`.strip.split(' ')[0].to_i).times{ file.puts 0 } }

}

t3 = Thread.new{
	#Cria flags resetadas para ataques
	File.open(flagAtaques, 'w') { |file| (`wc -l "#{qtdatk}"`.strip.split(' ')[0].to_i).times{ file.puts 0 } }
}

t4 = Thread.new{
	#Esvazia arquivo manual.white
	whitefile = File.new(white, "w")
	whitefile.close
	#Esvazia arquivo manual.black
	blackfile = File.new(black, "w")
	blackfile.close
	#Esvazia arquivo manual.misto
	mistofile = File.new(misto, "w")
	mistofile.close
	
}

#Aguarda Terminarem
t1.join
t2.join
t3.join
t4.join

#chama funcao para montar tudo vazio
system( "ruby montar.rb")

#Reseta regras do IPtables
system( "iptables -F")

#Reseta entradas no banco de dados







