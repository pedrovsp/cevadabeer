user CevadaBeer

-- before update movimentacao atualizar estoque
CREATE TRIGGER before_movimentacao_insert
    BEFORE UPDATE ON employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW(); 
END

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