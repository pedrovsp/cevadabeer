use CevadaBeer;

-- Verifica quais producoes finalizam na data atual e atualiza a data final delas.
DELIMITER $$
CREATE PROCEDURE Finalizar_Producao()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    declare msg varchar(255);
   	declare ids int;
   	declare tempomaturacao int;
   	declare dt_inicio date;
   	declare diferenca int;
    DECLARE cur CURSOR for SELECT Producao.Id, Dt_Inicio, TempoMaturacao FROM Producao, Cerveja WHERE Producao.fk_Cerveja_Id = Cerveja.Id and Dt_Fim is NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
        ins_loop: LOOP
            FETCH cur INTO ids, dt_inicio, tempomaturacao;
            IF done THEN
                LEAVE ins_loop;
            END IF;
            
           	select datediff(CURDATE(), dt_inicio) into diferenca;
           	if (diferenca >= tempomaturacao) then
           		UPDATE Producao SET Dt_Fim = CURDATE() WHERE Id = ids;
			end if;
        END LOOP;
    CLOSE cur;
END;

-- CALL Finalizar_Producao();

-- Verifica se é há igredientes para produzir pelo menos 100 litros de cada cerveja
DELIMITER $$
create procedure Estoque_Ingrediente()
begin
    DECLARE done INT DEFAULT FALSE;
    declare msg varchar(255);
    DECLARE ids INT;
   	declare qtd decimal;
   	declare qtd_litro decimal;
   	declare qtd_total decimal;
    DECLARE cur CURSOR for select Ingredientes.Id, Ingredientes.QuantidadeEstoque, Contem.QtdPorLitro from Ingredientes, Cerveja, Contem where
	Ingredientes.Id = Contem.fk_Ingredientes_Id and Cerveja.Id = Contem.fk_Cerveja_Id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
        ins_loop: LOOP
            FETCH cur INTO ids, qtd, qtd_litro;
            IF done THEN
                LEAVE ins_loop;
            END IF;
            
           	set qtd_total = qtd_litro * 100;
           	if (qtd < qtd_total) then
           		SET	msg	=	'Quantidade de igredientes baixa';
				SIGNAL	SQLSTATE	'45000'	SET	MESSAGE_TEXT	=	msg;
			end if;
        END LOOP;
    CLOSE cur;
end;

-- call Estoque_Ingrediente();

-- Retorna o total de vendas do dia
DELIMITER $$
create PROCEDURE Balanco(in data_balanco date)
BEGIN
	select sum(total_produto) as total from (SELECT Produto.Id, sum(MovimentacaoEstoque.Quantidade) * Valor as total_produto
	from MovimentacaoEstoque, Produto 
	where Data_Registro = data_balanco and Tipo = 'Saida' and Produto.Id = fk_Produto_Id
	group by Produto.Id) as tabela_fracionada;
END;
-- CALL Balanco('2019-10-06');

-- Quanto foi vendido de cada cerveja no dia.
DELIMITER $$
create PROCEDURE TopVendas(in data_balanco date)
BEGIN
	select tabela_fracionada.Nome, MAX(total_produto) as total from (SELECT Cerveja.Nome, Cerveja.Id as id_cerveja, sum(MovimentacaoEstoque.Quantidade) as total_produto
	from MovimentacaoEstoque, Produto, Cerveja
	where Data_Registro = data_balanco and Produto.Id = fk_Produto_Id and Cerveja.Id = fk_Cerveja_Id
	group by Produto.Id) as tabela_fracionada group by tabela_fracionada.id_cerveja;
END;
-- CALL TopVendas('2019-10-06');

-- 
DELIMITER $$
create PROCEDURE Gastos(in data_balanco date)
BEGIN
	SELECT sum(Quantidade) from MovimentacaoEstoque where Data_Registro = data_balanco and Tipo = 'Entrada';
END;
-- CALL Gastos('2019-10-06');