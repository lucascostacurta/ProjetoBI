create procedure CamelCase as

declare c_nome cursor for
select idproduto, nome
from comercio_stage.dbo.st_produto

declare
	@idproduto int,
	@palavra varchar(50),
	@stringtotal varchar(5000),
	@inicio int,
	@fim int

open c_nome
fetch next from c_nome into
@idproduto, @palavra

while @@FETCH_STATUS = 0

begin
	set @palavra = lower(@palavra)
	set @inicio = 2
	set @fim = len(@palavra)
	set @stringtotal = upper(left(@palavra,1))

	while @inicio <= @fim

	begin
		if SUBSTRING(@palavra, @inicio, 1) = ' '
		begin
			select @inicio = @inicio + 1
			select @stringtotal = @stringtotal + ' ' + upper(substring(@palavra,@inicio,1))
		end
		else
		begin
			select @stringtotal = @stringtotal + substring(@palavra, @inicio, 1)
		end

		select @inicio = @inicio + 1
end

update st_produto set nome = @stringtotal
where idproduto = @idproduto

fetch next from c_nome into
@idproduto, @palavra

end 
close c_nome
deallocate c_nome
go