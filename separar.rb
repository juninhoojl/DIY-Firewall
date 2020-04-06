# Programa Para Separar blacks e whites
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#caminhos
arq_black = './manual/manual.black'
arq_white = './manual/manual.white'
arq_misto = './manual/manual.misto'

#Se inicia com @ vai para black

#lendo arquivo com entradas
val_misto = File.readlines(arq_misto).map do |line|
	  line.split.map(&:to_s)
	end
#selecionando somente a coluna 0
val_misto.map! {|row| row[0]}

#criar arquivos de saida
saida_black = File.new(arq_black, "w")
saida_white = File.new(arq_white, "w")

#conferindo quais sao para bloquear
val_misto.each do |item|

	if item[0] == '@'
		#escrevendo em black
		saida_black.puts item[1..(item.size)]
	else
		#escrevendo em white
		saida_white.puts item
	end
end

#fechando arquivos de saida
saida_black.close
saida_white.close




	









