-- visualizar os 5 colaboradores com maior salário
SELECT id_colaborador, salario FROM HistoricoEmprego ORDER BY salario DESC
LIMIT 5;

-- visualizar os 5 colaboradores com maior salário que estão com contrato ativo
SELECT * FROM HistoricoEmprego WHERE datatermino IS NULL
ORDER BY salario DESC
LIMIT 5;

-- selecionar curso que começa com "O poder"
SELECT * FROM Treinamento WHERE curso LIKE 'O poder%';

-- selecionar curso que possui a palavra "realizar"
SELECT * FROM Treinamento WHERE curso LIKE '%realizar%';

-- selecionar curso que começa com "O poder" e possui a palavra "realizar"
SELECT * FROM Treinamento WHERE curso LIKE '%realizar%' AND curso LIKE 'O poder%';

-- selecionar colaboradoras cujo primeiro nome é "Ana"
SELECT * FROM Colaboradores WHERE nome LIKE 'Ana%';

-- selecionar professores que não estão trabalhando no momento
SELECT * from HistoricoEmprego WHERE datatermino IS NOT NULL AND cargo = 'Professor';

-- selecionar profissionais que sejam ou dermatologista ou oftalmologista
SELECT * FROM HistoricoEmprego WHERE cargo = 'Oftalmologista' OR cargo = 'Dermatologista';

-- selecionar profissionais que sejam ou dermatologista ou oftalmologista ou professor
SELECT * FROM HistoricoEmprego WHERE cargo IN ('Oftalmologista','Dermatologista','Professor');

-- selecionar profissionais que não sejam dermatologista ou oftalmologista ou professor
SELECT * FROM HistoricoEmprego WHERE cargo NOT IN ('Oftalmologista','Dermatologista','Professor');

-- Selecionar funcionários cujo cargo não seja radialista;
SELECT * FROM HistoricoEmprego WHERE NOT cargo = 'Radialista';

SELECT * FROM HistoricoEmprego WHERE cargo <> 'Radialista';

-- selecionar mês com maior faturamento
SELECT mes, MAX(faturamento_bruto) FROM faturamento;

-- selecionar mês com menor número de novos clientes
SELECT mes, MIN(numero_novos_clientes) FROM faturamento;

-- somar a quantidade de novos clientes do ano de 2023
SELECT SUM(numero_novos_clientes) AS 'novos_clientes_2023' FROM faturamento WHERE mes LIKE '%2023';

-- selecione o lucro líquido máximo, o lucro líquido mínimo e a soma de lucro líquido do ano de 2023. Renomeie as colunas para facilitar a leitura
SELECT MAX(lucro_liquido) AS 'lucro_liq_max_23', MIN(lucro_liquido) AS 'lucro_liq_min_23', SUM(lucro_liquido) AS 'soma_lucro_liq_23' FROM faturamento WHERE mes LIKE '%2023';

-- selecionar o id de colaboradores que não trabalham mais na empresa, cujo cargo seja "Coach" e recebam menos de 10000 ou colaboradores cujo cargo seja "Intérprete" e recebam mais de 4000

SELECT id_colaborador,cargo,datatermino,salario FROM HistoricoEmprego WHERE (cargo = 'Coach' AND salario < 10000 AND datatermino IS NOT NULL) OR (cargo = 'Intérprete' AND salario > 4000 AND datatermino IS NOT NULL);

SELECT id_colaborador,cargo,datatermino,salario FROM HistoricoEmprego WHERE datatermino IS NOT NULL AND ((cargo = 'Coach' AND salario < 10000) OR (cargo = 'Intérprete' AND salario > 4000));

-- calcular a média de despesas da empresa
SELECT AVG(despesas) FROM faturamento;

SELECT ROUND(AVG(despesas),2) AS 'media_despesas' FROM faturamento;

-- calcular a média de despesas e de lucro líquido da empresa
SELECT ROUND(AVG(despesas),2) AS 'media_despesas', ROUND(AVG(lucro_liquido),2) AS 'media_lucro_liq' FROM faturamento;

-- contar quantos colaboradores estão ativos na empresa
SELECT COUNT(*) FROM HistoricoEmprego WHERE datatermino IS NULL;

-- contar quantos colaboradores distintos tiraram licença médica em 2023
SELECT COUNT(DISTINCT id_colaborador) FROM Licencas WHERE tipolicenca = 'licença médica' AND datainicio LIKE '2023%';

-- avaliar a média de saldo e o número de contas ativas
SELECT AVG(saldo) AS 'media_saldos' AND COUNT(id_cliente) AS 'clientes_ativos' FROM contas WHERE status_conta = 'ativa';

