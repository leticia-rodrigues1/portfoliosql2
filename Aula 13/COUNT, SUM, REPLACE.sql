
---------------- FUNÇÕES SQLSERVE ----------------------
-- COUNT 
-- SUM
-- REPLACE

--Selecionando a tabela 
SELECT *
FROM tb_netflix

-- FUNÇÕES SÃO UTILIZADAS DENTRO DO SELECT LIST
SELECT
	estados,
	total_usuarios,
	tipo_de_conta
FROM tb_netflix

--COUNT (CONTA VALORES)
SELECT 
	COUNT(UF)
FROM tb_netflix

SELECT 
	COUNT(TIPO_DE_CONTA)
FROM tb_netflix

-- SUM ( SOMA OS VALORES DE UMA COLUNA )
SELECT
	SUM(total_usuarios) AS Total
FROM tb_netflix

-- REPLACE (FUNÇÕES PARA SUBSTITUIR VALORES DE UMA COLUNA)
SELECT 
	estados,
	total_usuarios,
	REPLACE(periodo_de_acess,'MANHA','PRIMEIROS ACESSOS') AS PERIODO_DE_ACESSO,
	tipo_de_conta,
	valor
FROM tb_netflix

