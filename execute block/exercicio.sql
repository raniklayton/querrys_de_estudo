--1.	Construa um SQL que retorna o c�digo do produto, descri��o do produto [tabela Produto] c�digo da marca e descri��o da marca [tabela produto_marca], c�digo medida venda, descri��o medida venda e sigla [tabela medida];
--�	Trazer todos os produtos, mesmo que n�o tenha marca ou medida de venda informada;
--�	Utilizar apelido �alias� nas tabelas e nas colunas;
--�	Utilizar join na jun��o de tabelas;


execute block
returns(cod_produto int, desc_produto varchar(60), cod_marca int, des_marca varchar(50), cod_medida int, descricao_medida varchar(30), sigla char(5))
as
begin
    FOR
        SELECT
            p.codigo ,
            p.descricao,
            m.codigo,
            coalesce (m.descricao,'Marca N�o Informada'),
            mv.codigo,
            mv.descricao,
            mv.sigla
        FROM produto p
            LEFT JOIN produto_marca m on m.codigo = p.cod_marca
            LEFT JOIN medidas mv on mv.codigo = p.codigo_medida_venda
        INTO cod_produto, desc_produto , cod_marca , des_marca , cod_medida , descricao_medida , sigla
    DO
    suspend;
end