--Relatório vendas geral por SEÇÃO. Construa um relatório que soma o valor total das vendas por SEÇÃO no mês de janeiro/2019.
--•    Colunas: Código da SEÇÃO, descrição seção, valor total da SEÇÃO;
--•    Inicia o SQL com o from na tabela orçamento_item (venda retaguarda);
--•    Unifica as vendas do retaguarda com as vendas do PDV;
--•    Não fixar as datas. Utilizar parâmetros no SQL para ser informada qualquer data.
--•    Utilizar o coalece  na descrição da SEÇÃO para retornar ‘<Seção Não Informada>’ quando não tiver SEÇÃO informada no cadastro;
EXECUTE block(data_vendaini DATE = :data_Inicio, data_vendaFim DATE = :data_FIm)
RETURNS (
        codigo_secao INTEGER
        ,descricao_secao VARCHAR(50)
        ,valor_total NUMERIC(15, 2)
        ,origem VARCHAR(50)
        ) 
        AS

BEGIN
    FOR
        select
        PS.codigo,
        COALESCE(PS.descricao,'<Seção Não Informada>')  AS PRODUTO_SECAO,
        sum(oi.valor_total) as VALOR_TOTAL,
        'ORCAMENTO ITEM' ORIGEM
        from orcamento_item oi

join orcamento o on o.codigo = oi.codigo_orcamento
JOIN PRODUTO P ON P.CODIGO = OI.codigo_produto
LEFT JOIN produto_secao PS ON PS.codigo = P.cod_secao


where o.data_fechamento_dav BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2
INTO codigo_secao
        ,descricao_secao
        ,valor_total
        ,origem 
        DO suspend;

    for
        select
        PS.codigo,
       COALESCE(PS.descricao,'<Seção Não Informada>')  AS PRODUTO_SECAO,
       sum(VI.valor_total) as VALOR_TOTAL,
       'VENDA ITEM' ORIGEM
       from VENDA_ITEM VI

JOIN PRODUTO P ON P.CODIGO = VI.codigo_produto
LEFT JOIN produto_secao PS ON PS.codigo = P.cod_secao
join VENDA V on V.codigo = VI.codigo_venda

where V.data_venda BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2

INTO codigo_secao
        ,descricao_secao
        ,valor_total
        ,origem 
        DO suspend;

end