------------------------------------------------------------------------------------------
--Fatec Rio Preto
--Curso: Análise e Desenvolvimento de Sistemas
--Aluno: Gabrielle Vitória da Silva
--Profa: Valéria Maria Volpe
--------------------------------------------------------------------------------------------
use master
drop database BookStore

create database BookStore
go

use Bookstore
go
-------------------Criar as tabelas ---------------------------------------------------------

-----------------------Pessoa----------------------------------------------------------------

create table Pessoa
(
	id_pessoa 	int 			not null	primary key 	identity,
	nome 		varchar (50)	not null,
	data_nasc 	varchar (20)			not null	
)
go
--------------------------------------------------------------------------------------------
-----------------------Endereço-------------------------------------------------------------

create table Endereco
(
	id_endereco 	int				not null 	identity,
	id_pessoa		int				not null,
	rua 			varchar(50) 	not null,
	numero			varchar(10)		not null,
	bairro 			varchar(50)		not null,
	cep 			varchar(9) 		not null,
	cidade 			varchar(20) 	not null,
	estado 			varchar(20)		not null,
	
	primary key (id_endereco, id_pessoa), --Chave primária composta
	
	foreign key (id_pessoa)		references 	Pessoa (id_pessoa)
)
go

--------------------------------------------------------------------------------------------
-----------------------Telefone-------------------------------------------------------------

create table Telefone
(
	id_pessoa	int 			not null,
	telefone	varchar(15)		not null,
	primary key (id_pessoa, telefone), --Chave primária composta
	
	foreign key (id_pessoa) 	references 	Pessoa(id_pessoa)
	
)
go
--------------------------------------------------------------------------------------------
-----------------------Autor----------------------------------------------------------------

create table Autor
(
	id_pessoa		 int 			not null 	primary key,
	pseudonimo		 varchar(30)		null,
	local_nascimento varchar(50)		null,
	
	foreign key	(id_pessoa)     references		Pessoa(id_pessoa) 
)
go
--------------------------------------------------------------------------------------------
-----------------------Cliente--------------------------------------------------------------

create table Cliente
(
	id_pessoa  	    int 			not null 	primary key,
	cpf				varchar (14) 	not null 	unique,

	foreign key (id_pessoa)		references 		Pessoa(id_pessoa) 	
)
go
--------------------------------------------------------------------------------------------
-----------------------Editora--------------------------------------------------------------

create table Editora
(
	id_pessoa	int 			not null 	primary key,
	gerente 	varchar(50)		not null,
	cnpj 		varchar(20) 	not null	unique,

	foreign key (id_pessoa) 	references 	Pessoa (id_pessoa)
)
go

--------------------------------------------------------------------------------------------
-----------------------Compra---------------------------------------------------------------

create table Compra
(		
	id_compra 		int 		not null 	primary key		identity,
	--Chave estrangeira
	id_cliente		int			not null	references		Cliente(id_pessoa),
	data_compra 	datetime	not null,
	valor 			money			null, 
	check (valor > 0)
)
go
--------------------------------------------------------------------------------------------
----------------------Assunto---------------------------------------------------------------
CREATE TABLE Assunto
(
    	id_assunto 	int 			not null 	primary key		identity,
    	descricao 	varchar(20)    not null
)
go
--------------------------------------------------------------------------------------------
-----------------------Livro----------------------------------------------------------------

create table Livro
(
	id_livro 			int 	not null  	primary key		identity,
	id_assunto			int		not null	references		Assunto(id_assunto),
	id_pessoa			int		not null	references		Editora(id_pessoa),
	qtd_estoque 	    int 	not null,
	ano_publicacao 	    int 		null,
	titulo 		varchar(100) 	not null,
	IBSN 		varchar(14)			null,
	preco 		decimal(10,2) 	not null,
	--restrições
	check(qtd_estoque>=0),
	check(preco>0)	
)	
go
--------------------------------------------------------------------------------------------
----------------------Autores_Livros--------------------------------------------------------
CREATE TABLE Autores_Livros
(
    	id_autor 	int 	not null,
    	id_livro	int	not null,
    	primary key (id_autor, id_livro), --Chave primária composta
    	--Chaves estrangeiras
    	foreign key	(id_autor)	references	Autor(id_pessoa),
    	foreign key	(id_livro)	references	Livro(id_livro)
    	
)
go

--------------------------------------------------------------------------------------------
------------------------Itens_Compra--------------------------------------------------------

