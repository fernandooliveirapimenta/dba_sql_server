--CRIAND DATABASE
--USE MASTER DROP DATABASE AULA_SHR
CREATE DATABASE AULA_SHR
GO
USE AULA_SHR
--CRIA TABELA
CREATE TABLE REGISTROS (
	ID_REGISTRO INT IDENTITY(1,1)PRIMARY KEY,
	TEXTO1 VARCHAR (50),	
	TEXTO2 VARCHAR (50),	
)
GO

--CRIANDO PROCEDURE PARA CARGA
CREATE PROCEDURE PROC_CARGA (@QTD_INSERT INT)
 AS
 --DECLARE VARIAVEIS
 DECLARE
  @HORA_INI AS DATETIME,
  @HORA_FIM AS DATETIME,
  @QTD_COMMIT AS INT,
  @CONTADOR AS INT,
  @DURACAO AS INT
   BEGIN 
   --ABRE TRANSA��O
   BEGIN TRANSACTION
   --INICIA VALORES  
	   SET @CONTADOR=0
	   SET @QTD_COMMIT=0;
	   SET @HORA_INI=GETDATE()
	   --IMPRIMI HORA INICIO
	   SELECT 'INICIO '+CAST(@HORA_INI AS VARCHAR(50))
    --INICIA WHILE
   WHILE @CONTADOR<@QTD_INSERT
    BEGIN 
	 INSERT INTO REGISTROS VALUES (REPLICATE('A',50),REPLICATE('B',50));
	 --CONTADORES
	 SET @CONTADOR=@CONTADOR+1;
	 SET @QTD_COMMIT=@QTD_COMMIT+1;
	 --SE QTD REGISTRO IGUAL 1000 REALIZAR COMITT E ABRE NOVA TRANSACAO
		  IF @QTD_COMMIT=1000 BEGIN
       		   SET @QTD_COMMIT=0
			   COMMIT;
			   BEGIN TRANSACTION; 
		  END
      --FIM IF
	END
	--FIM WHILE
	COMMIT
	SET @HORA_FIM=GETDATE()
		--IMPRIMI HORA FIM
		SELECT 'FIM '+CAST(@HORA_FIM AS VARCHAR(50))
		SET @DURACAO=DATEDIFF(SECOND,@HORA_INI,@HORA_FIM)
		--IMPRIMI DURACAO
		SELECT 'DURACAO '+CAST(@DURACAO AS VARCHAR(50))+' Segs'
	END
	--FIM PROCEDURE
--EXCUTANDO A PROCEDURE 1 MILHO DE REGISTROS
EXEC PROC_CARGA 1000000
--DADOS
SELECT COUNT(*) FROM REGISTROS

--EVIDENCIAR TAMANHO DOS ARQUIVOS
--DELETE 500 MIL REGISTRO
DELETE FROM REGISTROS WHERE ID_REGISTRO>500000

--Redu��o autom�tica do banco de dados

--Quando a op��o�AUTO_SHRINK�do banco de dados estiver definida como ON,�

ALTER DATABASE AULA_SHR SET AUTO_SHRINK OFF --(Desliga)
ALTER DATABASE AULA_SHR SET AUTO_SHRINK ON  --(Liga)


--Reduzindo um banco de dados e especificando uma porcentagem de espa�o livre
--O exemplo a seguir diminui o tamanho dos arquivos de dados e de log no banco 
--de dados de usu�rio UserDB para permitir 10 por cento de espa�o livre no banco de dados.

DBCC SHRINKDATABASE (AULA_SHR, 10);

--Truncando um banco de dados
--O exemplo a seguir reduz os arquivos de dados no banco 
--de dados de exemplo AULA_SHR at� a �ltima extens�o alocada.

DBCC SHRINKDATABASE (AULA_SHR, TRUNCATEONLY);

--Reduzindo arquivo de dados
use AULA_SHR

DBCC SHRINKFILE (AULA_SHR, 10);
DBCC SHRINKFILE (AULA_SHR_log, 5);
