create view relatorio_vendas as
select
	c.idcliente as idcliente,
	v.idvendedor as idvendedor,
	p.idproduto as idproduto,
	fo.idfornecedor as idfornecedor,
	n.idnota as idnota,
	f.idforma as idforma,
	i.quantidade as quantidade,
	(i.quantidade * p.custo_medio) as custo_total,
	(i.total -(i.quantidade * p.custo_medio)) as lucro_total,
	i.total as total_item,
	n.data as data
from nota_fiscal n 
inner join item_nota i on (n.idnota = i.id_nota_fiscal)
inner join cliente c on (c.idcliente = n.id_cliente)
inner join vendedor v on (v.idvendedor = n.id_vendedor)
inner join produto p on (p.idproduto = i.id_produto)
inner join forma_pagamento f on (f.idforma = n.id_forma)
inner join fornecedor fo on (fo.idfornecedor = p.id_fornecedor)
go

