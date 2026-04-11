/* 
FUNCTION
Já as functions, ou funções, constuma ser mais limitadas, geralmente retornam um único 
valor e podem ser usadas dentro de consultas como se fossem colunas. Assim, cada uma 
tem a sua utilidade dependendo do que você precisa fazer.
*/

/*
PROCEDURES
As procedures, ou procedimentos armazenados, são mais versáteis,
porque podem executar vários comandos de uma vez e podem retornar múltiplos conjuntos de resultados.
*/

/*
1. Introdução: O que é uma Function?
Uma Function (ou UDF - User Defined Function)
é um bloco de código que pode receber parâmetros, executar operações e retornar um valor.

São muito úteis para reutilizar lógica de negócios, limpar código e encapsular regras de cálculo. 

*/

/*
2. Tipos de Functions no SQL Server 

Tipo                              | Retorno                 | Pode ser usada em SELECT	|Exempo de uso 
**Scalar Function**				  |Valor único              |?							| Calculadora de imposto
**Inline Table-Valued**			  |Tabela (1 SELECT)        |?							|Filtro de clientes ativos
**Multi-Statement Table-Valued**  |Tabela (vários steps)    |?							|Lógica mais complexa, com IFs etc.

--Crie uma tabela 
-- Exercício FUCTION 
 */

IF OBJECT_ID('dbo.tb_transacoes_Func_Json') IS NOT NULL
BEGIN
    DROP TABLE dbo.tb_transacoes_Func_Json
END;
GO

CREATE TABLE dbo.tb_transacoes_Func_Json
(
    DataTransacao      NVARCHAR(30),
    Cliente            NVARCHAR(100),
    TipoTransacao      NVARCHAR(50),
    Valor_Transacoes   DECIMAL(10,2),
    Bandeira           NVARCHAR(50),
    Aprovado           NVARCHAR(10)
);
GO

DECLARE @json NVARCHAR(MAX);

SELECT @json = BulkColumn
FROM OPENROWSET(
    BULK 'C:\JSON\transacoes.json',
    SINGLE_CLOB
) AS JsonData;

INSERT INTO dbo.tb_transacoes_Func_Json
(
    DataTransacao,
    Cliente,
    TipoTransacao,
    Valor_Transacoes,
    Bandeira,
    Aprovado
)
SELECT
    DataTransacao,
    Cliente,
    TipoTransacao,
    Valor_Transacoes,
    Bandeira,
    Aprovado
FROM OPENJSON(@json)
WITH
(
    DataTransacao      NVARCHAR(30),
    Cliente            NVARCHAR(100),
    TipoTransacao      NVARCHAR(50),
    Valor_Transacoes   DECIMAL(10,2),
    Bandeira           NVARCHAR(50),
    Aprovado           NVARCHAR(10)
);

SELECT * 
FROM dbo.tb_transacoes_Func_Json;

--==================================================================
-- Exercício 1 criando FUNCTION 

CREATE FUNCTION fn_Saudacao(@nome VARCHAR (100))
RETURNS NVARCHAR(100)
AS

	BEGIN 
		RETURN 'Olá, ' +@nome + '!' 
	END 


SELECT 
			Valor_Transacoes,
			dbo.fn_Saudacao(Cliente) as Saudacao,
			DataTransacao
FROM dbo.tb_transacoes_Func_Json

--===================================================================
-- EXERICÍCIO 2 CRIANDO FUNCTION 

CREATE FUNCTION fn_TransacaoFraude()
RETURNS TABLE

AS 
		RETURN(
		SELECT *
		FROM tb_transacoes_Func_Json
		WHERE TipoTransacao = 'Fraude'
		);

SELECT *
FROM  fn_TransacaoFraude()

--====================================================================
-- EXERCICIO 3 CRIANDO FUNCTION	

CREATE FUNCTION fn_StatusAprovado(@status NVARCHAR (30))
RETURNS NVARCHAR (30)

AS 
		BEGIN
		Return 
		Case
		when @status = 'Sim'then 'Aprovada com Sucesso'
		when @status = 'Não' then 'Reprovada com Sucesso'
		else 'Status Desconhecido'
		END 
END 

SELECT 
			Cliente,
			Aprovado,
			dbo.fn_StatusAprovado(Aprovado) as StatusDetalhado 
FROM tb_transacoes_Func_Json;


--- CORREÇÃO DOS CARACTERES
SELECT 
		Cliente,
		REPLACE(Aprovado, 'NÃ£o', 'Não') as Corrigido 
FROM tb_transacoes_Func_Json;

---=============================================================
--EXERCÍCIO FUNÇÕES

CREATE FUNCTION	dbo.fn_conced_desc ( @valor Decimal (10,2))

Returns Decimal (10,2)

AS
	BEGIN 
	RETURN 
	CASE WHEN @valor >3000 then @valor * 0.95
	ELSE @valor
	END
END 

--=============================================================

CREATE FUNCTION dbo.fn_mensagem_desc (@valor Decimal (10,2))
Returns NVARCHAR (50)
	AS 
			BEGIN
			RETURN 
		CASE WHEN @valor >3000 then 'Conceder Desconto'
		ELSE 'Não Conceder Desconto'

		END 
END 

--=================================================================

	SELECT 
		Cliente,
		dbo.fn_conced_desc(Valor_Transacoes)	as ValorComDesconto,
		dbo.fn_mensagem_desc(Valor_Transacoes) as Mensagem 
FROM tb_transacoes_Func_Json;
			
