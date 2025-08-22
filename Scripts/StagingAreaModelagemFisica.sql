/*
create database comercio_stage
go

use comercio_stage
go
*/

create table st_cliente(
	idcliente int default null,
	nome varchar(100) default null,
	sexo varchar(20) default null,
	nascimento date default null,
	cidade varchar(100) default null,
	estado varchar(10) default null,
	regiao varchar(20) default null
)
go

create table st_vendedor(
	idvendedor int default null,
	nome varchar(50) default null,
	sexo varchar(20) default null,
	idgerente int default null
)
go

create table st_categoria(
	idcategoria int default null,
	nome varchar(50) default null
)
go

create table st_fornecedor(
	idfornecedor int default null,
	nome varchar(100) default null
)
go

create table st_produto(
	idproduto int default null,
	nome varchar(50) default null,
	valor_unitario numeric(10,2) default null,
	custo_medio numeric(10,2) default null,
	id_categoria int default null
)
go

create table st_nota(
	idnota int default null
)
go

create table st_forma(
	idforma int default null,
	forma varchar(50) default null
)
go


create table st_fato(
	idcliente int default null,
	idvendedor int default null,
	idproduto int default null,
	idfornecedor int default null,
	idnota int default null,
	idforma int default null,
	quantidade int default null,
	total_item numeric(10,2) default null,
	data date default null,
	custo_total numeric(10,2) default null,
	lucro_total numeric(10,2) default null
)
go