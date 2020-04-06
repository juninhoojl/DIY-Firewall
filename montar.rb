# Função Para Juntar Listas
# José Luiz Corrêa Junior - juninhoojl
# Escrito em Ruby
# ----------------------------------------

#Funcao para separar black e white
def separarManual
    system( "ruby separar.rb" )
end

#Funcao para juntar lista dos paises
def listaPaises
    system( "cd lib && ruby paises.rb" )
end

#Funcao para juntar lista dos ataques
def listaAtaques
    system( "cd lib && ruby ataques.rb" )
end

#Funcao para montar lista black
def listaBlack
    system( "cd lib && ruby black.rb" )
end

#Funcao para montar lista white
def listaWhite
    system( "cd lib && ruby white.rb" )
end

#Funcao para separar Black e White
t0 = Thread.new{separarManual()}

#Monta Lista dos Paises
t1 = Thread.new{listaPaises()}

#Monta Lista dos Ataques
t2 = Thread.new{listaAtaques()}

#Somente continua se ja tiver separado
t0.join

#Monta Lista dos Black Manual
t3 = Thread.new{listaBlack()}

#Monta Lista dos White Manual
t4 = Thread.new{listaWhite()}

#Aguarda as duas terminarem
t1.join
t2.join
t3.join
t4.join


