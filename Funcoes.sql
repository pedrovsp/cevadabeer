use CevadaBeer;
/*Função 1 - Calcular o valor total, em reais, de todos os produtos em estoque*/

DELIMITER |		

CREATE FUNCTION	calcularValorEstoque()		

RETURNS	numeric(20,2)

BEGIN	
	
DECLARE	valorReaisEstoque numeric(10,2);	
SET valorReaisEstoque = (
SELECT SUM(QuantidadeEstoque*ValorUnitario)
FROM Ingredientes
);

RETURN	valorReaisEstoque;	

END |


DELIMITER ;
/***********************************************************/

/*Função 2 - Verificar se o produto contem água*/

DELIMITER |

CREATE FUNCTION	verificarAgua(id_agua int)		
RETURNS int
BEGIN
DECLARE agua int;
SELECT QuantidadeEstoque into agua from Ingredientes where Id = id_agua;
IF(agua < 3000) THEN
	SIGNAL SQLSTATE '45000'	SET	MESSAGE_TEXT = 'Pouca agua';
else return agua;
end if;
END; |

DELIMITER ;


/***********************************************************/

/*Função 3 - Mostra duplicidade de CPF*/
DELIMITER |
CREATE FUNCTION mostrarDuplicidadeCPF(cpf varchar(11))
RETURNS boolean
BEGIN
declare cpf_count varchar(11);
SELECT  Count(*) into cpf_count FROM Usuario where cpf = cpf;
if (cpf_count > 1) THEN
	return true;
else
	return false;
end if;
END; |
DELIMITER ;

/***********************************************************/

/*Função 4 - Mostra quantas garrafas de 1L uma producao cria*/
DELIMITER |
create function fn_qtd_garrafas (qtd_l int, qtd_v decimal(10,0))
returns decimal(10,0)
begin
	return qtd_l*1000/qtd_v;
end; |
DELIMITER ;