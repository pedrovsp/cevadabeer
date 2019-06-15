use CevadaBeer;

-- before insert movimentacao atualizar estoque
CREATE OR REPLACE TRIGGER before_movimentacao_insert
    BEFORE INSERT ON MovimentacaoEstoque
    FOR EACH ROW
DECLARE qtd_atual;
BEGIN
	select Quantidade into qtd_atual from Produto where Id = new.fk_Produto_Id;
    
	if new.Tipo = 'Entrada' then
		UPDATE Produto
		SET Quantidade = (select Quantidade from Produto where Id = new.fk_Produto_Id) + new.Quantidade
		where Id = new.fk_Produto_Id;
	ELSE
		UPDATE Produto
		SET Quantidade = ((select Quantidade from Produto where Id = new.fk_Produto_Id) - new.Quantidade)
		where Id = new.fk_Produto_Id;
	END if
end

-- before update finalizar producao atualizar MovimentacaoEstoque

-- before insert on producao verificar igredientes

-- before atualizar senha verificar se são diferentes

-- 

-- 4 function
-- function criar receita

-- function iniciar Producao

-- function finalizar producao

-- function comprar igredientes (adicionar igredienes no estoque)


-- 5 procedure
-- procedure checar se producao finalizou

-- procedure checar se ha igredientes para todos cervejas

-- procedure checar se ha igredienes para produzir a media de cerveja do mes anterior

-- procedure checar quais producoes finalizam amanha

-- procedure checar se ha cerveja mais pedida no estoque

-- relatorios
-- retornar producoes que vao terminar na proxima semana
-- retornar produtos baixo no estoque
-- retornar igredientes baixos no estoque