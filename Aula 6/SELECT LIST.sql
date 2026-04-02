
--- SELECT CONDIÇÕES DE TABELAS ---

-- ALIAS DE AULAS 
-- SELECT LIST
-- FROM = DE
-- WHERE = ONDE 
-- AND = E
-- BETWEN = ENTRE
-- IN = E, E 

-- Selecionando os registros de toda a tabela
SELECT *
FROM tb_netflix

-- Utilizando o SELECT LIST, trazendo apenas algumas colunas 
-- Nesse caso selecionamos as colunas de data, estados e uf da tabela  tb_netflix
SELECT DATA
	ESTADOS,
	UF
FROM tb_netflix

--- Trazendo colunas na frente 
SELECT 
	TIPO_DE_CONTA,
		VALOR
FROM tb_netflix






