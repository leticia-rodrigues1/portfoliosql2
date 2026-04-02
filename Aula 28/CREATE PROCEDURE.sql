

--PROCEDURE

CREATE PROCEDURE ListarTransacoesClassificadas

AS 
BEGIN	

	SELECT
	Cliente, --Nome do Cliente
	Valor_Transacao, -- Valor da Transação
	
	CASE
	WHEN Valor_Transacao < 100 then 'Baixo'
	WHEN Valor_Transacao between 100 and 1000 then 'Médio'
	ELSE 'ALTO'
	END AS Classificacao 
FROM BaseFraude
	
END 
GO

Exec ListarTransacoesClassificadas; 