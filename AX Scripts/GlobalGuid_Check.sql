-- =============================================
-- Author: Bjorn Mistiaen
-- Create date: 2018-04-04
-- Check GlobalGuid's for AX databases on an instance.
-- GlobalGuid's should be different for all AX databases on the same instance. 
-- If not, they share the same cache (AUC) which can lead to unexpected behavior.
-- Explanation here: http://daxmusings.codecrib.com/2013/01/fixing-code-caching-on-ax-environment.html
-- =============================================

IF OBJECT_ID('tempdb..#GlobalGuid') IS NOT NULL
	DROP TABLE dbo.#GlobalGuid

CREATE TABLE dbo.#GlobalGuid
	(
	DBName varchar(40),
	GlobalGuid uniqueidentifier
	)

DECLARE @command varchar(1000) 
SELECT @command = 'USE ?; 
	IF EXISTS(SELECT NULL FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''SYSSQMSETTINGS'') 
		BEGIN 
			INSERT INTO dbo.#GlobalGuid (DBName, GlobalGuid) 
			SELECT DB_NAME(), globalguid from SYSSQMSETTINGS 
		END;'
EXEC sp_MSforeachdb @command 

SELECT DBName as [DBName (Sorted)], GlobalGuid FROM dbo.#GlobalGuid ORDER BY 1
SELECT DBName, GlobalGuid as [GlobalGuid (Sorted)] FROM dbo.#GlobalGuid ORDER BY 2

IF OBJECT_ID('tempdb..#GlobalGuid') IS NOT NULL
	DROP TABLE dbo.#GlobalGuid
