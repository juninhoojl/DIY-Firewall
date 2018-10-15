# Recebe uma entrada e dá uma saida desduplicando
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#caminhos dos arquivos
arq_entrada = './entrada.txt'
arq_saida = './saida.txt'

#lendo arquivo com entradas
val_entrada = File.readlines(arq_entrada).map do |line|
	  line.split.map(&:to_s)
	end
#selecionando somente a coluna 0
val_entrada.map! {|row| row[0]}

#criando arquivo de saida
saida_arquivo = File.new(arq_saida, "w")

#escrevendo no arquivo de saida com metodo unic
saida_arquivo.puts val_entrada.uniq

#fechando arquivo de saida
saida_arquivo.close