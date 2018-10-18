# Programa Para Atualizar e Gerar Listas
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

#Funcao para juntar lista dos paises
def listaPaises
    system( "cd lib && ruby paises.rb" )
end

#Funcao para juntar lista dos ataques
def listaAtaques
    system( "cd lib && ruby ataques.rb" )
end

#Paraleliza funcoes de atualizacao
t1 = Thread.new{atualPaises()}
t2 = Thread.new{atualAtaques()}

#Aguarda t1 terminar
t1.join

#Monta Lista dos Paises
t3 = Thread.new{listaPaises()}

#Aguarda as duas terminarem
t3.join

#Aguarada t2 terminar
t2.join

#Monta Lista dos Ataques
t4 = Thread.new{listaAtaques()}

#Aguarada t2 terminar
t4.join

