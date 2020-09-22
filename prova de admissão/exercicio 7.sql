select
    (( (extract (YEAR FROM CURRENT_DATE)))-(( extract(YEAR from F.data_admissao)))) AS TEMPO_DE_SERVICO,
    f.nome as NOME_FUNCIONARIO,    sum (v.venda_liquida) as VENDA_LIQUIDA,
    sum ((v.venda_liquida* v.percentual_avista)/100) as VENDA_AVISTA,
    SUM  ((v.venda_liquida* V.percentual_aprazo)/100) as VENDA_Aprazo
from  venda v

inner join funcionario f on f.codigo = v.codigo_funcionario

where v.data_venda>= '01.01.2019'
and   (( (extract (YEAR FROM CURRENT_DATE)))-(( extract(YEAR from F.data_admissao)))) >1

group by f.nome, 1

order by 1