create table Itens_Compra
(	
	id_compra	int		not null,
	id_livro	int		not null,
	qtd_livros 	int 	not null	default 1,
	valor		money 	not null,
	
	primary key (id_compra, id_livro), --chave primária composta
	--chaves estrangeiras
	foreign key (id_compra)			references	Compra(id_compra),
	foreign key (id_livro)			references 	Livro(id_livro),
	--restrições
	check (qtd_livros > 0),
	check (valor >= 0)
)
go
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

------------------------------Inserir Pessoas-----------------------------------------------

insert into Pessoa (nome, data_nasc)
values
	('João Pedro', '09-05-1995'),
	('Fernanda Silva', '12-03-1998'),
	('José Carlos', '01-11-1990'),
	('Marina Oliveira', '06-27-1996'),
	('Rafael Mendes', '11-09-1993'),
	('Bianca Santos', '09-05-1997'),
	('Pedro Henrique', '09-12-1994'),
	('Stephen King', '10-09-1947'),
	('J.K. Rowling', '01-07-1965'),
	('Machado de Assis', '06-06-1839'),
	('José Camargo', '07-12-1775'),
	('Gabriel García Márquez', '06-03-1927'),
	('Penguin Random House', '03-10-1998'),
	('HarperCollins', '04-04-1817'),
	('Simon & Schuster', '09-07-1924')

go

--------------------------------------------------------------------------------------------
-- Clientes --> id 1, 2 ,3, 4, 5, 6 e 7
-- Autores --> id 8, 9, 10, 11 e 12 
-- Editoras --> id 13, 14 e 15 
--------------------------------------------------------------------------------------------

------------------------------Cadastrar Clientes-----------------------------------------------
insert into Cliente (id_pessoa, cpf)
values
	(1, '99692571067'),
	(2, '77861708690'),
	(3, '61527085644'),
	(4, '22889285347'),
	(5, '56056698284'),
	(6, '31942244391'),
	(7, '83611932109')
go

insert into Telefone (id_pessoa, telefone)
values
	(1, '(11)96682-1473'),
	(2, '(27)97547-9334'),
	(3, '(68)98645-6614'),
	(4, '(11)99705-2694'),
	(5, '(47)94213-0582'),
	(6, '(51)97405-7027'),
	(7, '(27)95901-9207')


go

insert into Endereco (id_pessoa, estado, cidade, bairro, rua, numero, cep)
values
	(1, 'SP', 'São Paulo', 'Santa Cecília', 'Rua Barra Funda', '598', '01152-000'),
	(2, 'ES', 'Vitória', 'Praia do Canto', 'Rua Aleixo Neto', '235', '29055-310'),
	(3, 'AC', 'Rio Branco', 'Estação Experimental', 'Rua Ceará', '234', '69912-270'),
	(4, 'MG', 'Uberlândia', 'Jardim Patrícia', 'Rua Carlos Gomes', '721', '38405-015'),
	(5, 'SC', 'Joinville', 'Centro', 'Rua do Príncipe', '1040', '89201-400'),
	(6, 'RS', 'Porto Alegre', 'Moinhos de Vento', 'Rua Félix da Cunha', '1070', '90570-001'),
	(7, 'RJ', 'Rio de Janeiro', 'Tijuca', 'Rua Conde de Bonfim', '590', '20520-054')


go
--------------------------------------------------------------------------------------------
------------------------------Cadastrar Autores-----------------------------------------------

insert into Autor (id_pessoa, pseudonimo, local_nascimento)
values
	(8, null, 'Estados Unidos'),
	(9, null, 'Inglaterra'),
	(10, null, 'Brasil'),
	(11, null, 'Inglaterra'),
	(12, null, 'Colômbia')

go

insert into Telefone (id_pessoa, telefone)
values
	(8, '(11)94786-2331'),
	(8, '(17)99884-6621'),
	(9, '(21)98892-5476'),
	(10, '(21)97584-3451'),
	(11, '(44)99654-1234'),
	(12, '(57)32143-6789')
go

insert into Endereco (id_pessoa, estado, cidade, bairro, rua, numero, cep)
values

	(8, 'Estados Unidos', 'Bangor', 'Oak Hill', 'Mockingbird Lane', '342', '04401-000'),
	(9, 'Inglaterra', 'Bristol', 'Horfield', 'Churchill Road', '131', 'BS7 8TY'),
	(10, 'Brasil', 'Rio de Janeiro', 'Cosme Velho', 'Rua Jardim Botânico', '674', '22460-030'),
	(11, 'Inglaterra', 'Steventon', 'Steventon', 'Church Close', '5', 'OX13 6SD'),
	(12, 'Colômbia', 'Aracataca', 'Aracataca', 'Calle Real', '14', '470001')

go
--------------------------------------------------------------------------------------------
------------------------------Cadastrar Editoras----------------------------------------------

