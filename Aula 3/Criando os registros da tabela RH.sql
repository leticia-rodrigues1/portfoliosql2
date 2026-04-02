-- Criando a tabela Func dentro do RH 
CREATE TABLE Func 
(	
	id_func		int identity (1,1),
	nome		varchar (255),
	sexo		varchar(255),
	endereco	varchar (255),
	salario		decimal (5,4),
)


-- Consultando a tabela Fun do RH criada sem registro ainda 
SELECT *
FROM Func

-- Inserindo registros dentro da tabela Func do RH
INSERT INTO Func ( nome, sexo, endereco, salario)
VALUES 
('CLARA', 'FEMININO','SAMPAIO', 1.000),
('CECILIA', 'FEMININO', 'RUA 7', 3.000),
 ('RODRIGO', 'MASCULINO', 'CAVOUR', 5.000)

 -- DELETEI O NOME LETICIA QUE ESTAVA REPETIDO
 DELETE FROM Func
WHERE id_func IN (8, 15)