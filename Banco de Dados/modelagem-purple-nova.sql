CREATE DATABASE purplex;
USE purplex;

CREATE TABLE contato (
	idContato INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(100),
    assunto VARCHAR(100),
    momentoContato DATETIME
);

CREATE TABLE sensor (
	idSensor INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE parametro (
	idParametro INT PRIMARY KEY AUTO_INCREMENT,
    demandaAlta INT,
    demandaBaixa INT
);

CREATE TABLE registro (
	idRegistro INT,
    fkSensor INT,
    registro CHAR(1),
    momento DATETIME
);

ALTER TABLE registro ADD CONSTRAINT chavesPrimariasRegistro PRIMARY KEY (idRegistro, fkSensor);
ALTER TABLE registro MODIFY COLUMN idRegistro INT AUTO_INCREMENT;
ALTER TABLE registro ADD CONSTRAINT fkSensorRegistro FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor);

CREATE TABLE academia (
	idAcademia INT,
    fkMatriz INT,
    nome VARCHAR(100),
    cnpj CHAR(14)
);

ALTER TABLE academia ADD CONSTRAINT chavesPrimariasAcademia PRIMARY KEY (idAcademia, fkMatriz);
ALTER TABLE academia MODIFY COLUMN idAcademia INT AUTO_INCREMENT;
ALTER TABLE academia ADD CONSTRAINT fkMatrizAcademia FOREIGN KEY (fkMatriz) REFERENCES academia(idAcademia);

CREATE TABLE aparelho (
	idAparelho INT,
    fkAcademia INT,
    fkSensor INT,
    fkParametro INT,
    nome VARCHAR(45),
    categoria VARCHAR(45)
);

ALTER TABLE aparelho ADD CONSTRAINT chavesPrimariasAparelho PRIMARY KEY (idAparelho, fkAcademia, fkSensor, fkParametro);
ALTER TABLE aparelho MODIFY COLUMN idAparelho INT AUTO_INCREMENT;
ALTER TABLE aparelho ADD CONSTRAINT fkAcademiaAparelho FOREIGN KEY (fkAcademia) REFERENCES academia(idAcademia);
ALTER TABLE aparelho ADD CONSTRAINT fkSensorAparelho FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor);
ALTER TABLE aparelho ADD CONSTRAINT fkParemetroAparelho FOREIGN KEY (fkParametro) REFERENCES parametro(idParametro); 


INSERT INTO contato (nome, email, assunto, momentoContato) VALUES
('João Silva', 'joao.silva@gmail.com', 'Informações sobre planos', '2024-05-25 10:30:00'),
('Maria Souza', 'maria.souza@yahoo.com', 'Horários de funcionamento', '2024-05-24 15:20:00'),
('Carlos Pereira', 'carlos.pereira@hotmail.com', 'Descontos e promoções', '2024-05-23 09:15:00');

-- PARA INSERIR 3 IDS NA TABELA DOS SENSOR
INSERT INTO sensor () VALUES (), (), ();

INSERT INTO parametro (demandaAlta, demandaBaixa) VALUES
(80, 20),
(90, 10),
(70, 30);

-- Inserir dados na tabela registro para todos os sensores com números mais aleatórios
INSERT INTO registro (fkSensor, registro, momento) VALUES
(1, '1', '2024-05-25 08:00:00'),
(1, '0', '2024-05-25 08:07:00'),
(1, '1', '2024-05-25 08:15:00'),
(1, '0', '2024-05-25 08:22:00'),
(1, '1', '2024-05-25 08:30:00'),
(1, '0', '2024-05-25 08:45:00'),
(2, '0', '2024-05-25 09:00:00'),
(2, '1', '2024-05-25 09:05:00'),
(2, '0', '2024-05-25 09:12:00'),
(2, '1', '2024-05-25 09:20:00'),
(2, '0', '2024-05-25 09:35:00'),
(2, '1', '2024-05-25 09:50:00'),
(3, '1', '2024-05-25 10:00:00'),
(3, '0', '2024-05-25 10:08:00'),
(3, '1', '2024-05-25 10:16:00'),
(3, '0', '2024-05-25 10:25:00'),
(3, '1', '2024-05-25 10:32:00'),
(3, '0', '2024-05-25 10:48:00');


INSERT INTO academia (fkMatriz, nome, cnpj) VALUES
(1, 'Smart Fit', '12345678000195'),
(1, 'Smart Fit - Unidade 1', '12345678000275'),
(1, 'Smart Fit - Unidade 2', '12345678000355');

INSERT INTO aparelho (fkAcademia, fkSensor, fkParametro, nome, categoria) VALUES
(1, 1, 1, 'Esteira', 'Cardio'),
(2, 2, 2, 'Bicicleta', 'Cardio'),
(3, 3, 3, 'Leg Press', 'Musculação');


SELECT * FROM contato;
SELECT * FROM sensor;
SELECT * FROM parametro;
SELECT * FROM registro;
SELECT * FROM academia;
SELECT * FROM aparelho;

-- SELECIONANDO OS APARELHOS E A DEMANDA ALTA E BAIXA DE CADA
SELECT ap.nome AS 'Nome do aparelho', pa.demandaAlta AS 'Valor de demanda alta', 
pa.demandaBaixa AS 'Valor da demanda baixa' FROM aparelho AS ap
JOIN parametro AS pa ON ap.fkParametro = pa.idParametro;

-- SELECIONANDO A QUANTIDADE DE VEZES QUE O APARELHO 1 TEVE O REGISTRO 0
SELECT ap.nome AS 'Nome do aparelho', COUNT(*) AS 'Quantidade de resgitros 0' FROM registro AS re
JOIN aparelho AS ap ON re.fkSensor = ap.fkSensor
WHERE ap.idAparelho = 1 AND re.registro = 0
GROUP BY ap.nome;