insert into Editora (id_pessoa,cnpj ,gerente)
values 
	(13,'36.584.882/0001-20','Clara Rodrigues'),
	(14, '19.173.921/0001-92','Leonardo Santos'),
	(15,'46.207.681/0001-59','Isabela Oliveira')
go 


insert into Telefone (id_pessoa, telefone)
values 
	(13, '(11)98123-4567'),
	(14, '(21)98123-4567'),
	(15, '(01)98123-4567')
go 

insert into Endereco (id_pessoa, estado, cidade, bairro, rua, numero, cep)
values 

	(13, 'NY', 'New York', 'Midtown', 'Fifth Avenue', '1745', '10019'),
	(14, 'LON', 'London', 'Bishopsgate', 'Primrose St', '1', 'EC2A 2RS'),
	(15, 'NY', 'New York', 'Rockefeller Center', '6th Ave', '1230', '10020')

go

--------------------------------------------------------------------------------------------
------------------------------Cadastrar Assuntos----------------------------------------------
insert into Assunto (descricao)
values
	('Poesia'),
	('Romance'),
	('Mistério'), 
	('Suspense'),
	('Ficção '),
	('Auto-Ajuda')
go

--------------------------------------------------------------------------------------------
------------------------------Cadastrar Livros----------------------------------------------

insert into Livro ( id_assunto, id_pessoa, qtd_estoque, ano_publicacao, titulo, IBSN, preco)
values 
	( 3, 13, 24, 2019, 'A Dança dos Dragões', '978-8532531432', 54.90),
	( 2, 14, 16, 2018, 'O Pequeno Príncipe', '978-8577343224', 26.90),
	( 1, 15, 10, 2020, 'O Nome do Vento', '978-8576865417', 42.90),
	( 6, 13, 32, 2016, 'Origem', '978-8580416996', 35.90),
	( 4, 14, 20, 2015, 'A Garota no Trem', '978-8580576844', 29.90),
	( 5, 15, 28, 2021, 'O Poder do Agora', '978-8575422040', 39.90),
	( 1, 13, 12, 2017, 'O Temor do Sábio', '978-8580446535', 45.90),
	( 2, 14, 18, 2014, 'A Culpa é das Estrelas', '978-8580573089', 32.90),
	( 3, 15, 8, 2013, 'O Festim dos Corvos', '978-8532530800', 52.90),
	( 6, 13, 25, 2020, 'Inferno', '978-8580412301', 38.90),
	( 5, 13, 30, 2015, 'O Conto da Aia', '978-8539004116', 40.99),
	( 3, 14, 25, 2018, 'Um Lugar Bem Longe Daqui', '978-8594900249', 29.90),
	( 6, 15, 20, 2020, 'Comédias Para Se Ler Na Escola', '978-8535919456', 34.99),
	( 2, 13, 15, 2019, 'A Garota No Gelo', '978-8594541148', 23.50),
	( 4, 14, 10, 2017, 'O Homem de Giz', '978-8594541292', 27.90)


go 

--------------------------------------------------------------------------------------------
-----------------------Cadastrar Autores Livros----------------------------------------------

insert into Autores_Livros(id_autor, id_livro)
values 
	(8, 1),
	(9, 2),
	(10, 3),
	(10, 4),
	(8, 5),
	(9, 6),
	(12, 7),
	(12, 8),
	(10, 9),
	(11, 10),
	(9, 11),
	(11, 11),
	(12, 12),
	(8, 13),
	(11, 15),
	(12, 14),
	(9, 14)
go


--------------------------------------------------------------------------------------------
-----------------------------Cadastrar Compras----------------------------------------------

insert into Compra(id_cliente, data_compra, valor)
values
	(1, '2022-01-10', 156.7),
	(2, '2022-02-15', 97.4),
	(3, '2022-03-02', 220.9),
	(4, '2022-03-25', 45.0),
	(5, '2022-04-12', 89.6),
	(6, '2022-05-07', 178.3),
	(7, '2022-05-20', 112.1)

go


--------------------------------------------------------------------------------------------
------------------------Cadastrar Itens Compras----------------------------------------------

insert into Itens_Compra (id_compra, id_livro, qtd_livros, valor)
values 	
		(1, 2, 1, 40),
		(1, 3, 1, 50),
		(2, 9, 2, 60),
		(3, 10, 1, 70),
		(3, 15, 1, 50),
		(4, 7, 1, 60),
		(5, 1, 2, 80),
		(6, 4, 1, 30),
		(7, 6, 1, 20),
		(7, 11, 1, 70),
		(8, 13, 1, 45),
		(8, 15, 1, 50),
		(9, 2, 2, 80),
		(9, 5, 1, 30),
		(10, 8, 1, 60),
		(10, 12, 1, 25)


