-------------------------------
--carregando a dimensão tempo--
-------------------------------

--exibindo a data atual

print convert(varchar,getdate(),113) 

--alterando o incremento para início em 5000
--para a possibilidade de datas anteriores

dbcc checkident (dim_tempo, reseed, 50000) 

--inserção de dados na dimensão

declare    @datainicio datetime 
         , @datafim datetime 
         , @data datetime
		 		  
print getdate() 

select @datainicio = '1/1/1950' 
     , @datafim = '1/1/2050'

select @data = @datainicio 

while @data < @datafim 
 begin 
	
	insert into dim_tempo 
	( 
		  data, 
		  dia,
		  diasemana, 
		  mes,
		  nomemes, 
		  quarto,
		  nomequarto, 
		  ano 
		
	) 
	select @data as data, datepart(day,@data) as dia, 

		 case datepart(dw, @data) 
            
			when 1 then 'domingo'
			when 2 then 'segunda' 
			when 3 then 'terça' 
			when 4 then 'quarta' 
			when 5 then 'quinta' 
			when 6 then 'sexta' 
			when 7 then 'sábado' 
             
		end as diasemana,

		 datepart(month,@data) as mes, 

		 case datename(month,@data) 
			
			when 'january' then 'janeiro'
			when 'february' then 'fevereiro'
			when 'march' then 'março'
			when 'april' then 'abril'
			when 'may' then 'maio'
			when 'june' then 'junho'
			when 'july' then 'julho'
			when 'august' then 'agosto'
			when 'september' then 'setembro'
			when 'october' then 'outubro'
			when 'november' then 'novembro'
			when 'december' then 'dezembro'
		
		end as nomemes,
		 
		 datepart(qq,@data) quarto, 

		 case datepart(qq,@data) 
			when 1 then 'primeiro' 
			when 2 then 'segundo' 
			when 3 then 'terceiro' 
			when 4 then 'quarto' 
		end as nomequarto 
		, datepart(year,@data) ano
	
	select @data = dateadd(dd,1,@data)
 end

update dim_tempo 
set dia = '0' + dia 
where len(dia) = 1 

update dim_tempo 
set mes = '0' + mes 
where len(mes) = 1 

update dim_tempo 
set datacompleta = ano + mes + dia 
go

select * from dim_tempo

----------------------------------------------
----------fins de semana e estações-----------
----------------------------------------------

declare c_tempo cursor for	
	select idsk, datacompleta, diasemana, ano from dim_tempo
declare			
			@id int,
			@data varchar(10),
			@diasemana varchar(20),
			@ano char(4),
			@fimsemana char(3),
			@estacao varchar(15)
					
open c_tempo
	fetch next from c_tempo
	into @id, @data, @diasemana, @ano
while @@fetch_status = 0
begin
			
			 if @diasemana in ('domingo','sábado') 
				set @fimsemana = 'sim'
			 else 
				set @fimsemana = 'não'

			--atualizando estacoes

			if @data between convert(char(4),@ano)+'0923' 
			and convert(char(4),@ano)+'1220'
				set @estacao = 'primavera'

			else if @data between convert(char(4),@ano)+'0321' 
			and convert(char(4),@ano)+'0620'
				set @estacao = 'outono'

			else if @data between convert(char(4),@ano)+'0621' 
			and convert(char(4),@ano)+'0922'
				set @estacao = 'inverno'

			else -- @data between 21/12 e 20/03
				set @estacao = 'verão'

			--atualizando fins de semana
	
			update dim_tempo set fimsemana = @fimsemana
			where idsk = @id

			--atualizando

			update dim_tempo set estacaoano = @estacao
			where idsk = @id
		
	fetch next from c_tempo
	into @id, @data, @diasemana, @ano	
end
close c_tempo
deallocate c_tempo
go
