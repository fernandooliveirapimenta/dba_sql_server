--SESS�O 4
USE CURSO
SELECT @@SPID
BEGIN TRAN
UPDATE SALDO_CORRENTE SET SALDO=200 WHERE ID_AGENCIA='9001' AND ID_CONTA='100002'
--REALIZAR COMMIT OU ROLLBACK
COMMIT
ROLLBACK