--------------------------------------------------------------------------------------------
-----------------------------Consultar Autores----------------------------------------------

SELECT A.id_pessoa 'Cdgo Autor' , P.nome, P.data_nasc 'Data de nascimento', A.pseudonimo 'Pseudônimo'
from Autor A, Pessoa P
WHERE A.id_pessoa = P.id_pessoa
go


---------------------------------------------------------------------------------------------
-----------------------------Consultar Clientes----------------------------------------------

select C.id_pessoa 'Cdgo Cliente', P.nome Nome, P.data_nasc'Data de Nascimento', C.cpf CPF
from Cliente C, Pessoa p
where P.id_pessoa = C.id_pessoa
go

---------------------------------------------------------------------------------------------
-----------------------------Consultar Editoras----------------------------------------------

select E.id_pessoa 'Cdgo Editora', P.nome Nome, P.data_nasc 'Data de Fundação', E.cnpj CNPJ, E.gerente Gerente
from Pessoa P, Editora E
where P.id_pessoa = E.id_pessoa
go

---------------------------------------------------------------------------------------------
---------------------Consultar Livros e Autores----------------------------------------------

select L.id_livro Código, L.titulo Livro, L.id_assunto 'Id do Assunto', A.descricao Assunto, L.id_pessoa 'Id da Editora', 
L.IBSN ISBN, L.ano_publicacao Ano, L.qtd_estoque 'Quantidade em Estoque', L.preco Valor, Al.id_autor 'Id do Autor', P.nome Nome, Au.local_nascimento

from Livro L, Autores_Livros AL, Pessoa P, Assunto A, Autor Au

where L.id_livro = Al.id_livro and
	  P.id_pessoa = Al.id_autor and
	  L.id_assunto = A.id_assunto and
	  Al.id_autor = Au.id_pessoa
go

select P.id_pessoa 'Id da Editora', P.nome Editora, P.data_nasc 'Data de Fundação'
from Pessoa P
where id_pessoa >= 13 and 
	  id_pessoa <= 15
go



---------------------------------------------------------------------------------------------
----------------Editoras que publicaram Romance ou suspense----------------------------------

select P.id_pessoa 'Id da Editora', P.nome Editora, A.id_assunto 'Id do Assunto', A.descricao Assunto
from Assunto A, Editora E, Pessoa P, Livro L
where L.id_assunto = A.id_assunto and 
	  L.id_pessoa = E.id_pessoa and 
	  P.id_pessoa = E.id_pessoa and 
	  (A.descricao = 'Romance' or A.descricao = 'Poesia')
go

---------------------------------------------------------------------------------------------
---------------Editoras que publicaram Suspense----------------------------------------------

select P.id_pessoa 'Id do Autor', P.nome Autor, A.id_assunto 'Id do Assunto', A.descricao Assunto
from Autores_Livros Al, Pessoa P, Livro L, Assunto A
where P.id_pessoa = Al.id_autor and 
	  L.id_livro = Al.id_livro and 
	  L.id_assunto = A.id_assunto and 
	  A.descricao = 'Suspense'
go

---------------------------------------------------------------------------------------------
------------Autores e qtd Livros que já publicaram-------------------------------------------

select P.nome Autor, count(id_livro) 'Total de Livros'
from Pessoa P, Autores_Livros Al, Autor A
where P.id_pessoa = A.id_pessoa and 
	  A.id_pessoa = Al.id_autor
group by nome
go

---------------------------------------------------------------------------------------------
------------Consultar todos os livros, seu assunto e seu autor-------------------------------

select L.id_livro 'Id do Livro', L.titulo Livro, A.descricao Assunto, P.nome Autor
from Livro L, Assunto A, Pessoa P, Autores_Livros Al
where L.id_livro = Al.id_livro and
	  P.id_pessoa = Al.id_autor and
	  A.id_assunto = L.id_assunto
go

---------------------------------------------------------------------------------------------
-------------------Assuntos e qtd livros pertencem ao assunto -------------------------------

select A.descricao Assunto, count(descricao) 'Total de Livros'
from Assunto A, Livro L 
where L.id_assunto = A.id_assunto
group by descricao
go

---------------------------------------------------------------------------------------------
-------------------Alterar o preço dos livros dando 5% de aumento----------------------------
------------------------para livros publicados antes de 2010---------------------------------
update
Livro 
set
preco = preco + (preco*0.05)
where
ano_publicacao < 2010
go

---------------------------------------------------------------------------------------------
-----------------Excluir todos os telefones do autor José Camargo----------------------------
delete from Telefone
where id_pessoa = 14
go

---------------------------------------------------------------------------------------------