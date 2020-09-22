--Relatório Vendas Geral por Vendedor. Construa um SQL que soma as vendas líquidas dos vendedores realizadas no mês de Dezembro de 2018.
--•    Colunas: Codigo funcionário, nome funcionário, valor da venda, tiket count (quantidade de vendas).
--•    Unificar “UNION ALL(pesquisar)” as vendas realizadas na tabela orçamento com a tabela venda.
--•    Faça primeiro o SQL buscando as vendas da tabela orçamento, depois monta outro SQL buscando as vendas da tabela venda e unifica com o union ;
--•    Não fixar as datas. Utilizar parâmetros no SQL para ser informada qualquer data.
EXECUTE block(data_vendaini DATE = :data_Inicio, data_vendaFim DATE = :data_FIm)
RETURNS (
		codigo_marca INTEGER
		,descricao_marca VARCHAR(50)
		,valor_total NUMERIC(15, 2)
		,origem VARCHAR(50)
		) AS

BEGIN
	FOR

	SELECT pm.codigo
		,coalesce(pm.descricao, '<Marca Não Informada>')
		,sum(oi.valor_total)
		,'ORCAMENTO ITEM' ORIGEM
	FROM orcamento_item OI
	JOIN orcamento o ON o.codigo = oi.codigo_orcamento
	INNER JOIN produto p ON p.codigo = oi.codigo_produto
	LEFT JOIN produto_marca pm ON pm.codigo = p.cod_marca
	WHERE o.data_fechamento_dav BETWEEN :data_vendaini
			AND :data_vendaFim
	GROUP BY 1
		,2
	
	UNION ALL
	
	SELECT pm.codigo
		,coalesce(pm.descricao, '<Marca Não Informada>')
		,sum(VI.valor_total)
		,'VENDA ITEM' ORIGEM
	FROM venda_item VI
	JOIN VENDA V ON V.CODIGO = VI.codigo_venda
	INNER JOIN produto p ON p.codigo = VI.codigo_produto
	LEFT JOIN produto_marca pm ON pm.codigo = p.cod_marca
	WHERE V.data_venda BETWEEN :data_vendaini
			AND :data_vendaFim
	GROUP BY 1
		,2
	ORDER BY 2
	INTO codigo_marca
		,descricao_marca
		,valor_total
		,origem DO suspend;
END
