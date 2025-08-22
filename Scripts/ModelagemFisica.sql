-- Modelo Relacional

create database comercio_oltp;
go

use comercio_oltp;
go

create table endereco(
	idendereco int primary key identity,
	rua varchar(100) not null, 
	cidade varchar(50) not null,
	estado varchar(20) not null,
	regiao varchar(20) not null,
	id_cliente int unique
);
go

create table vendedor(
	idvendedor int primary key identity,
	nome varchar(30) not null,
	sexo char(1) not null,
	email varchar(30) not null
);
go

create table categoria(
	idcategoria int primary key identity,
	nome varchar(50) not null
);
go

create table fornecedor(
	idfornecedor int primary key identity,
	nome varchar(50)
);
go

create table produto(
	idproduto int primary key identity,
	produto varchar(100) not null,
	valor numeric(10,2) not null,
	custo_medio numeric(10,2),
	id_categoria int, 
	id_fornecedor int
);
go

create table forma_pagamento(
	idforma int primary key identity,
	forma varchar(50) not null
)
go

create table item_nota(
	iditemnota int primary key identity,
	id_produto int,
	id_nota
)
go

create table nota_fiscal(
    idnota int primary key identity(1000,10),
    data date,
    total numeric(10,2),
    id_forma int,
    id_cliente int,
    id_vendedor int
)
go

create table cliente(
	idcliente int primary key identity,
	nome varchar(30) not null,
	sobrenome varchar(30) not null,
	email varchar(60) not null,
	sexo char(1) not null,
	nascimento date not null
)
go

/*
alter table cliente
add sexo char(1) not null
*/

