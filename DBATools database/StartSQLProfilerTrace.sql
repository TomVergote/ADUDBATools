/****************************************************/
/* Created by: SQL Server 2014 Profiler          */
/* Date: 20/02/2018  09:39:06         */
/****************************************************/

/****
Logs following events:
- Data file auto growth
- Log file auto growth
- Blocked Process report
- Exception
- Deadlock graph
- Lock escalation
- Auto stats
**/

-- Create a Queue
declare @rc int;
declare @TraceID int;
declare @maxfilesizeMB bigint;
declare @TraceEndDateTime datetime;
declare @TraceFilename nvarchar(500);
declare @rolloverfilecount int;

set @TraceEndDateTime = '2020-12-12 00:00:00.000';
set @maxfilesizeMB = 1024;
set @TraceFilename = N'G:\SQLTrace\ADUTrace';
set @rolloverfilecount = 10;

-- Please replace the text InsertFileNameHere, with an appropriate
-- filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
-- will be appended to the filename automatically. If you are writing from
-- remote server to local drive, please use UNC path and make sure server has
-- write access to your network share

/* Create the basic server side trace */
exec @rc = sp_trace_create 
	@TraceID output, 
	@options = 2 /* trace will use rollover files */, 
	@tracefile = @TraceFilename, 
	@maxfilesize = @maxfilesizeMB, 
	@stoptime = @TraceEndDateTime,
	@filecount = @rolloverfilecount;


