select
        c.codigo,
        c.nome as NOME_CLIENTE,
        c.endereco,
        c.numero,
        cv.nome as CIDADE_RESIDENCIA
from cliente c

inner join cidade_vila cv on cv.codigo = c.cod_cidade

where  CV.uf= 'MS'
AND C.NOME LIKE '%SILVA%'

order by 5,2