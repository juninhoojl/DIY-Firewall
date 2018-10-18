# Função Para Juntar Listas
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#Funcao para juntar lista dos paises
def listaPaises
    system( "cd lib && ruby paises.rb" )
end

#Funcao para juntar lista dos ataques
def listaAtaques
    system( "cd lib && ruby ataques.rb" )
end

#Monta Lista dos Paises
t3 = Thread.new{listaPaises()}

#Monta Lista dos Ataques
t4 = Thread.new{listaAtaques()}

#Aguarda as duas terminarem
t3.join
t4.join

#Aqui já teria que rodar o programa que aplica as regras (aplicar.rb)