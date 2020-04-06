# Programa Para Somente Atualizar, sem gerar
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#Funcao para atualizar lista de paises
def atualPaises
   system( "cd sh && ./atual_paises.sh" )
end

#Funcao para atualizar a lista de ataques
def atualAtaques
   system( "cd sh && ./atual_ataques.sh" )
end

#Paraleliza funcoes de atualizacao
t1 = Thread.new{atualPaises()}
t2 = Thread.new{atualAtaques()}

#Aguarda t1 e t2 terminarem
t1.join
t2.join

