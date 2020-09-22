select case
   when (UF in ('RS', 'SC', 'PR')) then
        'Sul' 
   when (UF in ('SP','RJ', 'ES', 'MG')) then 
        'Sudeste'
   when (UF in ('MT','MS','GO','DF')) then 
        'Centro-Oeste' 
   when (UF in ('AC','RO','AM','RR','AP','PA')) then
        'Norte'
   when (UF in ('MA','PI','CE','RN','PB','PE','AL', 'SE','BA')) then
        'Nordeste'
        else
            'Sem Registro'
  end as REGIAO, count (*) as TOTAL_CLIENTES
  from cidade_vila

  group by REGIAO