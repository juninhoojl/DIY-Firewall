# Função Para Resetar Arquivos e Listas do Sistema
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#Modulo para lidar com arquivos
require 'fileutils'

# Deleta arquivos da pasta out
# Cria novas listas de flags com base na quantidade de itens que usam
# Cria x linhas setado para zero
# Zera todas as regras de firewall

#Caminhos
out='out' #Diretorio resultado
flags='flags'
flagsPaises='./flags/paises.flag'
flagVpn='./flags/vpn.flag'
flagAtaques='./flags/ataques.flag'

#Caminhos quantidades a criar
qtdcod='./data/paises.cod' #Paises
qtdatk='./data/nomes.ataques' #Ataques

#Deleta arquivos de saida
FileUtils.rm_rf Dir.glob("#{out}/*")

#Deleta arquivos de flag
FileUtils.rm_rf Dir.glob("#{flags}/*")

#Conta quantidade de paises pelos codigos
qtdpaises = `wc -l "#{qtdcod}"`.strip.split(' ')[0].to_i

#Conta quantidade de ataques pelos nomes
qtdataques = `wc -l "#{qtdatk}"`.strip.split(' ')[0].to_i

#Recria arquivo com flag VPN
File.open(flagVpn, 'w') { |file| file.write 0 }

#Cria flags resetadas para paises
File.open(flagsPaises, 'w') { |file| qtdpaises.times{ file.puts 0 } }

#Cria flags resetadas para ataques
File.open(flagAtaques, 'w') { |file| qtdataques.times{ file.puts 0 } }













