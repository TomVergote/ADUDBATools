DBATools
========

Just a collection of scripts to create a DBATools database, which for now does nothing more than log/parse blocked processes.

Installation
----------------
First enable blocked process reports by configuring the treshold.
The included script sets it to 5 seconds

Run EnableBlockedProcessReports

Start the server side trace, open StartSQLProfilerTrace.sql, change the file path and size properties and execute.
Logs the following events:
- Data file auto growth
- Log file auto growth
- Blocked Process report
- Exception
- Deadlock graph
- Lock escalation
- Auto stats


Then create the DBATools database
Open CreateADUDBAToolsDatabase, change file paths for trace files and run

Create the SQL Agent jobs by running CreateJobs
