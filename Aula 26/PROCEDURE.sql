
--Criando um banco
CREATE DATABASE FRAUDE

-- Criando a tabela para recer o Excel 
CREATE TABLE BaseFraude
(
		DataTransacao		DATETIME,
		Cliente				VARCHAR (50),
		TipoTransacao		VARCHAR(50),
		Valor_Transacao		FLOAT,
		Bandeira			VARCHAR (50),
		Aprovado			VARCHAR (50)
)

-- Inserindo da pasta para o Banco/ Subindo planilha do Excel para o SQL

BULK INSERT BaseFraude									-- Carrega os dados de um arquivo CSV para a BaseFraude
FROM 'C:\Users\User\Desktop\TempCarga\Base_Fraude.csv'  -- Caminho completo do arquivo CSV

with 
(
	FIRSTROW = 2,			-- Importa a partir da segunda linha por conta do cabeçalho 
	FIELDTERMINATOR = ',',	-- Defini o separador de condição (CSV,|)
	ROWTERMINATOR = '\n',   -- Defini a cada linha como quebra 
	CODEPAGE = '65001'     -- Defini o código de páginas como UTF 8
)


-- Consultando a tabela BaseFraude
SELECT*
FROM BaseFraude


/*Introdução a Procedure 
 Uma PROC/ PROCEDURE é um conjunto de comandos SQL armazenado no banco de dados, 
que pode ser executado sob demanda, como uma função reutilizável.

Vantagens: 
Reutilizável
Padronização
Melhora a perfomance 
Segurança no controle (select) / PROC 

*/
--========================================================================
-- Criando uma PROCEDURE

CREATE PROCEDURE NomedaProc

AS 
		Begin 
		       -- instrução SQL que usaremos os parametros
		END 

-- Nome que ira selecionar/ Chamar a Procedure 
EXEC NomedaProc
--=========================================================



-- 1) PROCEDURE 
CREATE PROCEDURE Selecionar_TodasTrasacoes

AS
	BEGIN

	SELECT *
	FROM BaseFraude
	
	END;
	GO 

Exec Selecionar_TodasTrasacoes

--==============================================

-- 2) PROCEDURE criando 
CREATE PROCEDURE ListarTransacoesPorCliente 
@Cliente Nvarchar (100)
 
AS
	BEGIN 
	Select 
	TipoTransacao,
	Valor_Transacao,
	Cliente,
	Aprovado
	From BaseFraude 
	WHERE Cliente = @Cliente
	AND Aprovado = @Aprovado 

	END

	GO 

EXEC ListarTransacoesPorCliente @Cliente = 'Cliente 2'

-- Alteando a Procedure de cima 
ALTER PROCEDURE ListarTransacoesPorCliente 

@Cliente Nvarchar (100),
@Aprovado Nvarchar (10)
 
AS
	BEGIN 
	Select 
	TipoTransacao,
	Valor_Transacao,
	Cliente,
	Aprovado
	From BaseFraude 
	WHERE Cliente = @Cliente
	AND Aprovado = @Aprovado 

	END

	GO 

EXEC ListarTransacoesPorCliente @Cliente = 'Cliente 2', @Aprovado = 'Não'

