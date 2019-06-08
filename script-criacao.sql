/* Logico_Integrador: */
use CevadaBeer;
CREATE TABLE Cerveja (
    Id INTEGER PRIMARY KEY,
    Cor VARCHAR(255),
    TeorAlcoolico DECIMAL,
    Estilo VARCHAR(255),
    Nome VARCHAR(255),
    IBU DECIMAL,
    IdReceita INTEGER,
    TempoMaturacao DECIMAL
);

CREATE TABLE Igredientes (
    Id INTEGER PRIMARY KEY,
    Nome VARCHAR(255),
    QuantidadeEstoque DECIMAL
);

CREATE TABLE Produto (
    Id INTEGER PRIMARY KEY,
    Volume DECIMAL,
    Valor DECIMAL,
    Quantidade INTEGER,
    fk_Cerveja_Id INTEGER,
    fk_Cervejaria_Id INTEGER
);

CREATE TABLE Producao (
    Id INTEGER PRIMARY KEY,
    Quantidade DECIMAL,
    Dt_Inicio DATE,
    Dt_Fim DATE,
    fk_Cerveja_Id INTEGER
);

CREATE TABLE Cervejaria (
    Id INTEGER PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255)
);

CREATE TABLE Usuario (
    Id INTEGER PRIMARY KEY,
    Nome VARCHAR(255),
    CPF VARCHAR(11),
    Senha VARCHAR(24),
    Email VARCHAR(50)
);

CREATE TABLE MovimentacaoEstoque (
    Id INTEGER PRIMARY KEY,
    Data DATE,
    Tipo VARCHAR(255),
    Quantidade INTEGER,
    fk_Produto_Id INTEGER
);

CREATE TABLE Representa (
    fk_Cervejaria_Id INTEGER,
    fk_Usuario_Id INTEGER,
    Id INTEGER PRIMARY KEY
);

CREATE TABLE Contem (
    fk_Igredientes_Id INTEGER,
    fk_Cerveja_Id INTEGER,
    QtdPorLitro DECIMAL,
    Id INTEGER PRIMARY KEY
);
 
ALTER TABLE Produto ADD CONSTRAINT FK_Produto_2
    FOREIGN KEY (fk_Cerveja_Id)
    REFERENCES Cerveja (Id)
    ON DELETE CASCADE;
 
ALTER TABLE Produto ADD CONSTRAINT FK_Produto_3
    FOREIGN KEY (fk_Cervejaria_Id)
    REFERENCES Cervejaria (Id)
    ON DELETE SET NULL;
 
ALTER TABLE Producao ADD CONSTRAINT FK_Producao_2
    FOREIGN KEY (fk_Cerveja_Id)
    REFERENCES Cerveja (Id)
    ON DELETE CASCADE;
 
ALTER TABLE MovimentacaoEstoque ADD CONSTRAINT FK_MovimentacaoEstoque_2
    FOREIGN KEY (fk_Produto_Id)
    REFERENCES Produto (Id)
    ON DELETE CASCADE;
 
ALTER TABLE Representa ADD CONSTRAINT FK_Representa_2
    FOREIGN KEY (fk_Cervejaria_Id)
    REFERENCES Cervejaria (Id)
    ON DELETE SET NULL;
 
ALTER TABLE Representa ADD CONSTRAINT FK_Representa_3
    FOREIGN KEY (fk_Usuario_Id)
    REFERENCES Usuario (Id)
    ON DELETE SET NULL;
 
ALTER TABLE Contem ADD CONSTRAINT FK_Contem_2
    FOREIGN KEY (fk_Igredientes_Id)
    REFERENCES Igredientes (Id)
    ON DELETE RESTRICT;
 
ALTER TABLE Contem ADD CONSTRAINT FK_Contem_3
    FOREIGN KEY (fk_Cerveja_Id)
    REFERENCES Cerveja (Id)
    ON DELETE RESTRICT;