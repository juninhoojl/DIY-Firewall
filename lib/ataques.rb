# Junção de cada tipo da ataque a ser bloqueado
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#caminhos
arquivo_marcadores = '../flags/ataques.flag'
arquivo_bloquear = '../out/lista.ataques'
arquivo_listas = '../data/atak/'
tipo_ataques = '../data/nomes.ataques'
nome_set = 'BlockPaises'

#Abre arquivo com marcadores do status atual, bloqueado = 1, nao = 0
marcadores = File.readlines(arquivo_marcadores).map do |line|
	  line.split.map(&:to_s)
	end

#Faz a leitura do arquivo com os nomes dos arquivos que devem ser incluidos
nomes_ataques = File.readlines(tipo_ataques).map do |line|
	  line.split.map(&:to_s)
	end

#array com todos os enderecos
enderecos = []

#for alinhado para checagem
for i in 0...marcadores.size do

	if marcadores[i][0] == '1'#se marcador = 1, então bloquear

		#Nome do arquivo especifico
		nome_especifico = nomes_ataques[i][0]

		nome_existencia = arquivo_listas + nome_especifico
		#Checa existencia do arquivo
		if File.file?(nome_existencia)

			#faz a leitura
			lido = File.readlines(nome_existencia).map do |line|
		  			line.split.map(&:to_s)
				end

			#array recebe tudo dele
			enderecos += lido
			
		end
		
	end

end

#criar arquivo de saida
saida_arquivo = File.new(arquivo_bloquear, "w")

#Verifica que é unico
if enderecos != []
	enderecos = enderecos.uniq
end

#escrevendo nele
enderecos.each do |item|
	saida_arquivo.puts "add #{nome_set} #{item[0]} -exist"
end

#fechar arquivo de saida
saida_arquivo.close

