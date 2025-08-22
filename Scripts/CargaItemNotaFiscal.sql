-- Item de nota

use comercio_oltp;
go

declare
	@id_produto int,
	@id_nota_fiscal int,
	@quantidade int,
	@valor numeric(10,2),
	@total numeric(10,2)
begin
	set @id_produto = 
	(select top 1 idproduto from produto order by newid())

	set @id_nota_fiscal = 
	(select top 1 idnota from nota_fiscal order by newid())

	set @quantidade = 
	(select round(rand() * 4 + 1, 0))

	set @valor =
	(select valor from produto where idproduto = @id_produto)

	set @total = 
	(@quantidade * @valor)

	insert into item_nota(id_produto, id_nota_fiscal, quantidade, total)
	values(@id_produto, @id_nota_fiscal, @quantidade, @total)

end
go 27000 -- Inserção de dados em 1min

select count(*) from item_nota;
go

-- Criando cursor para preencher notas fiscais sem itens
-- Transformar o cursor em uma Procedure para eventual uso futuro

create procedure cad_notas as 

declare
	c_notas cursor for
	select idnota from nota_fiscal
	where idnota not in(select id_nota_fiscal from item_nota)

declare
	@idnota int,
	@id_produto int,
	@total decimal(10,2)

open c_notas

fetch next from c_notas
into @idnota

while @@FETCH_STATUS = 0
begin
	set @id_produto =
	(select top 1 idproduto from produto order by newid())

	set @total = 
	(select valor from produto where idproduto = @id_produto)

	insert into item_nota(id_produto, id_nota_fiscal, quantidade, total)
	values(@id_produto, @idnota, 1, @total)

fetch next from c_notas
into @idnota

end
close c_notas
deallocate c_notas
go

-- Executando Procedure

exec cad_notas;
go

-- Conferindo se todos os registros foram preenchidos

select idnota from nota_fiscal where idnota not in (select id_nota_fiscal from item_nota)
order by 1;
go

-- Criando uma view para verificar os itens pedidos

create view v_item_nota as --não pode criar views com order by
select
	id_nota_fiscal as "Nota Fiscal",
	produto,
	valor,
	quantidade,
	total as "Total do Item"
from produto
inner join item_nota
on idproduto = id_produto

select * from v_item_nota
order by 1;
go

