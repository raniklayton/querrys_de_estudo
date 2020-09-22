 --Relat�rio Vendas Geral por Vendedor. Construa um SQL que soma as vendas l�quidas dos vendedores realizadas no m�s de Dezembro de 2018.
--�    Colunas: Codigo funcion�rio, nome funcion�rio, valor da venda, tiket count (quantidade de vendas).
--�    Unificar �UNION ALL(pesquisar)� as vendas realizadas na tabela or�amento com a tabela venda.
--�    Fa�a primeiro o SQL buscando as vendas da tabela or�amento, depois monta outro SQL buscando as vendas da tabela venda e unifica com o union ;
--�    N�o fixar as datas. Utilizar par�metros no SQL para ser informada qualquer data.

execute block(data_vendaini date = :data_Inicio, data_vendaFim date = :data_FIm)
returns(codigo_marca integer, descricao_marca varchar (50), valor_total numeric(15,2), origem varchar(50) )
as
begin
    FOR
        select
        pm.codigo,
        coalesce (pm.descricao, '<Marca N�o Informada>'),
        sum(oi.valor_total),
        'ORCAMENTO ITEM' ORIGEM
    
         from orcamento_item  OI

join orcamento o on o.codigo = oi.codigo_orcamento
inner join produto p on p.codigo = oi.codigo_produto
left join produto_marca pm on pm.codigo= p.cod_marca

where o.data_fechamento_dav BETWEEN :data_vendaini AND  :data_vendaFim



group by 1,2

 INTO  codigo_marca , descricao_marca , valor_total, origem
    DO
    suspend;


    FOR

select
      pm.codigo,
    coalesce (pm.descricao, '<Marca N�o Informada>'),
    sum(VI.valor_total),
     'VENDA ITEM' ORIGEM

from venda_item VI

JOIN VENDA V ON V.CODIGO = VI.codigo_venda
inner join produto p on p.codigo = VI.codigo_produto
left join produto_marca pm on pm.codigo= p.cod_marca

where V.data_venda BETWEEN :data_vendaini AND  :data_vendaFim

group by 1,2
order by 2

INTO  codigo_marca , descricao_marca , valor_total, origem
    DO
    suspend;
end
