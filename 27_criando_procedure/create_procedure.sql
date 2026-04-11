

/* CRIANDO UMA PROCEDURE DE UM 
PROJETO MONITORAMENTO DE TRANSAÇÃO 
*/

--Criando a PROCEDURE 
CREATE PROCEDURE VerificarTransacaoClienteAprovado

-- CRIANDO O PADRÃO
@Cliente NVARCHAR(100) -- Parâmetro de Entrada com o Cliente 

AS 
BEGIN
		--Verifica se o cliente possui pelo menos uma transação APROVADA
		IF EXISTS(
		SELECT 1
		FROM BaseFraude
		WHERE Cliente = @Cliente
		AND Aprovado = 'Sim'
)

BEGIN -- Novamente porque vamos chamar uma nova transação 
		-- Verifica se o cliente possui alguma transação suspeita (Aprovadas, Valor alto a noite)
		IF EXISTS(
		SELECT 1
		FROM BaseFraude
		WHERE Cliente = @Cliente
		AND Aprovado = 'Sim'
		AND Valor_Transacao >=4000
		AND DATEPART(HOUR, DataTransacao) >=21
)

BEGIN 
		-- Retorna as transações SUSPEITAS
		SELECT 
		DataTransacao, 
		TipoTransacao,
		Valor_Transacao,
		Bandeira, 
		Aprovado,
		'Transação Suspeita' as verificar
		FROM BaseFraude
		WHERE Cliente = @Cliente 
		AND Aprovado = 'Sim'
		AND Valor_Transacao >= 4000
		AND DATEPART(HOUR, DataTransacao) >=21
		END 

		ELSE 
		BEGIN 
		-- Caso tenha aprovações, mas nenhuma suspeita (valor alto + horário) retornar essa mensagem 
		SELECT 
		'Cliente não possui Transações Suspeitas' as Mensagem 
		END
		END 

		ELSE
		BEGIN 
		--Caso não tenha nenhuma transação, traz essa mensagem Não Aprovado 
		SELECT
		DataTransacao
		TipoTransacao,
		Valor_Transacao,
		Bandeira,
		Aprovado,
		'Sem Aprovação' as Verificar 
		FROM BaseFraude
		WHERE Cliente = @Cliente
		AND Aprovado = 'Não'
END
END 


-- EXECUTANDO A PROCEDURE  CRIADA A CIMA 
Exec VerificarTransacaoClienteAprovado @Cliente = 'Cliente 7'













