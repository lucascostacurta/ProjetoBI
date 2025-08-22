		------------------------
		---conexao com o dw-----
		------------------------

		use comercio_dw
		go

		------------------------
		--criaçao da procedure--
		------------------------

		create proc carga_fato
		as

		declare @final datetime 
		declare	@inicial datetime
		
		select  @final = max(data)
		from comercio_dw.dbo.dim_tempo t

		select @inicial = max(data)
			from comercio_dw.dbo.fato ft
			join comercio_dw.dbo.dim_tempo t on (ft.idtempo=t.idsk)

		if @inicial is null
		begin
			select @inicial = min(data)
			from comercio_dw.dbo.dim_tempo t
		end

		insert into comercio_dw.dbo.fato(
			idnota ,
			idcliente ,
			idvendedor ,
			idforma ,
			idfornecedor,
			idproduto,
			idtempo,
			quantidade,
			total_item,
			custo_total,
			lucro_total )
		select
			n.idsk as idnota,
			c.idsk as idcliente,
			v.idsk as idvendedor,
		    fo.idsk as idforma,
		    fn.idsk as idfornecedor,
			p.idsk as idproduto,	
			t.idsk as idtempo,
			f.quantidade,
			f.total_item,
			f.custo_total,
			f.lucro_total
	
		from
			comercio_stage.dbo.st_fato f

			inner join dbo.dim_forma fo
			on (f.idforma=fo.idforma)	 

			inner join dbo.dim_nota n
			on (f.idnota=n.idnota)

			inner join dbo.dim_fornecedor fn
			on (f.idfornecedor=fn.idfornecedor
				and (fn.inicio <= f.data and (fn.fim >= f.data) or (fn.fim is null)))

			inner join dbo.dim_cliente c
			on (f.idcliente=c.idcliente
				and (c.inicio <= f.data
				and (c.fim >= f.data) or (c.fim is null)))

			inner join dbo.dim_vendedor v
			on (f.idvendedor=v.idvendedor
				and (v.inicio <= f.data
				and (v.fim >= f.data) or (v.fim is null)))

			inner join dbo.dim_produto p
			on (f.idproduto=p.idproduto 
			and (p.inicio <= f.data 
			and (p.fim >= f.data) or (p.fim is null)))

			inner join dbo.dim_tempo t
			on (convert(varchar, t.data,102) = convert(varchar,
			f.data,102))
			--where f.data > @inicial and f.data < @final
			where f.data between @inicial and @final
	go
