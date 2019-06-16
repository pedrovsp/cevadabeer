-------------------------------------------------------------------------------------------------------------------------------
-- Relatório para retornar a quantidade de ingredientes por litro para as cervejas Klein Bier, Tubarão Morfina e Beate Weiss:

select 
	c.Id, 
	c.Cor, 
    c.TeorAlcoolico, 
    c.Estilo, 
    c.Nome, 
    c.IBU, 
    c.TempoMaturacao,
    i.Nome,
    pr.Dt_Inicio,
    pr.Dt_Fim,
    pr.Quantidade as Qtd_Litros_Prod,
    sum(co.QtdPorLitro) Total_Qtd_Lts
from cerveja c,
	ingredientes i,
	contem co,
	producao pr
where c.Id in (1,2,3)
	and c.Id = co.fk_Cerveja_Id
	and i.Id = co.fk_Ingredientes_Id
	and c.Id = pr.fk_Cerveja_Id
group by c.Id, 
	c.Cor, 
    c.TeorAlcoolico, 
    c.Estilo, 
    c.Nome, 
    c.IBU, 
    c.TempoMaturacao,
    i.Nome,
    pr.Dt_Inicio,
    pr.Dt_Fim,
    pr.Quantidade;

-------------------------------------------------------------------------------------------------------------------------------
-- Relatório para retornar quais os tipos de cerveja e ingredientes produzido por cada cervejaria:

select 
    cj.Nome as Cervejaria,
    c.Nome as Cerveja,
    i.Nome as Ingredientes
from cervejaria cj,
	produto pr,
	cerveja c,
	contem co,
	ingredientes i
where cj.Id = pr.fk_cervejaria_id
	and pr.fk_cerveja_id = c.id
	and c.Id = co.fk_Cerveja_Id
	and i.Id = co.fk_Ingredientes_Id;

-------------------------------------------------------------------------------------------------------------------------------
-- Relatório para retornar a quantidade de cerveja produzida por cada cervejaria:

select 
    cj.Nome as Cervejaria,
    c.Nome as Cerveja,
    sum(pr.Quantidade) as Qtd_Produto
from cervejaria cj,
	produto pr,
	cerveja c,
	producao pd
where cj.Id = pr.fk_cervejaria_id
	and pr.fk_cerveja_id = c.id
group by cj.Nome,
		 c.Nome;

-------------------------------------------------------------------------------------------------------------------------------
-- Relatório para retornar a quantidade e quais usuários possui cada cervejaria:

select
    cj.Nome as Cervejaria,
    cj.Cidade,
    cj.Estado,
    u.Nome as Usuario,
    u.Email,
    qu.Qtd_Usuarios
from cervejaria cj,
	representa r,
	usuario u,
    (select
		cj.Id,
		cj.Nome as Cervejaria,
		count(u.Id) Qtd_Usuarios
	from cervejaria cj,
		representa r,
		usuario u
	where cj.Id = r.fk_Cervejaria_Id
		and u.Id = r.fk_Usuario_Id
	group by Id, Cervejaria) qu
where cj.Id = r.fk_Cervejaria_Id
and u.Id = r.fk_Usuario_Id
and cj.Id = qu.Id
order by cj.Id;