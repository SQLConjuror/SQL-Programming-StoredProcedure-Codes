---------------------------------------------------------------------
-- Creating a logical test
---------------------------------------------------------------------

DECLARE @PricePoint INT

SET @PricePoint = (SELECT AVG(ListPrice) FROM Production.Product WHERE ListPrice < 500)

IF @PricePoint < 500
	PRINT 'These products are cheap'

------------------------------------------------------------------------

DECLARE @PricePoint INT

SET @PricePoint = (SELECT AVG(ListPrice) FROM Production.Product WHERE ListPrice < 500)

IF @PricePoint < 500
	PRINT 'These products are cheap'

---------------------------------------------------------------------
-- Definition of IF Statement
---------------------------------------------------------------------
DECLARE @NumProducts INT

SET @NumProducts = (SELECT COUNT(*) FROM Production.Product WHERE ListPrice = 742.35)



---------------------------------------------------------------------
-- Using the ELSE clause
---------------------------------------------------------------------

DECLARE @NumProducts INT

SET @NumProducts = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 4)
 
IF @NumProducts > 7
	PRINT 'There are too many accessories'


---------------------------------------------------------------------

DECLARE @NumProducts INT

SET @NumProducts = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 4)
 
IF @NumProducts > 20
	PRINT 'There are too many accessories'
ELSE
	PRINT 'There are no more than 20 accessories'



---------------------------------------------------------------------
-- BEGIN and END block
---------------------------------------------------------------------

DECLARE @ProdCat INT

SELECT @ProdCat = ProductCategoryID FROM Production.ProductCategory WHERE ProductCategoryID = 4 --Accessories

IF @ProdCat = 4
	BEGIN
		PRINT 'This is your chosen category'
		PRINT 'These products are accessories'
	END
ELSE
	BEGIN
		PRINT 'This is not your chosen category'
		PRINT 'These products are NOT accessories'
	END

---------------------------------------------------------------------
-- Nesting IF statements
---------------------------------------------------------------------



DECLARE @Accessories INT
DECLARE @Clothing INT

SET @Accessories = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 4)
SET @Clothing = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 2)
 
IF @Accessories > 7
	BEGIN
		PRINT 'CAUTION!'
		PRINT 'There are too many accessories'
	END
ELSE
	BEGIN
		PRINT 'VERIFICATION'
		PRINT 'There are no more than 20 accessories'
	END


---------------------------------------------------------------------


DECLARE @Accessories INT
DECLARE @Clothing INT

SET @Accessories = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 4)
SET @Clothing = (SELECT COUNT(*) FROM Production.ProductSubcategory WHERE ProductCategoryID = 2)
 
IF @Accessories > 7 
	BEGIN
		PRINT 'CAUTION!'
		PRINT 'There are too many accessories'
		IF @Clothing > 20
			BEGIN
				PRINT 'Good, we have enough clothing items to compensate of it'
			END
		ELSE
			BEGIN
				PRINT 'There are not enough clothing products'
			END
	END
ELSE
	BEGIN
		PRINT 'VERIFICATION'
		PRINT 'There are no more than 20 accessories'
	END




---------------------------------------------------------------------
-- Utilizing SELECT statements within an IF
---------------------------------------------------------------------

USE AdventureWorks
GO

CREATE PROC spGenderData
	(
		@GetInfo VARCHAR(5) -- This can be ALL, MALE, or FEMALE 
	)
AS 
BEGIN
	IF @GetInfo='ALL'
		BEGIN
			(SELECT * FROM HumanResources.Employee)
			RETURN
		END
END

-- To execute
EXEC spGenderData @GetInfo='ALL'


-- Alter

USE AdventureWorks
GO

ALTER PROC spGenderData
	(
		@GetInfo VARCHAR(7) -- This can be ALL, MALE, or FEMALE
	)
AS 
BEGIN
	IF @GetInfo='ALL'
		BEGIN
			(SELECT * FROM HumanResources.Employee)
			RETURN
		END

	IF @GetInfo='MALE'
		BEGIN
			(SELECT * FROM HumanResources.Employee WHERE Gender = 'M')
			RETURN
		END

	IF @GetInfo='FEMALE'
		BEGIN
			( )
			RETURN
		END

	SELECT 'Please choose ALL, MALE or FEMALE'
END