-- avaliar a quantidade de cada parentesco 
SELECT parentesco, COUNT(*) AS 'Quantidade' FROM dependentes GROUP BY parentesco;

-- contar quantos cursos por instituição existem na tabela
SELECT instituicao, COUNT(curso) AS 'quantidade' FROM Treinamento GROUP BY instituicao ORDER BY quantidade DESC;

-- contar quantos cursos por instituição com quantidade maior que dois
SELECT instituicao, COUNT(curso) AS 'quantidade' 
FROM Treinamento 
GROUP BY instituicao 
HAVING quantidade > 2
ORDER BY quantidade DESC;

-- Seleciona cargos com pelo menos dois colaboradores que já deixaram a empresa
SELECT cargo, datatermino, COUNT(cargo) AS 'Qtd_cargos'
FROM HistoricoEmprego
WHERE datatermino IS NOT NULL
GROUP BY cargo
HAVING Qtd_cargos >= 2
ORDER BY Qtd_cargos DESC;

-- verificar os colaboradores cujos campos de CPF estão preenchidos com 11 dígitos
SELECT nome, LENGTH(cpf) AS 'quantidade'
FROM Colaboradores
WHERE quantidade = 11;

-- verificar os colaboradores cujos campos de CPF não estão preenchidos com 11 dígitos
SELECT nome, LENGTH(cpf) AS 'quantidade'
FROM Colaboradores
WHERE quantidade <> 11;

-- verificar quantos colaboradores não estão com o campo CPF preenchidos com 11 dígitos
SELECT LENGTH(cpf) AS 'quantidade_digitos', COUNT(*) AS total
FROM Colaboradores
WHERE quantidade_digitos <> 11
GROUP BY quantidade_digitos;

-- apresentar as informações das pessoas colaboradoras em forma de texto
SELECT ('O email "'||email||'" pertence à pessoa colaboradora '||nome) AS 'email_colab'
FROM Colaboradores;

-- apresentar as informações das pessoas colaboradoras em forma de texto maiúsculo
SELECT UPPER ('O email "'||email||'" pertence à pessoa colaboradora '||nome) AS 'email_colab'
FROM Colaboradores;

-- apresentar as informações das pessoas colaboradoras em forma de texto minúsculo
SELECT LOWER ('O email "'||email||'" pertence à pessoa colaboradora '||nome) AS 'email_colab'
FROM Colaboradores;

-- selecionar somente ano e mês da data de início da licença
SELECT id_colaborador, STRFTIME('%Y/%m', datainicio) FROM Licencas;

-- verificar quais colaboradores ficaram menos de 100 dias na empresa
SELECT id_colaborador, (JULIANDAY(datatermino) - JULIANDAY(datacontratacao)) AS 'dias_trabalhados'
FROM HistoricoEmprego
WHERE (datatermino IS NOT NULL) AND (dias_trabalhados < 100)
ORDER BY dias_trabalhados;

-- arredondar os números de faturamento para duas casas decimais, para o inteiro acima e para o inteiro abaixo
SELECT ROUND(AVG(faturamento_bruto),2) AS 'duas_decimais', CEIL(AVG(faturamento_bruto)) AS 'int_acima', FLOOR(AVG(faturamento_bruto)) AS 'int_abaixo' FROM faturamento;

-- converter o valor do faturamento médio bruto em string para apresentar o dado como texto
SELECT ('O faturamento bruto médio foi: ' || CAST(ROUND(AVG(faturamento_bruto),2) AS TEXT)) AS 'faturamento_bruto'
FROM faturamento;

-- classificar os salários entre alto, médio e baixo
SELECT id_colaborador, cargo, salario,
CASE
WHEN salario < 3000 THEN 'Baixo'
WHEN salario BETWEEN 3000 AND 6000 THEN 'Médio'
ELSE 'Alto'
END AS 'classificacao_salarios'
FROM HistoricoEmprego;

-- proporcionar aumento de 3% para quem recebe até 10K e de 1,5% para quem recebe acima de 10K 
SELECT id_colaborador, cargo, salario,
CASE
WHEN salario <= 10000 THEN ROUND(salario * 1.03, 2)
when salario > 10000 then ROUND(salario * 1.015, 2)
ELSE salario
end AS 'novo_salario'
FROM HistoricoEmprego;

-- alterar nome da tabela HistoricoEmprego para tabela_cargos_colaboradores
ALTER TABLE HistoricoEmprego RENAME TO tabela_cargos_colaboradores;