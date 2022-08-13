---------------------------------------------------------------------
-- A Recap of User-Defined Functions
---------------------------------------------------------------------
USE AdventureWorks
GO

SELECT
	Name
	,SellStartDate
	,dbo.fnLengthyDate(SellStartDate)
FROM 
	Production.Product


---------------------------------------------------------------------
-- Getting to Know Table Valued Functions
---------------------------------------------------------------------

-- Example 1
USE AdventureWorks;
GO

SELECT
	Name
	,SellStartDate
	, ListPrice
FROM 
	Production.Product
WHERE
	YEAR(SellStartDate) = 2011

-- Example 2
USE AdventureWorks;
GO

SELECT
	Name
	,SellStartDate
	,ListPrice
FROM 
	SellStartDateInYear(2011)


---------------------------------------------------------------------
-- Inline Table-Valued Function Definition
---------------------------------------------------------------------
USE AdventureWorks
GO

CREATE FUNCTION SellStartDateInYear
(
	@SellStartDateYear INT
)
RETURNS TABLE
AS
RETURN
	SELECT
		Name
		,SellStartDate
		,  ListPrice
	FROM 
		Production.Product
	WHERE
		YEAR(SellStartDate) = @SellStartDateYear



---------------------------------------------------------------------
-- Utilizing Table Value Function in a Query
---------------------------------------------------------------------
USE AdventureWorks
GO

SELECT
	Name
	,SellStartDate
	,ListPrice
FROM
	dbo.SellStartDateInYear(2011) 


---------------------------------------------------------------------
-- mending a table valued function
---------------------------------------------------------------------
USE AdventureWorks
GO


ALTER FUNCTION [dbo].[SellStartDateInYear]
(
	@SellStartYear INT
	,@SellEndYear INT
)
RETURNS TABLE
AS
RETURN
	SELECT
		Name
		,SellStartDate
		, ListPrice
	FROM 
		Production.Product
	WHERE
		YEAR(SellStartDate) BETWEEN @SellStartYear AND @SellEndYear 


-- Execute

USE [AdventureWorks]
GO

SELECT
	Name
	,SellStartDate
	,ListPrice
FROM
	dbo.SellStartDateInYear(2011,2013)

---------------------------------------------------------------------
-- Defining a Multistatement Table Valued Function
---------------------------------------------------------------------
USE AdventureWorks
GO

CREATE FUNCTION EmployeeHireYear
(
	@HireYear INT
)


---------------------------------------------------------------------
-- MSTVF_Usage
---------------------------------------------------------------------

USE AdventureWorks
GO

SELECT 
	LoginID
	,HireDate
	,JobTitle
FROM
	dbo.EmployeeHireYear(2009)


---------------------------------------------------------------------
-- Modifying MSTVF
---------------------------------------------------------------------

USE AdventureWorks
GO

CREATE FUNCTION EmployeeHireYear
(
	@HireYear INT
)
RETURNS @t TABLE
(
	LoginID VARCHAR(MAX)
	,HireDate DATETIME
	,JobTitle VARCHAR(30)
)
AS  
BEGIN
	INSERT INTO @t
	SELECT 
		LoginID
		,HireDate
		,'Production Technician - WC50'
	FROM 
		HumanResources.Employee
	WHERE
		YEAR(HireDate) = @HireYear 
		AND JobTitle = 'Production Technician - WC50'

	INSERT INTO @t
	SELECT 
		LoginID
		,HireDate
		,'Quality Assurance Technician'
	FROM 
		HumanResources.Employee
	WHERE
		YEAR(HireDate) = @HireYear
		AND JobTitle = 'Quality Assurance Technician'


	RETURN 
END
	
