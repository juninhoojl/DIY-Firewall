

![PinFusor](img_md/logo.png)


Descricao


## Versão 1.0

O que tem nessa versao


## Desenvolvido Por

> 
> `Banco de Dados` - [André Vitor Beraldo](https://github.com/AndreBeraldo) 
> 
> `Firewall` - 👻 [José Luiz Corrêa Junior](https://github.com/juninhoojl) 
> 
> `Frontend` - Halyson Vinícius Morais - <halysonmorais@get.inatel.br>
> 
> `Frontend` - [Felipe dos Santos](https://github.com/SecureHub)

## Hardware Necessário

**Observação:** Para reproduzir o que foi feito e desenvolvido por nós, basta um computador que possua pelo menos 2 interfaces de rede, porém, abaixo estão as especificações exatas do que foi usado!

* **1** Raspberry Pi 3 Model B
* **1** Cartão Micro Sd Ultra 32gb Classe10
* **1** Adaptador Lan Rede Gigabit Usb 3.0 Ethernet 10/100/1000
* **1** Cabo De Rede Ethernet 1m Metro Montado Rj45
* **1** Carregador De Tomada Usb Samsung 5.0v 2.0a
* **1** Cabo de dados usb com saída micro usb


## Sistema Operacional:

• [Raspbian Stretch Lite](https://www.raspberrypi.org/downloads/raspbian/) (Não possui gerenciador gráfico)

## Programas Auxiliares: 

[Etcher](https://etcher.io) (Para gravar .ISO no cartão SD de maneira fácil)


## Noções de Funcionamento

![Arquitetura](img_md/arq.png)

* O sistema é basicamente composto pela união de um roteador, um Raspberry Pi, um ponto de acesso e as interfaces que estarão conectadas à rede naquele momento. Os três primeiros componentes estarão interligados por um cabo de rede Ethernet, por onde os dados serão trafegados e todas interfaces poderão se conectar, via Wi-fi, ao ponto de acesso.

* O Raspberry Pi, como uma appliance, tem o objetivo de hospedar a aplicação gerenciadora do acesso à rede, a qual recebe todos os pacotes e os libera ou bloqueia ao ponto de acesso após o processamento dos filtros configurados. A aplicação é um software desenvolvido em Python, Ruby e Shell script que utiliza um banco de dados MySQL para receber tais configurações armazenadas e atualizadas da rede.

* As interfaces conectadas ao ponto de acesso têm a opção de utilizar uma aplicação Web, desenvolvida em Python, HTML, CSS e JS, para configurar as informações presentes no banco de dados.

**Obs.:**Todos programas utilizados pela arquitetura estarão disponíveis na internet.

--

![Step](img_md/step.gif)

## 0 - Banco de Dados (Em qualquer computador)

Na aplicação em questão, optou-se pela utilização de um banco MySQL hospedado, porém também pode ser utilizada uma rede local e em outros bancos de preferência, cabendo ao usuário apenas alterar o código para este.

**1 -** Para utilizarmos o MySQL, neste caso, devemos realizar o download de um servidor independente de plataforma. Existem diversos, como o XAMPP, WAMP, por exemplo, porém utilizaremos o primeiro. Depois de realizarmos seu download, precisamos  instalá-lo (apresenta instalação simples) e inicializá-lo. Após, devemos acionar os botões `Start` para o Apache, MySQL e FileZilla, trazendo um resultado como a imagem que segue. 

![Criando](img_md/xampp.png)

**2 -** Isso nos permite acessar o banco em rede local. Quando os serviços estiverem ativos, clicaremos no botão “Admin” do MySQL, que nos redirecionará ao phpMyAdmin, interface gráfica de aplicação do MySQL.

![Criando](img_md/phpmyadmin.png)

**3 -** O servidor estando ativo, agora precisamos gerar nosso banco de dados e tabelas. Anote estes dados, pois serão importantes à frente. Para criarmos um banco de dados, precisamos clicar no botão SQL e executar o comando a seguir:

```sql
CREATE DATABASE nome_banco;
	USE nome_banco;
```

Agora então devemos criar nossas tabelas. A aplicação em si contém duas tabelas, uma para validação de países a serem banidos e outra para armazenar os IP’s e/ou link de Website’s específicos.

```sql
CREATE TABLE validarippaises (ID int NOT NULL PRIMARY_KEY AUTO_INCREMENT, PAIS VARCHAR(100) NOT NULL, FLAG TINYINT(1) NOT NULL);
CREATE TABLE linksespecificos (ID int NOT NULL PRIMARY_KEY AUTO_INCREMENT, ALVO VARCHAR(150));
```

Precisamos então inserir os países na primeira tabela. Para isso, devemos abrir o arquivo texto `PAÍSES.txt` presente na pasta do projeto. Copiaremos o conteúdo e acessaremos o mesmo botão `SQL` utilizado acima, colando e executando as linhas de código. Pronto, as tabelas estão criadas e funcionando. A seguir realizaremos a configuração do código da aplicação Desktop em função do banco de dados.

Ao abrir o código do arquivo `main.py`, encontramos na linha 7 a função connect, cujos parâmetros referenciam o local de hospedagem do banco (que pode ser localhost, 127.0.0.1 ou o IP de uma hospedagem), o nome do banco de dados que será utilizado, o nome e a senha do usuário, caso esteja usando um. O usuário deve preencher essa região com os dados referentes ao seu banco.

```sql
mydb = mysql.connector.connect(
	host="endereço",
	database="nome_banco",
	user="nome_usuario (se tiver)",
	passwd="senha_usuario (se tiver"
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

## 8 - Instalar e Configurar Nginx

O Nginx é um servidor web, que será usado para hospedar as páginas que auxiliam o manuseio do banco de dados!

**1-** Atualize os repositórios do Linux:

```sh
sudo apt-get update
```

**2-** Para instalar use o comando abaixo:

```sh
sudo apt-get install nginx
```

**3-** Instale o PHP

```sh
sudo apt-get install php-fpm
```

**4-** Habilite o PHP no Servidor:

* Abra o arquivo default com o editor nano:

```sh
sudo nano -c /etc/nginx/sites-enabled/default
```

* Encontre a seguinte linha `index index.html index.htm;` , por volta da linha 25. E a modifique para ficar assim:

```
index index.php index.html index.htm;
```

* Agora, encontre a linha `# location ~ \.php$ {` e descomente (Retire o `#`) dela e das seguintes linhas:

`include snippets/fastcgi-php.conf;`
`fastcgi_pass unix:/var/run/php5-fpm.sock;`

* Deverá ficar algo assim:

```
# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
#
location ~ \.php$ {
include snippets/fastcgi-php.conf;

# With php5-cgi alone:
#       fastcgi_pass 127.0.0.1:9000;
# With php5-fpm:
fastcgi_pass unix:/var/run/php5-fpm.sock;
}
```

**5-** Adicionando Nginx na inicialização:

```sh
sudo update-rc.d -f nginx defaults;
```

**6-**❗️Após ter feito isso, reinicie o sistema:

```sh
sudo apt-get reboot
```


**Motivo de escolha desse web server:**
Considerando que o servidor web no nosso apenas irá servir para hospedar a interface de usuário, ou seja, muito poucas requisições serão feitas, e apenas um usuário por vez. E o desempenho x custo benefício (Consumo de recursos) do Nginx se destaca muito com pequeno volume de requisições.


## 9 - Frontend

Esse passo consiste na cópia do conteúdo que está no nosso github para a pasta padrão do nginx.


**1 -** Instale o GIT com o comado abaixo: 

```sh
sudo apt-get install git
```

**2 - Clone os Arquivos** 

Por padrão o Nginx utiliza `/var/www/html` no Raspbian, e não será necessário mudar. Então iremos acessar esse diretório e clonar o que desenvolvemos, com relação ao frontend, para esse local:

* Acesse o diretório:

```sh
cd /var/www/html

```

* Acesse o diretório:

```sh
sudo git clone LINKFRONT

```

## 10 - Backend

Faça uma cópia dos arquivos desenvolvidos por nós para o diretório DIY-Firewall na sua pasta de usuário, que será criado automaticamente, com os comandos:

Mas antes acesse o diretório de usuário: *❗️IMPORTANTE*

```sh
cd ~/
```
E nele execute o comando, que simplesmente fará um clone/copia:

```sh
sudo git clone LINKGIT DIY-Firewall

```


## 11 - Dando Todas as Permissões para execução

Com o comando abaixo será atribuída todas as possíveis permissões no diretório que contém todas as partes que são responsáveis por alterar regras, criar, deletar e afins.
*❗️(Obs.: Atente-se para ter certeza que o diretório se encontra na pasta de usuário, representada por `~`)*

```sh
sudo chmod -R 777 ~/DIY-Firewall
```


## 12 - Instalar Ruby e Gem Necessária

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


## 13 -  Instalar Python 3 e Módulos Necessários

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

## 13 - Ajustes Antes de Configurar Rede Manualmente:

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

## 14 - Instalar bridge-utils e ipset

O `bridge-utils` é uma ferramenta que permitirá criar e manusear bridges, e deve ser instalada a com do comando abaixo:

```sh
aptitude install bridge-utils
```

Instale também o Ipset por meio do comando abaixo, que permitirá o manuseio de uma grande quantidade de IPs e redes, por meio de hashes, de maneira mais eficiente: 💁🏻‍♀️

```sh
sudo apt-get install ipset

```

## 15 - Configurando Interfaces

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

## 3.3 Rodando o Programa

Como as configurações estão prontas, é necessário com que realizemos a transferência do programa para o Raspberry PI através de um pendrive, download transferindo-o para uma pasta de preferência. Acesse a pasta através do terminal e execute o comando a seguir:

```sh
sudo python3 ./PROJETO-REDES.py
```


# Um pouco sobre o Frontend


## Ideia

O frontend é a parte do sistema responsável por realizar a comunicação com o usuário, isto é, receber uma entrada de dados, enviar ao sistema interno para processar(Backend) e então retornar ao usuário uma saída, no caso, retornar uma confirmação ao usuário. O frontend da Aplicação, neste caso, foi realizado via interface WEB, utilizando conceitos básicos de:

* HTML 
* CSS
* Javascript (Com framework Jquery)
* Bootstrap(4.0)

## O Que é Necessário para Modificar/Criar? 🤔
Não tem nada muito complexo em criar uma interface, é uma parte bem dinâmica que pode ser apenas funcional ou possuir alguns incrementos visuais e interativos de acordo com a vontade do usuário.


O frontend é a parte do sistema responsável por realizar a comunicação com o Observação: Para realizar o desenvolvimento do frontend, é necessário possuir:

* 1 Dispositivo (Computador, Celular e afins) que contenha algum editor de texto e um navegador WEB.
 
* Acesso à Internet.


## Programas utilizados
* [Sublime](https://www.sublimetext.com) - Editor de código usado por nós!
* [Atom] (https://atom.io) - Ótima alternativa

## 1 – Criando os documentos necessários
Crie os documentos necessários para começar o desenvolvimento conforme a imagem abaixo (Um arquivo `.css` e um arquivo `.html`) :

![Criando](img_md/front2.png)
               
  **Obs.:** Ao criar um arquivo HTML pelo editor de texto sublime, o cabeçalho necessário para o desenvolvimento em HTML é gerado automaticamente, portanto não se preocupe xD. (Digite html e aperte `tab`)


## 2 - Um pouco sobre o Bootstrap

O Twitter Bootstrap é um framework para utilizar funções prontas de CSS e possui integração com o Jquery, outro framework utilizado para utilizar funções prontas de Javascript.
Utiliza-lo não exige conhecimento avançado. Após realizar a criação do documento necessário, é só pesquisar as funções desejadas e colocar no documento, uma boa criatividade pode ajudar a montar um frontend amigável.



## 3 – Utilizando o Bootstrap

Para utiliza-lo, caso não tenha seguido a página, basta fazer as seguintes coisas:

**1 -** Copie e cole o link de camada de estilo abaixo antes de todas as outras na sua tag `<head>`.

```html
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

```

**2 -** Faça a mesma coisa com esses src de js, dentro da <head> também!

```html
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
```

Caso queira maio detalhamento, acesse a página do framework [Twitter Bootstrap](https://getbootstrap.com) e clique em `Get Started`, como mostrado abaixo!

![Criando](img_md/front3.png)

## 4 - Finalmente! 😤

Agora o documento já está pronto para receber as funções desejadas, caso queira colocar um menu, acesse a documentação do Bootstrap e cole os conteúdos dentro dos documentos .HTML e .CSS.
A interface criada foi elaborada pensando apenas em funcionalidade, portanto é bem simples.

## 5 - Resultados

O Após a criação dos documentos e algumas horas na frente do computador, uma interface parecida com a seguinte pode ser criada:

![Criando](img_md/front4.png)
