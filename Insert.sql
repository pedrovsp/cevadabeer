use CevadaBeer;

INSERT INTO CevadaBeer.Cerveja(Cor, TeorAlcoolico, Estilo, Nome, IBU, TempoMaturacao)
VALUES 
("Dourada",5.4,"American Pale Ale", "Klein Bier", 50, 720),
("Cobre", 8,"IPA", "Tubarão Morfina",63, 1000),
("Dourada", 5,"Weiss", "Beate Weiss",45, 720),
("Dourada", 6.5,"New England IPA", "Roleta Russa",47, 1050);

INSERT INTO CevadaBeer.Cervejaria(Nome, TipoLogradouro, NomeLogradouro, NumLogradouro, Cidade, Estado)
VALUES
("Uberbrau", "Av.", "Getulio Vargas", 35, "Uberlândia", "Minas Gerais"),
("Alienada", "Rua", "do IFTM", 1500, "Uberlândia", "Minas Gerais"),
("Pelizer", "Rua", "Santa Mônica", 33, "Uberlândia", "Minas Gerais"),
("Captain Brew", "Av.", "dos desconhecidos", 2389, "Uberlândia", "Minas Gerais");


INSERT INTO CevadaBeer.Ingredientes(Nome, QuantidadeEstoque) 
VALUES 
("Malte", 25000),
("Lupulus", 25000),
("Agua", 35000),
("Cevada",8200),
("Trigo", 2000),
("Leveduras", 1000),
("Banana", 50000),
("Cajarana", 55000),
("Cafe", 1000),
("Tamarindo", 1000);

INSERT INTO CevadaBeer.Contem(fk_Ingredientes_Id, fk_Cerveja_Id, QtdPorLitro)
VALUES
(1, 1, 30),
(2, 1, 50),
(3, 1, 50),
(1, 2, 50),
(2, 3, 100),
(4, 4, 100);

INSERT INTO CevadaBeer.Produto(fk_Cerveja_Id, Volume, Valor, Quantidade, fk_Cervejaria_Id)
VALUES
(1, 600, 17.5, 50, 1),
(2, 1000, 14.9, 24, 1),
(3, 300,10.0, 100, 4),
(4, 15000,150, 10, 3 );

INSERT INTO CevadaBeer.MovimentacaoEstoque(Data_Registro, Tipo, Quantidade, fk_Produto_Id)
VALUES
('2019-10-06', "Saida", 100, 1),
('2019-10-06', "Saida", 100, 1),
('2019-12-06', "Saída", 100, 2),
('2020-01-06', "Entrada", 100, 3),
('2020-02-06', "Entrada", 100, 4),
('2019-10-06', "Saida", 150, 2),
('2019-10-06', "Saida", 100, 2),
('2019-10-06', "Saida", 130, 3);

INSERT INTO CevadaBeer.Producao(fk_Cerveja_Id, Quantidade, Dt_Inicio, Dt_Fim)
VALUES
(1, 15, '2019-05-01', '2019-07-01'),
(2, 80, '2019-05-10', '2019-07-10'),
(3, 100, '2019-05-10', '2019-07-15'),
(3, 500, '2019-05-10', null),
(3, 500, '2019-05-10', null),
(4, 30, '2019-06-20', '2019-10-20');



INSERT INTO CevadaBeer.Usuario(Nome, CPF, Senha, Email)
VALUES
("Felipe", "12355514703", "2222", "felipys@gmail.com"),
("Pedro Vitorino", "66515933339", "123123", "pedrovitorino.sp@gmail.com"),
("Otavio Flauzino", "11552535409", "im123", "otavio@gmail.com");

INSERT INTO CevadaBeer.Representa(fk_Cervejaria_Id, fk_Usuario_Id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(1, 2);














