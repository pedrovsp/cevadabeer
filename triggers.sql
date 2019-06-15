use CevadaBeer;

-- before insert movimentacao atualizar estoque
CREATE OR REPLACE TRIGGER before_movimentacao_insert
    BEFORE INSERT ON MovimentacaoEstoque
    FOR EACH ROW
BEGIN
	DECLARE qtd_atual integer;
	select Quantidade into qtd_atual from Produto where Id = new.fk_Produto_Id;
    
	if new.Tipo = 'Entrada' then
		UPDATE Produto
		SET Quantidade = qtd_atual + new.Quantidade
		where Id = new.fk_Produto_Id;
	ELSE IF NEW.Tipo = 'Saída' then
		UPDATE Produto
		SET Quantidade = (qtd_atual - new.Quantidade)
		where Id = new.fk_Produto_Id;
	END if;
	END if;
end;

insert into cevadabeer.movimentacaoestoque(Data_Registro, Tipo, Quantidade, fk_Produto_Id) values ('2019-10-07', "Entrada", 100, 1);

-- before update finalizar producao atualizar MovimentacaoEstoque
-- !!!!!!!!!!!!!!! ERRO !!!!!!!!!!!!! --
CREATE OR REPLACE TRIGGER before_producao_update
    after update ON producao
    FOR EACH ROW
BEGIN
	declare qtd_garrafas integer;
	if new.Dt_Fim <> null then
		set qtd_garrafas = (new.quantidade * 1000) / 600;
	
		INSERT INTO cevadabeer.movimentacaoestoque(Data_Registro, Tipo, Quantidade, fk_Produto_Id)
		VALUES
		(curdate(), "Entrada", qtd_garrafas, 1);
	
	END if;
end;

update cevadabeer.producao set `Dt_Fim` = curdate() where `Id` = 2;

-- before insert on producao verificar igredientes
CREATE OR REPLACE TRIGGER before_producao_insert
    BEFORE INSERT ON producao
    FOR EACH ROW
begin
    DECLARE done INT DEFAULT FALSE;
    declare msg varchar(255);
    DECLARE ids INT;
   	declare qtd decimal;
   	declare qtd_litro decimal;
   	declare qtd_total decimal;
    DECLARE cur CURSOR for select ingredientes.Id, ingredientes.QuantidadeEstoque, contem.QtdPorLitro from ingredientes, cerveja, contem where
	ingredientes.Id = contem.fk_Ingredientes_Id and cerveja.Id = contem.fk_Cerveja_Id and cerveja.Id = new.fk_Cerveja_Id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
        ins_loop: LOOP
            FETCH cur INTO ids, qtd, qtd_litro;
            IF done THEN
                LEAVE ins_loop;
            END IF;
            
           	set qtd_total = qtd_litro * new.Quantidade;
           	if (qtd < qtd_total) then
           		SET	msg	=	'Quantidade de igredientes insuficiente';
				SIGNAL	SQLSTATE	'45000'	SET	MESSAGE_TEXT	=	msg;
			end if;
        END LOOP;
    CLOSE cur;
	
end;

insert into cevadabeer.producao(Dt_Inicio, Quantidade, `fk_Cerveja_Id`) values (curdate(), 10, 1);

-- before atualizar senha verificar se sao diferentes
CREATE OR REPLACE TRIGGER before_usuario_update
    before update ON usuario
    FOR EACH ROW
begin
	declare msg varchar(255);
	if new.Senha = old.Senha then
		SET	msg	=	'Senha invalida';
		SIGNAL	SQLSTATE	'45000'	SET	MESSAGE_TEXT	=	msg;		
	END if;
end;

update cevadabeer.usuario set `Senha` = '2222' where `Id` = 1;

-- 
CREATE OR REPLACE TRIGGER after_producao_insert
    after INSERT ON producao
    FOR EACH ROW
begin
    DECLARE done INT DEFAULT FALSE;
    declare msg varchar(255);
    DECLARE ids INT;
   	declare qtd decimal;
   	declare qtd_litro decimal;
   	declare qtd_total decimal;
    declare nova_qtd decimal;
    DECLARE cur CURSOR for select ingredientes.Id, ingredientes.QuantidadeEstoque, contem.QtdPorLitro from ingredientes, cerveja, contem where
	ingredientes.Id = contem.fk_Ingredientes_Id and cerveja.Id = contem.fk_Cerveja_Id and cerveja.Id = new.fk_Cerveja_Id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
        ins_loop: LOOP
            FETCH cur INTO ids, qtd, qtd_litro;
            IF done THEN
                LEAVE ins_loop;
            END IF;
            
           	set qtd_total = qtd_litro * new.Quantidade;
            set nova_qtd = qtd - qtd_total;
           	update Ingredientes set QuantidadeEstoque = qtd_total where Id = ids;
        END LOOP;
    CLOSE cur;
	
end;

insert into cevadabeer.producao(Dt_Inicio, Quantidade, `fk_Cerveja_Id`) values (curdate(), 10, 1);