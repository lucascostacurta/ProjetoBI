create database comercio_dw
go

use comercio_dw
go

create table dim_vendedor(
	idsk int primary key identity,
	idvendedor int,
	inicio datetime,
	fim datetime,
	nome varchar(50),
	sexo varchar(20),
	idgerente int
)
go

create table dim_nota(
	idsk int primary key identity,
	idnota int
)
go

create table dim_forma(
	idsk int primary key identity,
	idforma int,
	forma varchar(30)
)
go

create table dim_cliente(
	idsk int primary key identity,
	idcliente int,
	inicio datetime,
	fim datetime,
	nome varchar(100),
	sexo varchar(20),
	nascimento date,
	cidade varchar(100),
	estado varchar(10),
	regiao varchar(20)
)
go

create table categoria(
	idcategoria int primary key,
	nome varchar(50)
)
go

create table dim_produto(
	idsk int primary key identity,
	idproduto int,
	inicio datetime,
	fim datetime,
	nome varchar(50),
	valor_unitario numeric(10,2) default null,
	custo_medio numeric(10,2) default null,
	id_categoria int,
	foreign key(id_categoria) references
	categoria(idcategoria)
)
go

create table dim_fornecedor(
	idsk int primary key identity,
	idfornecedor int,
	inicio datetime,
	fim datetime,
	nome varchar(30)
)
go

create table dim_tempo( 
    idsk int primary key identity, 
    data date, 
    dia char(2), 
    diasemana varchar(10), 
    mes char(2), 
    nomemes varchar(10), 
    quarto tinyint, 
    nomequarto varchar(10), 
    ano char(4), 
	estacaoano varchar(20),
	fimsemana char(3),
	datacompleta varchar(10)
) 
go 

create table fato(
	idnota int references dim_nota(idsk),
	idcliente int references dim_cliente(idsk),
	idvendedor int references dim_vendedor(idsk),
	idforma int references dim_forma(idsk),
	idproduto int references dim_produto(idsk),
	idfornecedor int references dim_fornecedor(idsk),
	idtempo int references dim_tempo(idsk),
	quantidade int,
	total_item numeric(10,2),
	custo_total numeric(10,2),
	lucro_total numeric(10,2)
)
go
