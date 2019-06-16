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

CREATE FUNCTION	verificarAgua()		
RETURN VARCHAR
BEGIN
DECLARE idSemAgua int;
IF ((SELECT nome FROM Ingredientes) != "Agua" AND 
	(SELECT nome FROM Ingredientes) != "Água") {
	SET idSemAgua = (SELECT id FROM Ingredientes);
}
IF((SELECT fk_Ingredientes_Id FROM Contem) = idSemAgua) {
RETURN PRINT ('O produto de id ', idSemAgua, ' está sem água');
}

END |

DELIMITER ;


/***********************************************************/

/*Função 3 - Mostra duplicidade de CPF*/
DELIMITER |
CREATE FUNCTION mostrarDuplicidadeCPF()
BEGIN
SELECT Nome, CPF, Count(*) FROM Usuario
GROUP BY CPF
HAVING Count(*) > 1;
END |
DELIMITER ;

/***********************************************************/

/*Função 4 - Mostra produtos fabricados a partir daquela data*/
DELIMITER |
CREATE FUNCTION mostrarProdutosAposData(data_evento DATE)
RETURNS TABLE(id int, Qtd decimal, d_inicio date, d_fim date)
AS
BEGIN
SELECT 
fk_Cerveja_Id,
Quantidade,
Dt_Inicio,
Dt_Fim
FROM Producao WHERE Dt_Fim >= data_evento;
RETURN 
END |
DELIMITER ;
    






