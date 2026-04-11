
-- DECLARE declaramos uma variável/ estrutura
DECLARE @NomeCliente NVARCHAR(100);

--Agora atribuimos um valor a variável/ setamos a estrutura para receber  o nome de 'Alice'
SET @NomeCliente = 'Alice';

--Exibição da mensagem / para printar e mostrar o valor 
PRINT 'Seja bvem ' + @NomeCliente 

-- E executamos TUDO junto 
