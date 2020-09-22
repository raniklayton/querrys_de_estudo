select
      p.codigo,
      p.descricao,
      p.preco_venda
from produto p

where p.preco_venda between 15.50 and 45.00

order by 3,2