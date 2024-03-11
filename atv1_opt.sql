CREATE DATABASE opt120
USE opt120;

CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    senha VARCHAR(100)
);

CREATE TABLE Atividade(
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    descricao VARCHAR(100),
    nota FLOAT,
    data_atv DATETIME
);

CREATE TABLE Usuario_Atividade(
    usuario_id INT,
    atividade_id INT,
    entrega DATETIME,
    nota FLOAT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (atividade_id) REFERENCES atividade(id),
    PRIMARY KEY (usuario_id, atividade_id)
);
