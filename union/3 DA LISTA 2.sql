--Relat�rio vendas geral por SE��O. Construa um relat�rio que soma o valor total das vendas por SE��O no m�s de janeiro/2019.
--�    Colunas: C�digo da SE��O, descri��o se��o, valor total da SE��O;
--�    Inicia o SQL com o from na tabela or�amento_item (venda retaguarda);
--�    Unifica as vendas do retaguarda com as vendas do PDV;
--�    N�o fixar as datas. Utilizar par�metros no SQL para ser informada qualquer data.
--�    Utilizar o coalece  na descri��o da SE��O para retornar �<Se��o N�o Informada>� quando n�o tiver SE��O informada no cadastro;

select
   PS.codigo,
   COALESCE(PS.descricao,'<Se��o N�o Informada>')  AS PRODUTO_SECAO,
   sum(oi.valor_total) as VALOR_TOTAL,
   'ORCAMENTO ITEM' ORIGEM
from orcamento_item oi

JOIN PRODUTO P ON P.CODIGO = OI.codigo_produto
LEFT JOIN produto_secao PS ON PS.codigo = P.cod_secao
join orcamento o on o.codigo = oi.codigo_orcamento

where o.data_fechamento BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2
UNION ALL

select
   PS.codigo,
   COALESCE(PS.descricao,'<Se��o N�o Informada>')  AS PRODUTO_SECAO,
   sum(VI.valor_total) as VALOR_TOTAL,
   'VENDA ITEM' ORIGEM
from VENDA_ITEM VI

JOIN PRODUTO P ON P.CODIGO = VI.codigo_produto
LEFT JOIN produto_secao PS ON PS.codigo = P.cod_secao
join VENDA V on V.codigo = VI.codigo_venda

where V.data_venda BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2