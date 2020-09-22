--2.Listar e somar todos os pagamentos efetuados entre as datas 01/01/2019 at� 28/02/2019 e que o valor pago seja igual ou maior a 100,00
--.Colunas a serem exibidas: Data pagamento, codigo do cliente [tabela contas_receber_pagamento], nome do cliente [tabela cliente], valor_nominal, valor_juros,
--valor_desconto, valor_pago, valor_aberto[tabela contas_receber_pagamento], status [tabela contas_receber].
--�A coluna status possui um dos seguintes valores (A, P, N) A = Aberto, P = Pago e N = Negociado. Utilizar a estrutura CASE, no corpo do SQL,
--e fazer retornar a descri��o �Aberto ou Pago ou Negociado�.


execute block
returns(
            data_pagamento date,
            codigo_produto int,
            cliente varchar(50),
            VALOR_NOMINAL numeric (15,2),
            VALOR_JUROS numeric (15,2),
            VALOR_DESCONTO numeric (15,2),
            VALOR_PAGO numeric (15,2),
            VALOR_ABERTO numeric (15,2),
            STATUS varchar(50) )
as
begin
    FOR
select
crp.data_pagamento,
C.codigo,
C.nome,
sum (cr.valor_nominal) as VALOR_NOMINAL,
SUM (crp.valor_juros) AS VALOR_JUROS,
SUM (CRP.valor_desconto) AS VALOR_DESCONTO,
SUM (CRP.valor_pago) AS VALOR_PAGO,
SUM ( CRP.valor_aberto) AS  VALOR_ABERTO,
 CASE CR.status
 WHEN 'P' THEN 'PAGO'
 when 'N' THEN 'NEGOCIADO'
 WHEN 'A' THEN 'ABERTO'
 else
 'SEM INFORMA��O'
   END AS STATUS

from contas_receber_pagamento crp
INNER JOIN contas_receber CR ON CR.codigo = CRP.codigo_cr
INNER JOIN CLIENTE C ON C.codigo = CR.codigo_cliente
WHERE CRP.data_pagamento between '02.01.2019' AND '28.02.2019'
GROUP by CRP.data_pagamento,C.CODIGO, C.nome,  CR.status
INTO data_pagamento,codigo_produto,cliente ,
            VALOR_NOMINAL ,
            VALOR_JUROS ,
            VALOR_DESCONTO ,
            VALOR_PAGO ,
            VALOR_ABERTO ,
            STATUS
    DO
    suspend;
end