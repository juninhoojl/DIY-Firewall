

![PinFusor](img_md/logo.png)


## Versão 1.0 - Outrubro 2018

### Recursos:

* Bloqueio por Paises
* Tipos de Ataques
* Bloqueio Manual
* Remocão Manual
* Interface web para manipular banco de dados

### Linguagens:

* Ruby
* Shell script
* Python
* HTML
* CSS
* JS
* SQL

### Desenvolvido Por

> 
> `Banco de Dados` - [André Vitor Beraldo](https://github.com/AndreBeraldo) 
> 
> `Firewall` - [José Luiz Corrêa Junior](https://github.com/juninhoojl) 
> 
> `Frontend` - Halyson Vinícius Morais - <halysonmorais@get.inatel.br>
> 
> `Frontend` - [Felipe dos Santos](https://github.com/SecureHub)

## Noções de Funcionamento

![Arquitetura](img_md/arq.png)

* O sistema é basicamente composto pela união de um roteador, um Raspberry Pi, um ponto de acesso e as interfaces que estarão conectadas à rede naquele momento. Os três primeiros componentes estarão interligados por um cabo de rede Ethernet, por onde os dados serão trafegados e todas interfaces poderão se conectar, via Wi-fi, ao ponto de acesso.

* O Raspberry Pi, como uma appliance, tem o objetivo de hospedar a aplicação gerenciadora do acesso à rede, a qual recebe todos os pacotes e os libera ou bloqueia ao ponto de acesso após o processamento dos filtros configurados. A aplicação é um software desenvolvido em Python, Ruby e Shell script que utiliza um banco de dados MySQL para receber tais configurações armazenadas e atualizadas da rede.

* As interfaces conectadas ao ponto de acesso têm a opção de utilizar uma aplicação Web, desenvolvida em Python, HTML, CSS e JS, para configurar as informações presentes no banco de dados.

**Obs.:** Todos programas utilizados pela arquitetura estarão disponíveis na internet.

## Hardware Necessário

**Observação:** Para reproduzir o que foi feito e desenvolvido por nós, basta um computador que possua pelo menos 2 interfaces de rede, porém, abaixo estão as especificações exatas do que foi usado!

* **1** Raspberry Pi 3 Model B
* **1** Cartão Micro Sd Ultra 32gb Classe10
* **1** Adaptador Lan Rede Gigabit Usb 3.0 Ethernet 10/100/1000
* **1** Cabo De Rede Ethernet 1m Metro Montado Rj45
* **1** Carregador De Tomada Usb Samsung 5.0v 2.0a
* **1** Cabo de dados usb com saída micro usb

![Step](img_md/step.gif)


## 0 - Banco de Dados (Em qualquer computador)

Na aplicação em questão, optou-se pela utilização de um banco MySQL hospedado, porém também pode ser utilizada uma rede local e em outros bancos de preferência, cabendo ao usuário apenas alterar o código para este.

**1 -** Para utilizarmos o MySQL, neste caso, devemos realizar o download de um servidor independente de plataforma. Existem diversos, como o XAMPP, WAMP, por exemplo, porém utilizaremos o primeiro. Depois de realizarmos seu download, precisamos  instalá-lo (apresenta instalação simples) e inicializá-lo. Após, devemos acionar o botão `Start` para o Apache e MySQL, trazendo um resultado como a imagem que segue. 

![Criando](img_md/xampp.png)

**2 -** Isso nos permite acessar o banco em rede local. Quando os serviços estiverem ativos, clicaremos no botão “Admin” do MySQL, que nos redirecionará ao phpMyAdmin, interface gráfica de aplicação do MySQL.

![Criando](img_md/phpmyadmin.png)

**3 -** O servidor estando ativo, agora precisamos gerar nosso banco de dados e tabelas. Anote estes dados, pois serão importantes à frente. Para criarmos um banco de dados, precisamos clicar no botão SQL e executar o comando a seguir:

```sql
CREATE DATABASE nome_banco;
	USE nome_banco;
```

Agora então devemos criar nossas tabelas. A aplicação em si contém duas tabelas, uma para validação de países a serem banidos e outra para armazenar os IP’s e/ou link de Website’s específicos. Lembre-se que o nome das tabelas e atributos devem ser exatamente iguais para que o programa funcione sem erros! Então basta copiar e colar as sentenças no banco de dados.

```sql
CREATE TABLE validarippaises (ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, PAIS VARCHAR(100) NOT NULL, FLAG TINYINT(1) NOT NULL);
CREATE TABLE linksespecificos (ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, ALVO VARCHAR(150));
```

Precisamos então inserir os países na primeira tabela. Para isso, devemos abrir o arquivo texto `PAÍSES.txt` presente na pasta do projeto. Copiaremos o conteúdo e acessaremos o mesmo botão `SQL` utilizado acima, colando e executando as linhas de código. Pronto, as tabelas estão criadas e funcionando. A seguir realizaremos a configuração do código da aplicação Desktop em função do banco de dados.

Ao abrir o código do arquivo `main.py`, encontramos na linha 7 a função connect, cujos parâmetros referenciam o local de hospedagem do banco (que pode ser localhost, 127.0.0.1 ou o IP de uma hospedagem), o nome do banco de dados que será utilizado, o nome e a senha do usuário, caso esteja usando um. O usuário deve preencher essa região com os dados referentes ao seu banco.

```sql
mydb = mysql.connector.connect(
	host="endereço",
	database="nome_banco",
	user="nome_usuario (se tiver)",
	passwd="senha_usuario (se tiver)"
)
```

## 1 - Baixando o Sistema Operacional

[Nesse endereço] (https://www.raspberrypi.org/downloads/raspbian/), faça o download do Raspbian Stretch Lite, clicando em `Download ZIP`:

![Raspbian](img_md/raspbian.png)


**Motivo da escolha do sistema operacional:**

O Raspbian é uma derivação do Debian, especifica para os computadores Raspberry®, logo, todo o hardware e sistema são totalmente compatíveis. Escolhemos a versão LITE, pois a interface gráfica não será necessária, e sendo assim, a utilização de recursos será melhor.


## 2 - Instalando o Sistema Operacional

Após ter o .zip, faça o download do software Etcher® [nesse endereço] (https://etcher.io), para facilitar a gravação da imagem no cartão SD, para instalar secione o .zip, selecione o drive e clique em `Flash!` (Esse processo pode demorar alguns minutos 👻)

![Etcher](img_md/etcher.gif)


## 3 - Habilitando o ssh
Após a instalação ter sido concluída, retire o cartão SD de seu computador e insira novamente, para ele ser montado, e então crie um arquivo com o nome “ssh” na raiz do drive de boot (Sem nenhum conteúdo dentro), isso fará com que o ssh esteja ativo na inicialização, portanto, não será necessário nenhum monitor para o procedimento. `É simples assim mesmo!!!`


![Etcher](img_md/ssh.png)

## 4 - "Dando Partida!"

Após ter criado o arquivo do passo 3, ejete o drive, e o insira no Raspberry, ligando também a fonte de energia e o cabo ethernet. (Aguarde alguns segundos e o sistema operacional terá iniciado) 👌🏻

![Etcher](img_md/rasp.png)


## 5 - Conectando por meio do ssh

Verifique o IP em que o o Raspberry se encontra e acesse um Terminal em seu computador, ou algum cliente ssh, e utilize o comando abaixo para acessar, utilize a senha padrão “raspberry”.(Lembre-se de substituir `xxx.xxx.xxx.xxx` pelo endereço que ele se encontra em sua rede)

```sh
ssh pi@xxx.xxx.xxx.xxx 

```
Pronto, você está logado em seu Raspberry agora!

**Dica:**
Uma maneira simples de descobrir qual endereço ele “pegou” a partir do DHCP de sua rede é utilizando o aplicativo [Fing](https://app.fing.io/login?backurl=https%3A%2F%2Fapp.fing.io%2Fapp), para dispositivos móveis, ou utilizando o comando `arp -a` no terminal, e note qual ip e mac se mostram novos, antes do boot dele.

## 6 - Criando SuperUser e Trocando  Senha Padrão

Para criar `SuperUser` digite o comando abaixo: 
(E então será solicitada uma nova senha UNIX, e sua confirmação 🔑)

```sh
sudo passwd 
```

*(Embora não será necessário, para logar como root digite: `su` e então será solicitada a senha, e para sair: `exit`)*

Por motivos de segurança iremos agora trocar a senha padrão, sendo está `raspberry`, pertencente ao usuário `pi`, sendo que a senha definida deverá ser usada para logar no futuro. Para isso, digite: 

```sh
sudo raspi-config
```

E então um menu com a opção de troca de senha aparecerá, como abaixo, e apenas siga as instuções:(Navege com as setas e a tecla `tab`) 


![Etcher](img_md/raspi-config.png)



**Obs.:** Agora quando for se logar novamente pelo ssh utilize a nova senha definida por você!

## 7 - Atualize os Pacotes e Sistema

Estando logado no Raspberry, digite o comando abaixo para atualizar os pacotes:

```sh
sudo apt-get update

```
E em seguida o comando abaixo para buscar por atualizações:

```sh
sudo apt-get upgrade
```
Caso haja alguma atualização, confirme com `Y` e aguarde a instalação, logo após ter sido concluída, digite o comando abaixo para reiniciar o sistema (Será necessário logar novamente):

```sh
sudo reboot now
```

## 8 - Clonando Repositório do Projeto

**1 -** Primeiro instale o git:

```sh
sudo apt-get install git
```

**2 -** Em seguida, Clone o Projeto para a Pasta `DIY-Firewall`:

* Se mova para a pasta de usuário

```sh
cd ~
```
* E então clone o Backend

```sh
sudo git clone https://github.com/juninhoojl/DIY-Firewall DIY-Firewall
```

* E o frontend, ou seja, a interface de usuário

```sh
sudo git clone https://github.com/AndreBeraldo/Interface_Web_Redes Front
```

**3 -** Dê Permissões Ao Diretório:

Com o comando abaixo será atribuída todas as possíveis permissões no diretório que contém todas as partes que são responsáveis por alterar regras, criar, deletar e afins.
*❗️(Obs.: Atente-se para ter certeza que o diretório se encontra na pasta de usuário, representada por `~`)*

```sh
sudo chmod -R 777 ~/DIY-Firewall
```

```sh
sudo chmod -R 777 ~/Front
```

**4 -** ❗️ Criar Atalhos de Execução

* Crie o atalho para o frontend com o comando:

```sh
sudo echo "alias infusor_front='sudo ~/Front/python __init__.py'" >~/.bashrc
```

* Crie o atalho para o backend com o comando:

```sh 
sudo echo "alias infusor_back='python3 ~/DIY-Firewall/infusor.py'" >~/.bashrc
```

* Aplique as Alterações:

```sh
source ~/.bashrc
```

## 9 - Instalar Ruby e Gem Necessária

Utilize o comando abaixo para instalar o interpretador da linguagem de programação Ruby:

```sh
sudo apt-get install ruby-full
```

Após instalar, instale também uma Gem que será necessária com o comando abaixo (Mais precisamente para converter endereços em IPS):

```sh
gem install ipaddress
```

**❓Por que ruby?**
Ruby foi escolhido para a maior parte dos programas/funções pois ela possui comandos complexos, que possibilitam fazer uma grande quantidade de coisas e operações com apenas uma linha simples ou uma pequena quantidade delas. Outra grande questão é a facilidade que a linguagem nos fornece para trabalhar com strings e caracteres, o que sem dúvida consiste em cerca de 50% das funcionalidades. Porém, foram usadas outras linguagens, como ShellScript e Python, de forma mais geral!


## 10 -  Instalar Python 3 e Módulos Necessários

Tendo o sistema operacional Raspbian instalado no Raspberry Pi, devemos adicionar algumas coisas. Em primeiro lugar, devemos instalar o Python na versão 3, uma vez que a versão 2 é o padrão do sistema. Para instalarmos o Python 3, devemos abrir o terminal e digitarmos alguns comandos.

* Digite o comando abaixo para atualizar os pacotes:

```sh
sudo apt-get update
```

* E esse outro:

```sh
sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev
```

* O comando acima instala algumas ferramentas requeridas para o procedimento. Agora realizaremos o download do Python3, sua descompactação e executaremos algumas configurações necessárias. Faça isso executando os comandos abaixo:

```sh
wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz
```
```sh
sudo tar xf Python-3.6.5.tar.xz
```
```sh
cd Python-3.6.5
```
```sh
sudo ./configure
```
```sh
sudo make
```
```sh
sudo make altinstall
```

**❗️Instalando Módulos Necessários:**	

A forma com que o Python executa seus programas pede para que o usuário tenha os módulos necessários pelo algoritmo para que tudo funcione. Então, para isso, será necessário que instalemos alguns métodos rapidamente. Para isso, utilizaremos os comandos abaixo:

```sh
sudo pip install mysqlclient
```

```sh
sudo pip install mysql-connector-python-rf
```

```sh
sudo pip install Naked
```

## 11 - Ajustes Antes de Configurar Rede Manualmente:

Antes de executar esse passo reinicie o sistema:

```sh
sudo reboot now
```
Depois de ter iniciado e logado, iremos para o `dhcpd` e retiralo da inicialização, pois utilizando esse recurso as configurações ficariam mais complexas. E faremos isso com os comandos abaixo:

Para parar:

```sh
sudo systemctl stop dhcpcd.service
```
E retirar da inicialização do sistema operacional:

```sh
sudo systemctl disable dhcpcd.service
```

## 12 - Instalar bridge-utils e ipset

O `bridge-utils` é uma ferramenta que permitirá criar e manusear bridges, e deve ser instalada a com do comando abaixo:

```sh
aptitude install bridge-utils
```

Instale também o Ipset por meio do comando abaixo, que permitirá o manuseio de uma grande quantidade de IPs e redes, por meio de hashes, de maneira mais eficiente: 💁🏻‍♀️

```sh
sudo apt-get install ipset

```

## 13 - Configurando Interfaces

🕵🏻‍♂️ Antes disso, será necessário que seja plugado o adaptador lan rede usb, após isso cheque qual o nome das interfaces de rede por meio do comando abaixo:

```sh
ifconfig
```

Desconsidere lo e wlan (caso exista), no nosso caso os nomes são `eth0` e `eth1`.


Agora vamos editar as configurações de rede, utilizando o editor nano, usando o comando abaixo:

```sh
sudo nano /etc/network/interfaces

```
E dentro dele, configure da seguinte forma:

```
source-directory /etc/network/interfaces.d

auto eth0
auto eth1

auto br0
iface br0 inet static
address 192.0.2.36
netmask 255.255.255.0
bridge_ports eth0 eth1
bridge_stp off
bridge_maxwait 0
bridge_fd 0
```
**Explicando arquivo:**

A primeira linha, que provavelmente já existirá, se tornou irrelevante, já que o dhcpcd.service foi desabilitado, então não é necessário remove-la.

Quanto aos `auto` servem para iniciar a interface mesmo que não esteja sendo utilizada, foi feito isso nas duas interfaces. *(eth0 - porta ethernet própria do Raspberry e eth1 - Criada com adaptador USB)*

**Obs.:** Configure o endereço e máscara de acordo com sua rede. (Obs, o ip estático nesse tipo de equipamento é útil, pois tendo anotado o valor, não será necessário ficar descobrindo)

**Finalmente:**

⌨️ Após edição do arquivo, saia e salve com as teclas ctrol + x e confirme salvamento e saída.

E então reinicie o sistema por meio do comando:

```sh
sudo reboot now
```

## 14 Rodando o Programa

Já tendo clonado o programa no passo `8` e criado o atalho para executar, apenas use o seguinte comando:

```sh
infusor_front
```

## 15 - Aplicação Web - Frontend e Backend

A aplicação Web é a parte do sistema responsável por realizar a comunicação com o usuário, isto é, receber uma entrada de dados e enviá-las ao banco de dados para futuro processamento no Raspberry. A interface foi desenvolvida com os conceitos básicos de HTML, CSS, Javascript e Bootstrap(4.1), junto com o framework Flask da linguagem Python. Não tem nada muito complexo em criar uma interface, é uma parte bem dinâmica que pode ser apenas funcional ou possuir alguns incrementos visuais e interativos de acordo com a vontade do usuário. Contando com o Boostrap, que é um framework com funções CSS e JS prontas, que facilita o desenvolvimento do frontend de qualquer interface sem a necessidade de conhecimento aprofundado na área. Após a criação do documento necessário, é só pesquisar as funções desejadas e inserir no documento, uma boa criatividade pode ajudar a montar um frontend amigável.

**1 - Ferramentas Necessárias**

Para realizar o desenvolvimento do frontend, neste caso, foi necessário:

* Dispositivo (Computador, Celular e afins) que tenha acesso à internet e um navegador Web;
* [SublimeText3](https://www.sublimetext.com) - Editor de código usado por nós!
* [Atom] (https://atom.io) - Ótima alternativa
* Ou até mesmo o Terminal. 👌🏻

**2 - Configurando o código com o banco** 

Na pasta está também contido o projeto da interface Web. Após clonado o projeto, devemos primeiro configurar a conexão com o banco de dados na aplicação. Devemos então abrir o arquivo "dbconnect.py" e alterarmos os valores para os mesmos presentes em nosso banco de dados e interface Desktop. 

```sql
def connection():
	mydb = mysql.connector.connect(
		host="endereço",
		database="nome_banco",
		user="nome_usuario (se tiver)",
		passwd="senha_usuario (se tiver)"
)
```

Agora temos a configuração feita também na interface Web. E foi criado um atalho para a execução, apenas use o comando abaixo:


```sh
infusor_front
```

Com isso, a interface será disponibilizada para no endereço local `http://127.0.0.1:5000`

