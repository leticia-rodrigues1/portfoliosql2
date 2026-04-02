
-- Criando banco de dados do projeto RH
CREATE DATABASE RH


-- Criando tabela 
CREATE TABLE Func
(
id_func		int identity(1,1),
nome		varchar (255),
sexo		varchar (255),
endereco	varchar(255),
salario		decimal(5,4),

)

-- Conferindo se acima tabela foi criada 
SELECT *
FROM Func

