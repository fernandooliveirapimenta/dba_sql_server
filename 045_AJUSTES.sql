USE DB_OTIMIZA
--AJUSTES
--CRIANDO INDICES CLUSTERIZADOS ATRAVES DAS PRIMARY KEYS
--TABELA PESSOAS

ALTER TABLE PESSOAS ADD CONSTRAINT PK_PESSOA PRIMARY KEY (BusinessEntityID)

--TABELA PRODUTO
ALTER TABLE PRODUTOS ADD CONSTRAINT PK_PRODUTO PRIMARY KEY (ProductID)
--TABELA PEDIDO_MESTRE

ALTER TABLE PEDIDO_MESTRE ADD CONSTRAINT PK_PED_MESTRE PRIMARY KEY (SalesOrderID)

--TABELA PEDIDO_DETALHE
ALTER TABLE PEDIDO_DETALHE ADD CONSTRAINT PK_PED_DET PRIMARY KEY (SalesOrderDetailID)
--TABELA PEDIDO_DETALHE


--CRIAR INDICES N�O CLUSTERIZADOS
--INDICE DE DATA NA PEDIDO MESTRE

CREATE NONCLUSTERED INDEX IX_PESSOAS_001 ON PESSOAS (CustomerID)

--INDICE DE DATA NA PEDIDO MESTRE
CREATE NONCLUSTERED INDEX IX_PEDM_001 ON PEDIDO_MESTRE (DueDate)

--INDICE DE ProductID  NA PEDIDO_DETALHE
CREATE NONCLUSTERED INDEX IX_PEDD_001 ON PEDIDO_DETALHE (ProductID)

--CRIAR ESTATICAS PARA TABELA
CREATE STATISTICS ST_CUSTOMER_ID   ON PEDIDO_MESTRE (CustomerID);  

--CRIAR ESTATICAS PARA TABELA
CREATE STATISTICS ST_PESSOA_LN   ON PESSOAS (LastName);

--CRIAR AS FOREIGN KEYS
--ADICIONAR AS FOREIGN KEYS 

--ADICIONAR AS FOREIGN KEYS PEDIDO_DETALHE
ALTER TABLE PEDIDO_DETALHE ADD CONSTRAINT FK_PEDD_001 FOREIGN KEY
   (SalesOrderID) REFERENCES PEDIDO_MESTRE(SalesOrderID)

--ADICIONAR AS FOREIGN KEYS PEDIDO_DETALHE
ALTER TABLE PEDIDO_DETALHE ADD CONSTRAINT FK_PEDD_002 FOREIGN KEY
   (ProductID) REFERENCES PRODUTOS(ProductID)


--CRIAR ESTATISTICAS AUTOMATICAS

ALTER DATABASE DB_OTIMIZA SET AUTO_CREATE_STATISTICS ON


--ATULIZANDO AS STATISTICS
UPDATE STATISTICS PESSOAS
UPDATE STATISTICS PEDIDO_MESTRE
UPDATE STATISTICS PEDIDO_DETALHE
UPDATE STATISTICS PRODUTOS

--OU 

EXEC sp_updatestats;  