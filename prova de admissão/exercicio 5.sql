SELECT
   P.codigo,
   P.descricao,
   OI.valor_total AS VALOR_VENDIDO,
   SUM (OI.quantidade) AS QTDE_VENDIDA,
   SUM( EP.estoque) as ESTOQUE_ATUAL_GERAL

FROM PRODUTO P

inner  orcamento_item OI ON OI.codigo_produto = P.CODIGO
INNER JOIN estoque_produto EP ON EP.codigo_produto = P.CODIGO
INNER JOIN ORCAMENTO O ON O.codigo = OI.codigo_orcamento

where O.status = 'F'
AND O.data_fechamento between '01.01.2014' AND '31.12.2014'

group BY 1,2,3

