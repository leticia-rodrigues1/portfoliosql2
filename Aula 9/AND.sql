
--- Usando o AND = E
SELECT *
FROM	tb_netflix
WHERE	UF = 'CE'
AND		periodo_de_acess = 'TARDE'

--- Usando o AND = E
SELECT*
FROM	tb_netflix
WHERE	periodo_de_acess = 'MANHA'
AND		tipo_de_conta = 'PLANO PREMIUM'
AND		segmentos = 'ESPORTES'

SELECT *
FROM tb_netflix
WHERE 