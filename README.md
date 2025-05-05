# 📊 Consultas SQL para a Fokus

Este projeto contém uma coleção de comandos SQL desenvolvidos como parte de uma análise de dados para a empresa **Fokus**. O objetivo principal foi explorar, transformar e extrair insights de dados relacionados a colaboradores, treinamentos, faturamento e outras áreas relevantes.

As consultas foram realizadas no SQLite Online.

## 🧩 Estrutura Geral do Projeto

O código SQL foi cuidadosamente estruturado para abranger diferentes tipos de operações e funcionalidades úteis no contexto de análise e manutenção de banco de dados. A seguir estão os principais destaques do que foi implementado:

---

### 🔍 Filtros e Ordenações

Consultas com cláusulas `WHERE`, `LIKE`, `ORDER BY`, `IN`, `NOT IN`, e operadores lógicos como `AND` / `OR` foram utilizadas para:

- Buscar colaboradores com critérios específicos (por exemplo, com contrato ativo, que ganham acima de certo valor ou possuem um cargo específico);
- Selecionar cursos com base em palavras-chave;
- Classificar e limitar os resultados (como mostrar os 5 maiores salários).

---

### 📊 Funções de Agregação

Funções como `MAX()`, `MIN()`, `AVG()`, `SUM()`, `COUNT()` foram utilizadas para:

- Calcular métricas financeiras (lucro líquido, despesas, faturamento bruto);
- Contar registros distintos (como número de colaboradores em licença);
- Agrupar e quantificar dados (como quantidade de cursos por instituição).

---

### 🏗️ Modificação da Estrutura da Tabela

O projeto também incluiu comandos de **Data Definition Language (DDL)**, como:

- `ALTER TABLE` para renomear a tabela `HistoricoEmprego` para `tabela_cargos_colaboradores`.

---

### 🛠️ Outros Comandos Úteis

Foram utilizados diversos comandos e funções adicionais para enriquecer a análise, incluindo:

- `CASE` para classificação de salários e simulação de aumento salarial;
- `STRFTIME()` e `JULIANDAY()` para manipulação e cálculo com datas;
- `LENGTH()`, `UPPER()`, `LOWER()`, `CAST()` para tratamento de strings e verificação de dados;
- `CEIL()` e `FLOOR()` para arredondamentos específicos;
- Construção de strings concatenadas para apresentação textual de dados (por exemplo, emails de colaboradores).

---

## 📁 Exemplo de Consultas

```sql
-- Top 5 maiores salários com contrato ativo
SELECT * FROM HistoricoEmprego
WHERE datatermino IS NULL
ORDER BY salario DESC
LIMIT 5;

-- Cursos que possuem a palavra "realizar"
SELECT * FROM Treinamento
WHERE curso LIKE '%realizar%';

-- Classificação dos salários
SELECT id_colaborador, salario,
CASE
  WHEN salario < 3000 THEN 'Baixo'
  WHEN salario BETWEEN 3000 AND 6000 THEN 'Médio'
  ELSE 'Alto'
END AS classificacao_salarios
FROM HistoricoEmprego;
