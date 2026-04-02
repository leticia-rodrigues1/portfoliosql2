
-- SUM
SELECT
	SUM(total_usuarios)
FROM tb_netflix

/*
GROUP BY instrucao agrupa linhas que tem os mesmos valores em linhas de resumo, como "encontre o numero de clientes em cada pais".
GROUP BY geralmente é usada com funções de agregação 
( COUNT () , MAX () , MIN (), SUM (), AVG () ) para agrupar o conjunto de resultados em uma ou mais colunas. 


*/

--GROUP BY
SELECT
			COUNT(tipo_de_conta) AS CONTA,
			estados,
			tipo_de_conta
FROM tb_netflix
GROUP BY	estados, tipo_de_conta