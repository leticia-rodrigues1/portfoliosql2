
/* O QUE É JSON? (JavaScript Object Notation)
É um formato leve de troca de dados.
Ele é baseado em texto e usa uma sintaxe simples de chave - valor

É muito usado em APIS e integrações, justamente	porque é fácil de transportar e processar.

Diferente de um banco relacional (SQL),
o JSON é semiestruturado, ou seja,
os dados não precisam estar em uma tabela fixa - cada objeto pode ter campos diferentes.

É muito usado em APIs e integrações, justamente porque é fácil de transportar e processar.

*/	

CREATE PROCEDURE importa_json_transacoes 

AS
BEGIN
	SET NOCOUNT ON -- Quando você quer ver quantas linhas cada comando afetou

	DECLARE @json NVARCHAR(MAX) -- Sem limites de caracteres vai até ao máximo que pode chegar 

	-- Ler o arquivo onde está o JASON

	SELECT @json = Bulkcolumn -- Abre o arquivo como se fosse uma tabela temporária 
	FROM OPENROWSET(
	BULK 'C:\JSON\transacoes.json',		
	SINGLE_CLOB
	)AS Jsondata


	-- Crie a tabela com condição se existir deleta e cria novamente 

	if OBJECT_ID ('dbo.tb_transacoes') is null
	BEGIN
	CREATE TABLE dbo.tb_transacoes 
	(

	DataTransacao		NVARCHAR(30),
	Cliente				NVARCHAR(100),
	TipoTransacao		NVARCHAR (50),
	Valor_Transacoes	DECIMAL (10,2),	
	Bandeira			NVARCHAR(50),
	Aprovado			NVARCHAR (10)
)
    END 

	-- Inserir os dados do Json na tabela
	INSERT INTO tb_transacoes
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
FROM OPENJSON (@json)
	WITH 
	(
		DataTransacao		NVARCHAR(30),
		Cliente				NVARCHAR(100),
		TipoTransacao		NVARCHAR (50),
		Valor_Transacoes	DECIMAL (10,2),	
		Bandeira			NVARCHAR(50),
		Aprovado			NVARCHAR (10)
	);
	END 

EXEC importa_json_transacoes

SELECT *
FROM tb_transacoes

