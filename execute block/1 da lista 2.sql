 --Relat�rio Vendas Geral por Vendedor. Construa um SQL que soma as vendas l�quidas dos vendedores realizadas no m�s de Dezembro de 2018.
--�    Colunas: Codigo funcion�rio, nome funcion�rio, valor da venda, tiket count (quantidade de vendas).
--�    Unificar �UNION ALL(pesquisar)� as vendas realizadas na tabela or�amento com a tabela venda.
--�    Fa�a primeiro o SQL buscando as vendas da tabela or�amento, depois monta outro SQL buscando as vendas da tabela venda e unifica com o union ;
--�    N�o fixar as datas. Utilizar par�metros no SQL para ser informada qualquer data.
execute block(datainicio date = :data1, datafinal date = :data2)
returns(COD_FUNCIONARIO INT, NOME_FUNCIONARIO VARCHAR (50),VENDA_LIQUIDA NUMERIC (15,2), QTD_VENDAS INTEGER, origem varchar(50)   )
as
begin
    FOR
SELECT
    O.codigo_funcionario,
    F.nome AS funcionario,
   SUM (O.orcamento_liquido) AS VENDA_LIQUIDA,
   count(o.codigo) as COUNT_VENDAS,
    'ORCAMENTO' ORIGEM

FROM ORCAMENTO O

INNER JOIN FUNCIONARIO F  ON F.CODIGO = O.codigo_funcionario

GROUP BY 1,2

   UNION all

select
    V.codigo_funcionario,
    F.nome AS funcionario,
    SUM (V.venda_liquida)  AS VENDA_LIQUIDA,
    count(V.codigo) as COUNT_VENDAS,
     'venda' ORIGEM
from VENDA  V

INNER join FUNCIONARIO F ON F.CODIGO = V.codigo_funcionario


GROUP BY 1,2
INTO COD_FUNCIONARIO , NOME_FUNCIONARIO ,VENDA_LIQUIDA , QTD_VENDAS, origem
    DO
    suspend;
end