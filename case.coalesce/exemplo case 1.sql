select case v.tipo_venda
when 'C' then 'cr�dito'
when 'D' then 'debito'
    else
    'campo em branco ou valor incorreto'
    end as TIPO_de_LANCAMENTO , v.codigo, f.nome
     from venda v
     inner join  funcionario f on f.codigo= v.codigo_funcionario