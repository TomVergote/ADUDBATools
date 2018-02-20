-- Read trace file and number rows
WITH NumberedLockEntries AS
(
SELECT 
	ROW_NUMBER() OVER (PARTITION BY transactionid ORDER BY endtime DESC) rn, 
	StartTime, 
	EndTime 
FROM fn_trace_gettable('C:\SQLTrace\DYNAMICS_DEFAULT.trc', DEFAULT)
WHERE EventClass = 137 and DatabaseID=5
)
, 
-- Get last value from multiple blocked process reports for every lock 
-- as the same block gets reported every 5 seconds
-- and parse statements
LastEntryForEachLock AS
(
SELECT 
	
	*
FROM NumberedLockEntries
where rn=1
)
-- group blockings by most occuring tables
SELECT 
	isnull(max(DATEDIFF ( SECOND , StartTime , EndTime)),0) AS duration_in_seconds
FROM  LastEntryForEachLock 
where starttime > dateadd(hour, -1, getdate())