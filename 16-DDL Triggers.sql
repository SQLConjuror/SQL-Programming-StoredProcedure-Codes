---------------------------------------------------------------------
-- DDL_Creation
---------------------------------------------------------------------

USE AdventureWorks
GO

CREATE TRIGGER trgNewTablesNotAllowed
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
	PRINT 'Please do not create new tables’'
	ROLLBACK
END


---------------------------------------------------------------------
-- Trigger_Testing
---------------------------------------------------------------------
USE AdventureWorks
GO

-- Create a test table 
CREATE TABLE TestTable(ID INT)
GO


-------------------------------------

USE DBTest
GO

-- Create a test table 
CREATE TABLE TestTable(ID INT)
GO

---------------------------------------------------------------------
-- Trigger_Modification
---------------------------------------------------------------------

USE AdventureWorks
GO

ALTER TRIGGER trgNewTablesNotAllowed
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
	PRINT 'Please do not create new tables or make changes to existing tables'
	ROLLBACK
END



-----------------------------------------------------------------------------------

-- To test
USE AdventureWorks;
GO

-- Create a test table 
CREATE TABLE TestTable(ID INT)
GO

DROP TABLE DatabaseLog
GO


---------------------------------------------------------------------
-- Trigger_Deletion
---------------------------------------------------------------------

USE AdventureWorks
GO

DROP TRIGGER trgNewTablesNotAllowed ON DATABASE

---------------------------------------------------------------------
-- Trigger_Disabling_and_Enabling
---------------------------------------------------------------------

USE AdventureWorks
GO

CREATE TRIGGER trgNewTablesNotAllowed
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
	PRINT 'Please do not create new tables or make changes to existing tables'
	ROLLBACK
END




-- SSMS > Database > Programmability > Triggers > Right-click > Disable 

---------------------------------------------------------------------

USE AdventureWorks
GO

DISABLE TRIGGER trgNewTablesNotAllowed ON DATABASE

-- ENABLE TRIGGER trgNewTablesNotAllowed ON DATABASE

---------------------------------------------------------------------
-- Simultaneous_Disabling_of_Triggers
---------------------------------------------------------------------

USE AdventureWorks
GO

DISABLE TRIGGER ALL ON DATABASE

-- ENABLE TRIGGER ALL ON DATABASE

ENABLE TRIGGER trgNewTablesNotAllowed ON DATABASE

-- DISABLE TRIGGER trgNewTablesNotAllowed ON DATABASE

---------------------------------------------------------------------
-- Server-scoped trigger Creation
---------------------------------------------------------------------

USE AdventureWorks;
GO

CREATE TRIGGER trgNewTablesNotAllowed
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
	PRINT 'Please do not create new tables or make changes to existing tables'
	ROLLBACK
END

--------------------------------------------------------------------------------

USE AdventureWorks;
GO

ENABLE TRIGGER ALL ON ALL SERVER

--------------------------------------------------------------------------------

USE AdventureWorks;
GO

DROP TRIGGER trgNewTablesNotAllowed ON ALL SERVER

---------------------------------------------------------------------
-- Modify Execution Order of Triggers
---------------------------------------------------------------------


USE AdventureWorks;
GO

CREATE TRIGGER trgTrigger2 ON DATABASE
FOR CREATE_TABLE AS
	PRINT 'This is trigger 2'
GO

CREATE TRIGGER trgTrigger1 ON DATABASE
FOR CREATE_TABLE AS
	PRINT 'This is trigger 1'
GO


--------------------------------------------------------------------

-- Create test table
CREATE TABLE tbl1 (ID INT)
GO

-- Delete test table
DROP TABLE tbl1
GO


--------------------------------------------------------------------

USE AdventureWorks;
GO

EXEC sp_settriggerorder
	@triggername = 'trgTrigger1'
	,@order = 'first'
	,@stmttype = 'CREATE_TABLE'
	,@namespace = 'DATABASE'

--------------------------------------------------------------------


USE AdventureWorks;
GO

EXEC sp_settriggerorder
	@triggername = 'trgTrigger1'
	,@order = 'last'
	,@stmttype = 'CREATE_TABLE'
	,@namespace = 'DATABASE'

--------------------------------------------------------------------

USE AdventureWorks;
GO

EXEC sp_settriggerorder
	@triggername = 'trgTrigger1'
	,@order = 'none'
	,@stmttype = 'CREATE_TABLE'
	,@namespace = 'DATABASE'