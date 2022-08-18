---------------------------------------------------------------------
-- What are parameters
---------------------------------------------------------------------

CREATE PROCEDURE spProductInfo2 (@ProdNameLike AS VARCHAR(MAX))
AS
BEGIN
	SELECT 
        ProductID
	   ,Name
	   ,ProductNumber
	FROM 
		Production.Product
	WHERE 
		Name LIKE '%' + @ProdNameLike + '%'
	ORDER BY
		Name ASC
END


-- Example
EXEC spProductInfo2 'Ball'

EXEC spProductInfo2 'Chain'

-- First Example

CREATE PROC spProdList
AS
BEGIN
	SELECT 	
		Name
	   , ListPrice
	FROM 
		Production.Product
	ORDER BY 
		Name ASC
	
END

---------------------------------------------------------------------
-- Adding a Parameter
---------------------------------------------------------------------
USE AdventureWorks2017
GO

CREATE PROC spListPrice (@MinListPrice AS INT)
AS
BEGIN
	SELECT 	
		Name
	   , ListPrice
	FROM 
		Production.Product
	ORDER BY 
		Name ASC
	
END

---------------------------------------------------------------------
-- Parameter Usage  in WHERE Clause
---------------------------------------------------------------------+

USE AdventureWorks2017
GO

CREATE PROC spListPrice (@MinListPrice AS INT)
AS
BEGIN
	SELECT 	
		Name
	   , ListPrice
	FROM 
		Production.Product
	WHERE 
		ListPrice > @MinListPrice
	ORDER BY 
		Name ASC
END

---------------------------------------------------------------------
-- Procedure Execution with Parameters
---------------------------------------------------------------------

EXEC spListPrice 100

EXEC spListPrice 500

---------------------------------------------------------------------
-- Add several parameters
---------------------------------------------------------------------

USE AdventureWorks2017
GO

ALTER PROC spListPrice 
	(
		@MinListPrice AS INT,
		@MaxListPrice AS INT
	)        
AS
BEGIN
	SELECT 	
		Name
	   , ListPrice
	FROM 
		Production.Product
	WHERE 
		ListPrice >= @MinListPrice 
		AND ListPrice <= @MaxListPrice 
	ORDER BY 
		Name ASC
END

-- To Execute:

EXEC spProdList 100 

EXEC spProdList 100, 200 

---------------------------------------------------------------------
-- Named Parameters
---------------------------------------------------------------------

EXEC spProdList @MinListPrice=100, @MaxListPrice=200 

---------------------------------------------------------------------
-- Using Text Parameters
---------------------------------------------------------------------

USE AdventureWorks2017;
GO

ALTER PROC spProdList 
	(
		@MinListPrice AS INT
		,@MaxListPrice  AS INT
		,@ProdName AS VARCHAR(MAX)
	)
AS
BEGIN
	SELECT 	
		Name
	   ,ListPrice
	FROM  
		Production.Product
	WHERE 
		ListPrice >= @MinListPrice AND
		ListPrice <= @MaxListPrice AND
		Name LIKE '%' + @ProdName + '%'
	ORDER BY 
		Name ASC
END


-- To Execute:
EXEC spProdList @MinListPrice=100, @MaxListPrice=200, @ProdName='' 


