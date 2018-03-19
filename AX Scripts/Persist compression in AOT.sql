-- =============================================
-- Author:		Tom Vergote
-- Create date: 2018-03-19
-- Persists compression information in the SQLSTORAGE so it doesn't get lost during synchronization
-- Loosely based on https://blogs.msdn.microsoft.com/axinthefield/sql-server-data-compression-for-dynamics-ax-4-actions-post-compression/
-- only cleaner and removed the dependency for the AOT objects from dynamicsperf tool (so no need to run an export class that takes 4 hours
-- =============================================

PRINT
'
Updating Dynamics AX SQLStorage Table with Compression Information
'

Create Table #SQLStorage
(
ID INT,
OBJECTTYPE INT,
TABLEID INT,
INDEXID INT,
OVERRIDE INT,
PARM NVARCHAR(25),
VALUE NVARCHAR(255),
RECVERSION INT,
RECID BIGINT IDENTITY(56371455760,1)
);

CREATE TABLE #CompressionConfigNC
(
TableName NVARCHAR(max),
IndexName NVARCHAR(max) NULL,
IndexType NVARCHAR(20),
IndexCompression NVARCHAR(40),
AXTableID bigint
);


INSERT #CompressionConfigNC
(TableName,IndexName,IndexType,IndexCompression)
SELECT so.name AS TableName, si.name AS IndexName, si.type_desc as Type, sp.data_compression_desc
FROM sys.partitions sp
JOIN sys.indexes si ON si.index_id = sp.index_id AND si.object_id = sp.object_id
JOIN sys.objects so ON so.object_id = si.object_id
WHERE SP.data_compression_desc <> 'NONE' ;

UPDATE C SET C.AXTableID = SD.TABLEID
FROM #CompressionConfigNC C
JOIN SQLDICTIONARY SD ON SD.SQLNAME = C.TableName AND SD.FIELDID=0;

----------------------------------------------------------------------------
---Index Pass 1 PARM Record
----------------------------------------------------------------------------
INSERT #SQLStorage
(ID ,OBJECTTYPE,TABLEID,INDEXID,OVERRIDE,PARM,VALUE,RECVERSION)

SELECT 
0,
1,
CC.AXTableID,
IP.INDEXID,  
0,
'COMPRESSION',
CASE
	WHEN CC.IndexCompression = 'PAGE' THEN '1'
	WHEN CC.IndexCompression = 'ROW' THEN '2'
	END,
1  
FROM AOTINDEXPROPERTIES IP 
JOIN #CompressionConfigNC CC ON IP.TABLENAME = CC.tablename AND IP.INDEXNAME = CC.IndexName;



----------------------------------------------------------------------------------
--Index Pass 2 VALUE Record
----------------------------------------------------------------------------
INSERT #SQLStorage
(ID ,OBJECTTYPE,TABLEID,INDEXID,OVERRIDE,PARM,VALUE,RECVERSION)
SELECT 
1,
1,
CC.AXTableId,
IP.INDEXID, 
0,
'',
CASE
	WHEN CC.IndexCompression = 'PAGE' THEN 'WITH (DATA_COMPRESSION = PAGE )'
	WHEN CC.IndexCompression = 'ROW' THEN 'WITH (DATA_COMPRESSION = ROW )'
	END,
1  
FROM #CompressionConfigNC CC  
JOIN AOTINDEXPROPERTIES IP ON CC.TableName = IP.TABLENAME AND IP.INDEXNAME = CC.IndexName;

DELETE FROM SQLSTORAGE;

--Insert #SQLStorage Records into SQLStorage
INSERT SQLSTORAGE	
([ID],[OBJECTTYPE],[TABLEID],[INDEXID],[OVERRIDE],[PARM],[VALUE],[RECVERSION],[RECID])
SELECT [ID],[OBJECTTYPE],[TABLEID],[INDEXID],[OVERRIDE],[PARM],[VALUE],[RECVERSION],[RECID] FROM #SQLStorage;

 
--Create or update the SYSTEMSEQUENCES record for the SQLStorage Table
IF (SELECT COUNT(*) FROM SYSTEMSEQUENCES WHERE TABID = '65515') > 0
	BEGIN
	UPDATE SYSTEMSEQUENCES SET NEXTVAL = (SELECT (MAX(RECID)+1) FROM #SQLStorage)
	WHERE TABID = '65515' 
	END;
	
IF (SELECT COUNT(*) FROM SYSTEMSEQUENCES WHERE TABID = '65515') < 1
	BEGIN
	INSERT SYSTEMSEQUENCES
	(ID,NEXTVAL,MINVAL,MAXVAL,CYCLE,NAME,TABID,DATAAREAID,RECVERSION,RECID)
	VALUES
	(-1,(SELECT (MAX(RECID)+1) FROM #SQLStorage),1,9223372036854775807,0,'SEQNO','65515','dat',1,-1)
	END;


DROP Table #SQLStorage
DROP TABLE #CompressionConfigNC

PRINT
'
Completed
'