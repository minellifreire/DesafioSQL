CREATE DATABASE Desafio01;

CREATE TABLE Usuario (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Email VARCHAR(50),
    Senha VARCHAR(64)
);

CREATE TABLE Comprador (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Endereco VARCHAR(50),
    Numero VARCHAR(5),
    Cidade VARCHAR(50),
    Estado VARCHAR(50)
);

CREATE TABLE Produto (
    ID INT PRIMARY KEY,
    IDUsuario INT,
    IDComprador INT,
    NomeProduto VARCHAR(50),
    TipoDispositivo VARCHAR(30),
    Descricao VARCHAR(1000),
    PrecoVenda DECIMAL(5,2),
    EstoqueDisponivel TINYINT,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(ID), 
    FOREIGN KEY (IDComprador) REFERENCES Comprador(ID)
);

CREATE TABLE Venda (
    ID INT PRIMARY KEY,
    IDUsuario INT,
    DataVenda DATETIME,
    QuantidadeVendida INT,
    ValorTotalVenda DECIMAL(10,2),
    NumeroParcela INT,
    ValorParcela DECIMAL(10,2),
    JurosAplicados DECIMAL(5,2),
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(ID)
);


CREATE TABLE Pagamento (
    ID INT PRIMARY KEY,
    IDComprador INT,
    TipoPagamento VARCHAR(20),
    ValorPago DECIMAL(10,2),
    DataPagamento DATETIME,
    PercentualTaxa DECIMAL(5,2),
    FOREIGN KEY (IDComprador) REFERENCES Comprador(ID)
);

INSERT INTO Usuario (ID, Nome, Email, Senha)
VALUES
    (1, 'Jo�o', 'joao@smn.com', 'senha123'),
    (2, 'Maria', 'maria@smn.com', 'senha456'),
    (3, 'Carlos', 'carlos@smn.com', 'senha789');

INSERT INTO Comprador (ID, Nome, Sobrenome, Endereco, Numero, Cidade, Estado)
VALUES
    (1, 'Jos�', 'Silva', 'Rua Amado Batists', '123', 'Cidade Cruz do Espirito Santo', 'Espirito Santo'),
    (2, 'Ana', 'Santos', 'Rua Holistic', '456', 'Cidade Ametista', 'S�o Paulo');

INSERT INTO Produto (ID, IDUsuario, IDComprador, NomeProduto, TipoDispositivo, Descricao, PrecoVenda, EstoqueDisponivel)
VALUES
    (1, 1, 1, 'Celular Modelo X', 'Smartphone', '�timo celular com c�mera de alta qualidade.', 800.00, 10),
    (2, 1, 2, 'Tablet Modelo Y', 'Tablet', 'Tablet com tela grande e excelente desempenho.', 350.00, 5);

INSERT INTO Venda (ID, IDUsuario, DataVenda, QuantidadeVendida, ValorTotalVenda, NumeroParcela, ValorParcela, JurosAplicados)
VALUES
    (1, 1, '2023-08-01', 3, 2400.00, 11, 800.00, 0.05),
    (2, 1, '2023-08-05', 2, 700.00, 1, 700.00, 0.00);

INSERT INTO Pagamento (ID, IDComprador, TipoPagamento, ValorPago, DataPagamento, PercentualTaxa)
VALUES
    (1, 1, 'Cart�o de Cr�dito', 240.00, '2023-08-02', 0.10),
    (2, 2, 'Cart�o de Cr�dito', 700.00, '2023-08-06', 0.00);

--Select para todos os dispositivos disponiveis para venda:

SELECT NomeProduto, PrecoVenda, EstoqueDisponivel
FROM Produto;

-- Select para filtrar os compradores e seus estados:

SELECT c.Nome, c.Sobrenome, c.Estado
FROM Comprador c;

--Select para calcular o valor total vendido por vendedor:

SELECT u.Nome, SUM(v.ValorTotalVenda) AS TotalVendido
FROM Usuario u
JOIN Venda v ON u.ID = v.IDUsuario
GROUP BY u.Nome;

--Select para calcular o valor pago e seu tipo de pagamento:

SELECT TipoPagamento, SUM(ValorPago) AS TotalPago
FROM Pagamento
GROUP BY TipoPagamento;

--Select para filtar todos os usu�rios cadastrados:

SELECT * FROM Usuario;
