select
    c.codigo, 
    c.nome,
    c.endereco,
    c.telefone
from cliente c

where c.situacao= 'A'

order by 2