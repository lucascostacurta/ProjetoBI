use comercio_oltp
go

-- Esqueci da PK de vendedor
alter table vendedor add constraint pk_vendedor
primary key (idvendedor)

alter table vendedor add constraint fk_gerente
foreign key (id_gerente) references vendedor(idvendedor)
go

alter table nota_fiscal add constraint fk_nota_cliente
foreign key (id_cliente) references cliente(idcliente)
go

alter table nota_fiscal add constraint fk_nota_vendedor
foreign key (id_vendedor) references vendedor(idvendedor)
go

alter table item_nota add constraint fk_item_produto
foreign key (id_produto) references produto(idproduto)
go

alter table item_nota add constraint fk_item_notafiscal
foreign key (id_nota_fiscal) references nota_fiscal(idnota)
go

alter table produto add constraint fk_produto_fornecedor
foreign key (id_fornecedor) references fornecedor(idfornecedor)
go

alter table produto add constraint fk_produto_categoria
foreign key (id_categoria) references categoria(idcategoria)
go

alter table endereco add constraint fk_endereco_cliente
foreign key (id_cliente) references cliente(idcliente)
go

alter table nota_fiscal add constraint fk_nota_forma
foreign key (id_forma) references forma_pagamento(idforma)
go