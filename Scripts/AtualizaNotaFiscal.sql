-- Atualização de Nota Fiscal

create view v_nota_fiscal as
select id_nota_fiscal, sum(total) as soma
from item_nota
group by id_nota_fiscal;
go

create view v_carga_nf as
select n.idnota, n.total as total_nota, i.soma
from nota_fiscal n 
inner join v_nota_fiscal i
on idnota = id_nota_fiscal
go

update v_carga_nf
set total_nota = soma
go

select * from nota_fiscal;

-- Consulta no ambiente OLTP
create view v_relatorio_oltp as
select
	c.nome,
	c.sobrenome,
	c.sexo,
	n.data,
	n.idnota,
	p.produto,
	n.total
from cliente c
inner join nota_fiscal n
on c.idcliente = n.id_cliente
inner join item_nota i
on n.idnota = i.id_nota_fiscal
inner join produto p
on i.id_produto = p.idproduto
go

select * from v_relatorio_oltp;