--Relat�rio vendas geral por marca. Construa um relat�rio que soma o valor total das vendas por marca no m�s de janeiro/2019.
--�    Colunas: C�digo da marca, descri��o marca, valor total da marca;
--�    Inicia o SQL com o from na tabela or�amento_item (venda retaguarda);
--�    Unifica as vendas do retaguarda com as vendas do PDV;
--�    N�o fixar as datas. Utilizar par�metros no SQL para ser informada qualquer data.
--�    Utilizar o coalece  na descri��o da marca para retornar �<Marca N�o Informada>� quando n�o tiver marca informada no cadastro;

select
    pm.codigo,
    coalesce (pm.descricao, '<Marca N�o Informada>') as DESCRICAO_MARCA,
    sum(oi.valor_total) as valor_total,
     'ORCAMENTO ITEM' ORIGEM

from orcamento_item  OI

inner join produto p on p.codigo = oi.codigo_produto
left join produto_marca pm on pm.codigo= p.cod_marca
join orcamento o on o.codigo = oi.codigo_orcamento

where o.data_fechamento BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2


UNION ALL

select
    pm.codigo,
    coalesce (pm.descricao, '<Marca N�o Informada>') as DESCRICAO_MARCA,
    sum(VI.valor_total) as valor_total,
     'VENDA ITEM' ORIGEM

from venda_item VI

inner join produto p on p.codigo = VI.codigo_produto
left join produto_marca pm on pm.codigo= p.cod_marca
JOIN VENDA V ON V.CODIGO = VI.codigo_venda

where V.data_venda BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2
order by 2

