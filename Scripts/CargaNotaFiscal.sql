-- Preenchendo a tabela de notas fiscais

-- Gerando os dados de 2015

declare
	@id_cliente int,
	@id_vendedor int,
	@id_forma int,
	@data date
begin
	set @id_cliente =
	(select top 1 idcliente from cliente order by newid())

	set @id_vendedor = 
	(select top 1 idvendedor from vendedor order by newid())

	set @id_forma =
	(select top 1 idforma from forma_pagamento order by newid())

	set @data =
		(select
			convert(date,
				convert(varchar(15),
				'2015-' +
				convert(varchar(5),(convert(int,rand()*12)) + 1) +
				'-' +
				convert(varchar(5),(convert(int,rand()*27)) + 1)))
		)
		
	insert into nota_fiscal( id_cliente, id_vendedor, id_forma, data)
	values (@id_cliente, @id_vendedor, @id_forma, @data)
end
go 8000

-- Gerando os dados de 2016

declare
	@id_cliente int,
	@id_vendedor int,
	@id_forma int,
	@data date
begin
	set @id_cliente =
	(select top 1 idcliente from cliente order by newid())

	set @id_vendedor = 
	(select top 1 idvendedor from vendedor order by newid())

	set @id_forma =
	(select top 1 idforma from forma_pagamento order by newid())

	set @data =
		(select
			convert(date,
				convert(varchar(15),
				'2016-' +
				convert(varchar(5),(convert(int,rand()*12)) + 1) +
				'-' +
				convert(varchar(5),(convert(int,rand()*27)) + 1)))
		)
		
	insert into nota_fiscal( id_cliente, id_vendedor, id_forma, data)
	values (@id_cliente, @id_vendedor, @id_forma, @data)
end
go 8400

-- Gerando os dados de 2017

declare
	@id_cliente int,
	@id_vendedor int,
	@id_forma int,
	@data date
begin
	set @id_cliente =
	(select top 1 idcliente from cliente order by newid())

	set @id_vendedor = 
	(select top 1 idvendedor from vendedor order by newid())

	set @id_forma =
	(select top 1 idforma from forma_pagamento order by newid())

	set @data =
		(select
			convert(date,
				convert(varchar(15),
				'2017-' +
				convert(varchar(5),(convert(int,rand()*12)) + 1) +
				'-' +
				convert(varchar(5),(convert(int,rand()*27)) + 1)))
		)
		
	insert into nota_fiscal( id_cliente, id_vendedor, id_forma, data)
	values (@id_cliente, @id_vendedor, @id_forma, @data)
end
go 9000

-- Trunquei a tabela porque inseri todos os dados com o ano de 2015

/*
truncate table nota_fiscal;
go
*/

select count(*), year(data) from nota_fiscal
group by year(data)
order by year(data);
go