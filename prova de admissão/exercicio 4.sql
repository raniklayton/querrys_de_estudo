select
    c.codigo,
    c.nome as NOME_CLIENTE,
    coalesce (C.ENDERECO,  'SEM INFORMA��O' ) as ENDERECO,
    C.numero,
    cv.nome as CIDADE_RESIDENCIA,
    sum (CR.valor_aberto) AS TOTAL_DEBITO

from cliente c

inner join cidade_vila cv on cv.codigo = c.cod_cidade
left join CONTAS_RECEBER CR ON C.codigo=CR.codigo_cliente
WHERE CR.status = 'A'
AND CV.UF = 'MS'
GROUP BY
    c.codigo,
    c.nome ,
    C.ENDERECO,
    C.numero,
    cv.nome