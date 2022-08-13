---------------------------------------------------------------------
-- DML trigger creation
---------------------------------------------------------------------

USE AdventureWorks
GO

CREATE TRIGGER trgDepartmentModified
ON HumanResources.Department
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN 
	PRINT 'A change was made to the HumanResource.Department table'
END
GO


---------------------------------------------------------------------
-- Trigger_Testing
---------------------------------------------------------------------

USE AdventureWorks
GO

-- Turn off row counts
SET NOCOUNT ON;

-- Insert a new records into the Person.Person table
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('Data Engineering', 'Data Science')

-- Update a record in the Person.Person table
UPDATE HumanResources.Department
SET ModifiedDate = GETDATE()
WHERE DepartmentID = 7

-- Delete a record from the Person.Person table
DELETE FROM HumanResources.Department
WHERE GroupName = 'Data Science'

---------------------------------------------------------------------
-- Trigger_Modification
---------------------------------------------------------------------

USE AdventureWorks
GO

ALTER TRIGGER trgDepartmentModified
ON HumanResources.Department
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN 
	PRINT 'A change occurred to the HumanResources.Department table. Please verify.'
END
GO

---------------------------------------------------------------------
-- Trigger_Deletion
---------------------------------------------------------------------

USE AdventureWorks
GO

DROP TRIGGER  [HumanResources].[trgDepartmentModified]

---------------------------------------------------------------------
-- Constructing an INSTEAD OF triggers 
---------------------------------------------------------------------

USE AdventureWorks
GO

CREATE TRIGGER trgDeparmentInserted    
ON HumanResources.Department  
INSTEAD OF INSERT    -- Instead of and After trigger. The Instead of trigger completely replaces what the original event would have done
AS 
BEGIN
	RAISERROR ('Cannot insert a new department', 16, 1)
END
GO


-- to test
USE AdventureWorks 
GO

-- Turn off row counts
SET NOCOUNT ON;

-- Insert a new records into the Person.Person table
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('Data Engineering', 'Data Science')


SELECT * FROM HumanResources.Department WHERE Name = 'Data Engineering'


---------------------------------------------------------------------
-- The Inserted and Deleted Tables
---------------------------------------------------------------------

USE AdventureWorks
GO

ALTER TRIGGER HumanResources.trgDeparmentInserted
ON HumanResources.Department
AFTER INSERT    -- Instead of and After trigger. The Instead of trigger completely replaces what the original event would have done
AS
BEGIN
	SELECT * FROM inserted
END
GO



-- Test

-- Insert a new records into the Person.Person table
INSERT INTO HumanResources.Department(Name, GroupName)
VALUES('Data Engineering', 'Data Science')
GO

---------------------------------------------------------------------
-- Constructing an INSTEAD OF triggers 
---------------------------------------------------------------------