if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 92, 3, @on
exec sp_trace_setevent @TraceID, 92, 11, @on
exec sp_trace_setevent @TraceID, 92, 7, @on
exec sp_trace_setevent @TraceID, 92, 8, @on
exec sp_trace_setevent @TraceID, 92, 9, @on
exec sp_trace_setevent @TraceID, 92, 10, @on
exec sp_trace_setevent @TraceID, 92, 12, @on
exec sp_trace_setevent @TraceID, 92, 13, @on
exec sp_trace_setevent @TraceID, 92, 14, @on
exec sp_trace_setevent @TraceID, 92, 15, @on
exec sp_trace_setevent @TraceID, 92, 25, @on
exec sp_trace_setevent @TraceID, 92, 26, @on
exec sp_trace_setevent @TraceID, 92, 35, @on
exec sp_trace_setevent @TraceID, 92, 36, @on
exec sp_trace_setevent @TraceID, 92, 41, @on
exec sp_trace_setevent @TraceID, 92, 51, @on
exec sp_trace_setevent @TraceID, 92, 60, @on
exec sp_trace_setevent @TraceID, 92, 64, @on
exec sp_trace_setevent @TraceID, 93, 3, @on
exec sp_trace_setevent @TraceID, 93, 11, @on
exec sp_trace_setevent @TraceID, 93, 7, @on
exec sp_trace_setevent @TraceID, 93, 8, @on
exec sp_trace_setevent @TraceID, 93, 9, @on
exec sp_trace_setevent @TraceID, 93, 10, @on
exec sp_trace_setevent @TraceID, 93, 12, @on
exec sp_trace_setevent @TraceID, 93, 13, @on
exec sp_trace_setevent @TraceID, 93, 14, @on
exec sp_trace_setevent @TraceID, 93, 15, @on
exec sp_trace_setevent @TraceID, 93, 25, @on
exec sp_trace_setevent @TraceID, 93, 26, @on
exec sp_trace_setevent @TraceID, 93, 35, @on
exec sp_trace_setevent @TraceID, 93, 36, @on
exec sp_trace_setevent @TraceID, 93, 41, @on
exec sp_trace_setevent @TraceID, 93, 51, @on
exec sp_trace_setevent @TraceID, 93, 60, @on
exec sp_trace_setevent @TraceID, 93, 64, @on
exec sp_trace_setevent @TraceID, 137, 1, @on
exec sp_trace_setevent @TraceID, 137, 3, @on
exec sp_trace_setevent @TraceID, 137, 4, @on
exec sp_trace_setevent @TraceID, 137, 12, @on
exec sp_trace_setevent @TraceID, 137, 13, @on
exec sp_trace_setevent @TraceID, 137, 14, @on
exec sp_trace_setevent @TraceID, 137, 22, @on
exec sp_trace_setevent @TraceID, 137, 15, @on
exec sp_trace_setevent @TraceID, 137, 24, @on
exec sp_trace_setevent @TraceID, 137, 26, @on
exec sp_trace_setevent @TraceID, 137, 32, @on
exec sp_trace_setevent @TraceID, 137, 41, @on
exec sp_trace_setevent @TraceID, 137, 51, @on
exec sp_trace_setevent @TraceID, 137, 60, @on
exec sp_trace_setevent @TraceID, 137, 64, @on
exec sp_trace_setevent @TraceID, 33, 1, @on
exec sp_trace_setevent @TraceID, 33, 9, @on
exec sp_trace_setevent @TraceID, 33, 3, @on
exec sp_trace_setevent @TraceID, 33, 11, @on
exec sp_trace_setevent @TraceID, 33, 4, @on
exec sp_trace_setevent @TraceID, 33, 6, @on
exec sp_trace_setevent @TraceID, 33, 7, @on
exec sp_trace_setevent @TraceID, 33, 8, @on
exec sp_trace_setevent @TraceID, 33, 10, @on
exec sp_trace_setevent @TraceID, 33, 12, @on
exec sp_trace_setevent @TraceID, 33, 14, @on
exec sp_trace_setevent @TraceID, 33, 20, @on
exec sp_trace_setevent @TraceID, 33, 26, @on
exec sp_trace_setevent @TraceID, 33, 30, @on
exec sp_trace_setevent @TraceID, 33, 31, @on
exec sp_trace_setevent @TraceID, 33, 35, @on
exec sp_trace_setevent @TraceID, 33, 41, @on
exec sp_trace_setevent @TraceID, 33, 49, @on
exec sp_trace_setevent @TraceID, 33, 50, @on
exec sp_trace_setevent @TraceID, 33, 51, @on
exec sp_trace_setevent @TraceID, 33, 60, @on
exec sp_trace_setevent @TraceID, 33, 64, @on
exec sp_trace_setevent @TraceID, 33, 66, @on
exec sp_trace_setevent @TraceID, 148, 1, @on
exec sp_trace_setevent @TraceID, 148, 41, @on
exec sp_trace_setevent @TraceID, 148, 4, @on
exec sp_trace_setevent @TraceID, 148, 12, @on
exec sp_trace_setevent @TraceID, 148, 11, @on
exec sp_trace_setevent @TraceID, 148, 51, @on
exec sp_trace_setevent @TraceID, 148, 14, @on
exec sp_trace_setevent @TraceID, 148, 26, @on
exec sp_trace_setevent @TraceID, 148, 60, @on
exec sp_trace_setevent @TraceID, 148, 64, @on
exec sp_trace_setevent @TraceID, 60, 1, @on
exec sp_trace_setevent @TraceID, 60, 9, @on
exec sp_trace_setevent @TraceID, 60, 3, @on
exec sp_trace_setevent @TraceID, 60, 4, @on
exec sp_trace_setevent @TraceID, 60, 5, @on
exec sp_trace_setevent @TraceID, 60, 6, @on
exec sp_trace_setevent @TraceID, 60, 7, @on
exec sp_trace_setevent @TraceID, 60, 8, @on
exec sp_trace_setevent @TraceID, 60, 10, @on
exec sp_trace_setevent @TraceID, 60, 11, @on
exec sp_trace_setevent @TraceID, 60, 12, @on
exec sp_trace_setevent @TraceID, 60, 14, @on
exec sp_trace_setevent @TraceID, 60, 21, @on
exec sp_trace_setevent @TraceID, 60, 22, @on
exec sp_trace_setevent @TraceID, 60, 25, @on
exec sp_trace_setevent @TraceID, 60, 26, @on
exec sp_trace_setevent @TraceID, 60, 32, @on
exec sp_trace_setevent @TraceID, 60, 35, @on
exec sp_trace_setevent @TraceID, 60, 41, @on
exec sp_trace_setevent @TraceID, 60, 49, @on
exec sp_trace_setevent @TraceID, 60, 51, @on
exec sp_trace_setevent @TraceID, 60, 55, @on
exec sp_trace_setevent @TraceID, 60, 56, @on
exec sp_trace_setevent @TraceID, 60, 57, @on
exec sp_trace_setevent @TraceID, 60, 58, @on
exec sp_trace_setevent @TraceID, 60, 60, @on
exec sp_trace_setevent @TraceID, 60, 61, @on
exec sp_trace_setevent @TraceID, 60, 64, @on
exec sp_trace_setevent @TraceID, 60, 66, @on
exec sp_trace_setevent @TraceID, 58, 1, @on
exec sp_trace_setevent @TraceID, 58, 9, @on
exec sp_trace_setevent @TraceID, 58, 3, @on
exec sp_trace_setevent @TraceID, 58, 11, @on
exec sp_trace_setevent @TraceID, 58, 4, @on
exec sp_trace_setevent @TraceID, 58, 6, @on
exec sp_trace_setevent @TraceID, 58, 7, @on
exec sp_trace_setevent @TraceID, 58, 8, @on
exec sp_trace_setevent @TraceID, 58, 10, @on
exec sp_trace_setevent @TraceID, 58, 12, @on
exec sp_trace_setevent @TraceID, 58, 13, @on
exec sp_trace_setevent @TraceID, 58, 14, @on
exec sp_trace_setevent @TraceID, 58, 15, @on
exec sp_trace_setevent @TraceID, 58, 21, @on
exec sp_trace_setevent @TraceID, 58, 22, @on
exec sp_trace_setevent @TraceID, 58, 23, @on
exec sp_trace_setevent @TraceID, 58, 24, @on
exec sp_trace_setevent @TraceID, 58, 25, @on
exec sp_trace_setevent @TraceID, 58, 26, @on
exec sp_trace_setevent @TraceID, 58, 31, @on
exec sp_trace_setevent @TraceID, 58, 35, @on
exec sp_trace_setevent @TraceID, 58, 41, @on
exec sp_trace_setevent @TraceID, 58, 49, @on
exec sp_trace_setevent @TraceID, 58, 51, @on
exec sp_trace_setevent @TraceID, 58, 55, @on
exec sp_trace_setevent @TraceID, 58, 57, @on
exec sp_trace_setevent @TraceID, 58, 60, @on
exec sp_trace_setevent @TraceID, 58, 64, @on
exec sp_trace_setevent @TraceID, 58, 66, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler - 79665a2b-62c5-4646-a111-39d23ceb20a9'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go
