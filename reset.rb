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
out='out/'

FileUtils.rm_rf(out)

