---------------------------------------------------------------------
-- What are scalar functions
---------------------------------------------------------------------

SELECT
	Name
	,SellStartDate 
	,DATENAME(DW,SellStartDate) + ' ' +
	DATENAME(D,SellStartDate) + ' ' +
	DATENAME(M,SellStartDate) + ' ' +
	DATENAME(YY,SellStartDate)
FROM 
	Production.Product


---------------------------------------------------------------------
-- Defining a function
---------------------------------------------------------------------

CREATE FUNCTION fnLengthyDate
	(	
		@EntireDate AS DATETIME
	)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
END	
  

---------------------------------------------------------------------
-- Appending code to a function
---------------------------------------------------------------------

USE AdventureWorks;
GO

CREATE FUNCTION fnLengthyDate
	(	
		@EntireDate AS DATETIME
	)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	RETURN DATENAME(DW,@EntireDate) + ' ' +
	DATENAME(D,@EntireDate) + ' ' +
	DATENAME(M,@EntireDate) + ' ' +
	DATENAME(YY,@EntireDate)

END	


---------------------------------------------------------------------
-- Examine and Evaluate a Function
---------------------------------------------------------------------

SELECT
	Name
	,SellStartDate
	,dbo.fnLengthyDate(SellStartDate)
FROM 
	Production.Product


---------------------------------------------------------------------
-- Modifying a function
---------------------------------------------------------------------

USE [AdventureWorks]
GO


ALTER FUNCTION [dbo].[fnLengthyDate]
	(	
		@EntireDate AS DATETIME
	)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	RETURN DATENAME(DW,@EntireDate) + ' ' +
	DATENAME(D,@EntireDate) +
	CASE
		WHEN DAY(@EntireDate) IN (1, 21, 31) THEN 'st'
		WHEN DAY(@EntireDate) IN (2, 22) THEN 'nd'
		WHEN DAY(@EntireDate) IN (3, 23) THEN 'rd'
		ELSE 'th'
	END + ' ' + 
	DATENAME(M,@EntireDate) + ' ' +
	DATENAME(YY,@EntireDate)

END	

-- Excute query 1
SELECT
	Name
	,SellStartDate
	,dbo.fnLengthyDate(SellStartDate)
FROM 
	Production.Product 

-- Execute query 2
SELECT
	PurchaseOrderID
	,DueDate
	,[dbo].[fnLengthyDate](DueDate)
FROM 
	[Purchasing].[PurchaseOrderDetail]

---------------------------------------------------------------------
-- Complex Expressions
---------------------------------------------------------------------
SELECT
	Name
	,CASE 
		WHEN  CHARINDEX(' ',Name) > 0 THEN LEFT(Name, CHARINDEX(' ',Name)-1)			
		ELSE Name
	END
	,CHARINDEX(' ', Name)
FROM 
	Production.Product


---------------------------------------------------------------------
-- Making Use of Variables and IF Statements
---------------------------------------------------------------------
CREATE FUNCTION  fnFirstWordProdName
	(	
		@ProdName AS VARCHAR(MAX)
	)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @BlankPosition AS INT
	DECLARE @Outcome AS VARCHAR(MAX)

	SET @BlankPosition = CHARINDEX(' ',@ProdName)

	IF @BlankPosition = 0
		SET @Outcome = @ProdName
	ELSE
		SET @OutCome = LEFT(@ProdName, @BlankPosition - 1)

	RETURN @Outcome 
END	


-- Test Function
SELECT
	Name
	,dbo.fnFirstWordProdName(Name)
FROM 
	Production.Product



