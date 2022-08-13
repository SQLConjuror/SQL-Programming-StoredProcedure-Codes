---------------------------------------------------------------------
-- What are parameters
---------------------------------------------------------------------

CREATE PROC spListPrice
AS
BEGIN
	SELECT Name
	   , ListPrice
	FROM Production.Product
	WHERE ListPrice >= 100
END

---------------------------------------------------------------------
-- Adding a Parameter
---------------------------------------------------------------------

CREATE PROC spProdList (@MinListPrice AS INT)
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

USE AdventureWorks2017;
GO

CREATE PROC spProdList (@MinListPrice AS INT)
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

EXEC spProdList 100

EXEC spProdList 200

---------------------------------------------------------------------
-- Add several parameters
---------------------------------------------------------------------

USE AdventureWorks2017;
GO

ALTER PROC spProdList 
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


