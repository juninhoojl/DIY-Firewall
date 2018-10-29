import mysql.connector
import sys,os
from Naked.toolshed.shell import execute_rb
import socket


mydb = mysql.connector.connect(
    host="162.241.2.202",
    database="andredev_trabalho_redes2",
    user="andredev_redes2",
    passwd="redes2"
)

mycursor = mydb.cursor()


def exibirValidarIpPaises():
    mycursor.execute("SELECT * FROM validarippaises")
    for tb in mycursor:
       print(tb)


def validarIpPaises():
    arq = open('./flags/paises.flag', 'w')
    mycursor.execute("SELECT * FROM validarippaises")
    for row in mycursor:
        print(row[2], file=arq)
    arq.close()
    execute_rb('./lib/paises.rb')


def zerarFlagsValidarIpPaises():
    mycursor.execute("UPDATE validarippaises SET FLAG=0")


def selecionarFlagsValidarIpPaises():
    mycursor.execute("UPDATE validarippaises SET FLAG=1")


def exibirPaisesBloqueados():
    mycursor.execute("SELECT PAIS FROM validarippaises WHERE FLAG=1")
    for tb in mycursor:
        print(tb)


def exibirPaisesLivres():
    mycursor.execute("SELECT PAIS FROM validarippaises WHERE FLAG=0")
    for tb in mycursor:
        print(tb)


def bloquearPaisEspecifico():
    while 1:
        mycursor.execute('SELECT * FROM validarippaises WHERE FLAG="0"')
        for tb in mycursor:
           print(tb)

        escolha = input("Digite o código do país(0=Voltar): ")
        if escolha == "0":
            return
        else:
            mycursor.execute('UPDATE validarippaises SET FLAG=1 WHERE ID="'+escolha+'"')
            os.system("cls")


def liberarPaisEspecifico():
    while 1:
        mycursor.execute('SELECT * FROM validarippaises WHERE FLAG="1"')
        for tb in mycursor:
           print(tb)

        escolha = input("Digite o código do país(0=Voltar): ")
        if escolha == "0":
            return
        else:
            mycursor.execute('UPDATE validarippaises SET FLAG=0 WHERE ID="'+escolha+'"')
            os.system("cls")


def adicionarLinkEspecifico():
    link = input("Digite o link/IP a ser bloqueado: ")
    mycursor.execute('INSERT INTO linksespecificos(ALVO) VALUES ("'+link+'")')
    validarLinks()


def validarLinks():
    arq = open('./manual/manual.txt', 'w')
    mycursor.execute('SELECT * FROM linksespecificos')
    for row in mycursor:
        print(row[1], file=arq)
    arq.close()


def exibirLinksBloqueados():
    mycursor.execute('SELECT * FROM linksespecificos')
    for tb in mycursor:
        print(tb)


def removerLinkEspecifico():
    exibirLinksBloqueados()
    cod = input("Digite o código a ser liberado: ")
    mycursor.execute('DELETE FROM linksespecificos WHERE ID="'+cod+'"')
    mycursor.execute('ALTER TABLE linksespecificos AUTO_INCREMENT = 1')
    validarLinks()


def menu():
    validarIpPaises()
    while 1:
        menu = True
        while menu:
            print("""
            --------------------------
            IP local: """ + socket.gethostbyname(socket.gethostname())+"""
            --------------------------
            MENU PRINCIPAL
            1.Adicionar na Blacklist
            2.Adicionar na WhiteList
            3.Exibir
            4.Validar tabela de países
            5.Sair 
            --------------------------
            """)
            menu = input("Escolha uma opção: ")
            if menu == "1":
                print("""
                     --------------------------
                    MENU - BLACKLIST
                    1.País específico
                    2.Ip específico
                    3.Todos países
                    --------------------------
                    """)
                menuBlacklist = input("Escolha uma opção: ")
                if menuBlacklist == "1":
                    bloquearPaisEspecifico()
                    validarIpPaises()
                elif menuBlacklist == "2":
                    adicionarLinkEspecifico()
                elif menuBlacklist == "3":
                    selecionarFlagsValidarIpPaises()
                    validarIpPaises()
                elif menuBlacklist != "":
                    print("\n Opção Invalida. Tente Novamente")
            elif menu == "2":
                print("""
                     --------------------------
                     MENU - BLACKLIST
                     1.País específico
                     2.Ip específico
                     3.Todos países
                     --------------------------
                    """)
                menuWhitelist = input("Escolha uma opção: ")
                if menuWhitelist == "1":
                    liberarPaisEspecifico()
                    validarIpPaises()
                elif menuWhitelist == "2":
                    removerLinkEspecifico()
                elif menuWhitelist == "3":
                    zerarFlagsValidarIpPaises()
                    validarIpPaises()
                elif menuWhitelist != "":
                    print("\n Opção Invalida. Tente Novamente")
            elif menu == "3":
                print("""
                    --------------------------
                    MENU - EXIBIÇÃO
                    1.Exibir todos países
                    2.Exibir países bloqueados
                    3.Exibir países não-bloqueados
                    4.Exibir links/IP's 
                    --------------------------
                    """)
                menuExibicao = input("Escolha uma opção: ")
                if menuExibicao == "1":
                    exibirValidarIpPaises()
                elif menuExibicao == "2":
                    exibirPaisesBloqueados()
                elif menuExibicao == "3":
                    exibirPaisesLivres()
                elif menuExibicao == "4":
                    exibirLinksBloqueados()
                elif menuExibicao != "":
                    print("\n Opção Invalida. Tente Novamente")
            elif menu == "4":
                validarIpPaises()
            elif menu == "5":
                exit()
            elif menu != "":
                print("\n Opção Invalida. Tente Novamente")


menu()