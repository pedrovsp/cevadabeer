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

INSERT INTO CevadaBeer.Contem(QtdPorLitro) 
VALUES (1000), (150), (55), (350);

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

INSERT INTO CevadaBeer.MovimentacaoEstoque(Data_Registro, Tipo, Quantidade)
VALUES
('2019-10-06', "Entrada", 100),
('2019-11-06', "Entrada", 100),
('2019-12-06', "Saída", 100),
('2020-01-06', "Entrada", 100),
('2020-02-06', "Entrada", 100);


INSERT INTO CevadaBeer.Producao(Quantidade, Dt_Inicio, Dt_Fim)
VALUES
(15, '2019-05-01', '2019-07-01'),
(80, '2019-05-10', '2019-07-10'),
(30, '2019-06-20', '2019-10-20');


INSERT INTO CevadaBeer.Produto(Volume, Valor, Quantidade)
VALUES
(600, 17.5, 50),
(1000, 14.9, 24),
(300,10.0, 100),
(15000,150, 10 );

INSERT INTO CevadaBeer.Usuario(Nome, CPF, Senha, Email)
VALUES
("Felipe", "12355514703", "123456789", "felipys@gmail.com"),
("Pedro Vitorino", "66515933339", "123123", "pedrovitorino.sp@gmail.com"),
("Otavio Flauzino", "11552535409", "im123", "otavio@gmail.com");

















