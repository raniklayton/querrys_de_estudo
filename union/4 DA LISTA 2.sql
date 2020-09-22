--Relat�rio vendas geral por GRUPO. Construa um relat�rio que soma o valor total das vendas porGRUPO no m�s de janeiro/2019.
--�    Colunas: C�digo do GRUPO, descri��o GRUPO, valor total da GRUPO;
--�    Inicia o SQL com o from na tabela or�amento_item (venda retaguarda);
--�    Unifica as vendas do retaguarda com as vendas do PDV;
--�    N�o fixar as datas. Utilizar par�metros no SQL para ser informada qualquer data.
--�    Utilizar o coalece  na descri��o do GRUPO para retornar �<Grupo N�o Informado>� quando n�o tiver GRUPO informado no cadastro;


select
   PG.codigo,
   COALESCE(PG.descricao,'<grupo N�o Informada>')  AS PRODUTO_GRUPO,
   sum(oi.valor_total) as VALOR_TOTAL,
   'ORCAMENTO ITEM' ORIGEM
from orcamento_item oi

JOIN PRODUTO P ON P.CODIGO = OI.codigo_produto
LEFT JOIN produto_GRUPO PG ON PG.codigo = P.cod_secao
join orcamento o on o.codigo = oi.codigo_orcamento

where o.data_fechamento BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2
UNION ALL

select
   PG.codigo,
   COALESCE(PG.descricao,'<Grupo N�o Informada>')  AS PRODUTO_GRUPO,
   sum(VI.valor_total) as VALOR_TOTAL,
   'VENDA ITEM' ORIGEM
from VENDA_ITEM VI

JOIN PRODUTO P ON P.CODIGO = VI.codigo_produto
LEFT JOIN produto_GRUPO PG ON PG.codigo = P.cod_secao
join VENDA V on V.codigo = VI.codigo_venda

where V.data_venda BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2



