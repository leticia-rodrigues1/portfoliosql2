

--- EXERCÍCIO ---

SELECT *
FROM tb_netflix

SELECT 
		DATA AS [DATAS DO CONSUMO],
		REPLACE(periodo_de_acess, 'MANHA', 'PERIODO INICIAL') AS HORARIOS,
		REPLACE (tipo_de_conta, 'PLANO BASICO', 'BSC') AS SERVIÇOS,
		estados,
		total_usuarios,
		segmentos,
		CONCAT (tipo_de_conta, '-', valor, '-', periodo_de_acess) AS RESUMO
FROM tb_netflix
WHERE segmentos = 'documentarios'
