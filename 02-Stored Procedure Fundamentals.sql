---------------------------------------------------------------------
-- Fundamental Stored Procedure
---------------------------------------------------------------------

SELECT  
	p.FirstName
	,p.LastName
	,UPPER(e.JobTitle) AS [JobTitle]
	,DATENAME(MONTH,e.BirthDate) AS [BirthdayMonth]
FROM   
	HumanResources.Employee AS e 
	INNER JOIN Person.Person AS p 
		ON e.BusinessEntityID=p.BusinessEntityID
	INNER JOIN HumanResources.EmployeePayHistory AS ph
		ON p.BusinessEntityID=ph.BusinessEntityID



-- How to execute a stored procedure
EXECUTE spEmployeeInfo

---------------------------------------------------------------------
-- Writing a Stored Procedure
---------------------------------------------------------------------

USE AdventureWorks
GO 


CREATE PROCEDURE spProductInfo
AS
BEGIN
	SELECT 
	    ProductID
	   ,Name
	   ,ProductNumber
	FROM 
		Production.Product
	ORDER BY
		Name ASC
END

---------------------------------------------------------------------
-- Running a stored procedure
---------------------------------------------------------------------
EXEC spProductInfo

---------------------------------------------------------------------
-- Alter a stored procedure
---------------------------------------------------------------------
USE AdventureWorks
GO

ALTER PROCEDURE spProductInfo
AS
BEGIN
	SELECT 
	    ProductID
	   ,Name
	   ,ProductNumber
	   ,SafetyStockLevel
	FROM 
		Production.Product
	ORDER BY
		Name DESC
END


---------------------------------------------------------------------
-- Dropping a stored procedure
---------------------------------------------------------------------

DROP PROC spProductInfo