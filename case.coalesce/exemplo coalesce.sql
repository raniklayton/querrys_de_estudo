  select c.nome|| '  mora no endere�o  '||'rua '  ||c.endereco||
  coalesce( c.complemento, ' vazio') ||'   '|| c.bairro as dados
  from cliente c