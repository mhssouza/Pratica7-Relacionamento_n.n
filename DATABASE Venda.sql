CREATE DATABASE Venda;

USE Venda;

CREATE TABLE Endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    cep VARCHAR(45),
    bairro VARCHAR(45),
    estado VARCHAR(45),
    cidade VARCHAR(45),
	num INT,
    complemento VARCHAR(45)
)AUTO_INCREMENT = 500;

INSERT INTO Endereco VALUES
	(null, '123456-789', 'Rua Marcelo Neves', 'São Paulo', 'São Paulo', 125, null),
    (null, '987654-321', 'Rua Mineiro da Silva', 'São Paulo', 'São Paulo', 32, null);
    
CREATE TABLE Cliente(
	idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
	email VARCHAR(45),
    fkEndereco INT,
    fkIndicador INT,
    CONSTRAINT fkClienteEndereco FOREIGN KEY (fkEndereco)
		REFERENCES Endereco(idEndereco),
	CONSTRAINT fkClienteIndicador FOREIGN KEY (fkIndicador)
		REFERENCES Cliente(idCliente)
);

INSERT INTO Cliente VALUES
	(null, 'Mário', 'mario.nintendo@gmail.com', 500, null),
    (null, 'Sonic', 'sonic.sega@gmail.com', 501, 1),
    (null, 'Luigi', 'luigi.nintendo@gmail.com', 500, 1);

CREATE TABLE Vendas(
	idVenda INT AUTO_INCREMENT,
    fkCliente INT, PRIMARY KEY(idVenda, fkCliente),
    totalVenda DECIMAL(8,2),
    dtVenda DATE,
    CONSTRAINT fkCliente FOREIGN KEY (fkCliente)
		REFERENCES Cliente(idCliente)
);

CREATE TABLE Produto(
	idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    descricao VARCHAR(300),
    preco DECIMAL(8,2)
);

INSERT INTO Produto VALUES
	(null, 'Anel de Ouro', 'Um anel de ouro com propriedades mágicas, dizem que pode salvar vidas.', 9.99),
    (null, 'Flor de Chamas', 'Uma flor com uma temperatura bem alta, talvez te dê poderes de chamas!', 19.99),
    (null, 'Cogumelo', 'Um cogumelo estranho, por algum motivo te faz crescer.', 24.99),
    (null, 'Tênis Vermelho', 'Um tênis vermelho bem estiloso!', 10.50),
    (null, 'Chapéu de Encanador', 'Um chapéu de um famoso encanador que fazia mais que seu traballho.', 29.99);
    
INSERT INTO Vendas VALUES
	(null, 1, 21.60, '2023-04-07'),
    (null, 2, 19.99, '2023-09-10'),
    (null, 3, 24.99, '2023-05-12'),
    (null, 1, 10.50, '2023-10-04'),
    (null, 2, 29.99, '2023-06-06');
    
CREATE TABLE NotaFiscal (
    idNotaFiscal INT,
    fkVenda INT,
    fkProduto INT,
    quantidade INT,
    valorDesconto DECIMAL(8, 2),
	PRIMARY KEY (fkProduto, fkVenda, idNotaFiscal),
    CONSTRAINT fkVendaNota FOREIGN KEY (fkVenda)
		REFERENCES Vendas(idVenda),
    CONSTRAINT fkProdutNota FOREIGN KEY (fkProduto) 
		REFERENCES Produto(idProduto)
)AUTO_INCREMENT = 700;

INSERT INTO NotaFiscal VALUES
	(700, 1, 1, 2, 2.99),
    (701, 2, 3, 3, 0.00),
    (702, 3, 2, 2, 3.99),
    (703, 4, 4, 1, 9.99);
    
SELECT * FROM Endereco;
SELECT * FROM Cliente;
SELECT * FROM Vendas;
SELECT * FROM Produto;
SELECT * FROM NotaFiscal;

SELECT * FROM Cliente JOIN Vendas
	ON idCliente = fkCliente
		WHERE nome = 'Sonic';
        
SELECT c1.nome AS Indicado, c2.nome AS Indicador
FROM Cliente c1
LEFT JOIN Cliente c2 ON c1.fkIndicador = c2.idCliente;

SELECT c.nome AS Cliente, c2.nome AS Indicador, v.idVenda AS IdVenda, p.nome AS Produto
FROM Cliente c
LEFT JOIN Cliente c2 ON c.fkIndicador = c2.idCliente
LEFT JOIN Vendas v ON c.idCliente = v.fkCliente
LEFT JOIN NotaFiscal nf ON v.idVenda = nf.fkVenda
LEFT JOIN Produto p ON nf.fkProduto = p.idProduto;

SELECT v.dtVenda, p.nome AS Produto, nf.quantidade
FROM Vendas v
INNER JOIN NotaFiscal nf ON v.idVenda = nf.fkVenda
INNER JOIN Produto p ON nf.fkProduto = p.idProduto
WHERE v.idVenda = 1;

INSERT INTO Cliente (nome, email, fkEndereco, fkIndicador)
VALUES ('Tails', 'tails.sega@email.com', 501, 2);

SELECT c.nome AS Cliente, v.idVenda AS IdVenda
FROM Cliente c
LEFT JOIN Vendas v ON c.idCliente = v.fkCliente;

SELECT c.nome AS ClienteSemVenda
FROM Cliente c
LEFT JOIN Vendas v ON c.idCliente = v.fkCliente
WHERE v.idVenda IS NULL;
