--https://docs.microsoft.com/pt-br/sql/tools/sqlcmd-utility?view=sql-server-2017#command-line-options
--CONECTANDO DATABASE COM USUARIO/CONEXAO CONFIAVEL
SQLCMD -S SRV-DB-01\MSSQLSERVER001


--CONECTANDO DATABASE COM USUARIO E SENHA SQL

SQLCMD -S SRV-DB-01\MSSQLSERVER001 -U DBA_CURSO -P Sql2017@!


--CONECTANDO DATABASE COM USUARIO E SENHA SQL E RODANDO QUERY

SQLCMD -S SRV-DB-01\MSSQLSERVER001 -U DBA_CURSO -P Sql2017@! -d MINICRM -q "SELECT ID_AGENDA, ID_CLIENTE, DATA_VISITA FROM AGENDA;"


--EXECUTAR ARQUIVO NO SQLCMD USANDO ARQUIVO EXTERNO .SQL

--PARTE 1 CONTEUDO DO ARQUIVO .BAT

SQLCMD -S SRV-DB-01\MSSQLSERVER001  -i "M:\SQL001\SCRIPTS\BK_AUTO.SQL" -o "M:\SQL001\SCRIPTS\LOG_BAK.txt"
PAUSE

--PARTE 2 CONTEUDO DO ARQUIVO .SQL

DECLARE @data as varchar(10)
DECLARE @caminho as varchar(255)
DECLARE @nome_bk as varchar(255)
DECLARE @extensao as varchar(5)
DECLARE @bd as varchar(50)
DECLARE @comando as varchar(255)
DECLARE @destino as varchar(30)
DECLARE @SQL VARCHAR(MAX)
SET @data=replace(convert(varchar(20),getdate() ,103),'/','')
SET @caminho='M:\SQL001\'
SET @nome_bk='CURSO_BK-FULL-'
SET @extensao='.BAK'''
SET @bd='CURSO'
SET @comando='BACKUP DATABASE ' 
SET @destino=' TO DISK =N'''
SET @SQL=@comando+@bd+@destino+@caminho+@nome_bk+@data+@extensao
EXEC(@SQL)

