---------------------------------------------------------------------
-- Basic Syntax of WHILE loops
---------------------------------------------------------------------

DECLARE @Marker INT 

SET @Marker = 1
 
WHILE @Marker <= 15 
	BEGIN
		PRINT @Marker 
		SET @Marker = @Marker + 1
	END


---------------------------------------------------------------------
-- Using SELECT statements in a Loop
---------------------------------------------------------------------

DECLARE @Marker INT 
DECLARE @MaxVacationHours INT
DECLARE @NumEmployees INT

SET @MaxVacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee)
SET @Marker = 0
 
WHILE @Marker <= @MaxVacationHours
	BEGIN
		SET @NumEmployees = 
			(SELECT COUNT(*) FROM HumanResources.Employee WHERE VacationHours = @Marker)

		PRINT CAST(@NumEmployees AS VARCHAR(3)) + ' employees still have  ' + 
			  CAST(@Marker AS VARCHAR(2)) + ' Vacation Hours'

		SET @Marker = @Marker + 1
	END


---------------------------------------------------------------------
-- Get out of a loop using BREAK
---------------------------------------------------------------------

DECLARE @Marker INT 
DECLARE @MaxVacationHours INT
DECLARE @NumEmployees INT

SET @MaxVacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee)
SET @Marker = 0
 
WHILE @Marker <= @MaxVacationHours
	BEGIN
		SET @NumEmployees = 
			(SELECT COUNT(*) FROM HumanResources.Employee WHERE VacationHours = @Marker)

		IF @Marker = 20
		BREAK

		PRINT CAST(@NumEmployees AS VARCHAR(3)) + ' employees still have  ' + 
			  CAST(@Marker AS VARCHAR(2)) + ' Vacation Hours'

		SET @Marker = @Marker + 1
	END


---------------------------------------------------------------------
-- Stop a Never Ending Loop
---------------------------------------------------------------------
DECLARE @Marker INT
DECLARE @MaxVacationHours INT
DECLARE @NumEmployees INT

SET @MaxVacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee)
SET @Marker = 0

WHILE @Marker <= @MaxVacationHours
	BEGIN
		SET @NumEmployees = 
			(SELECT COUNT(*) FROM HumanResources.Employee WHERE VacationHours = @Marker)

		PRINT CAST(@NumEmployees AS VARCHAR(3)) + ' employees still have  ' + 
			  CAST(@Marker AS VARCHAR(2)) + ' Vacation Hours'

		--SET @Marker = @Marker + 1
	END



---------------------------------------------------------------------
-- CURSORS in Loops
---------------------------------------------------------------------

DECLARE @ProductCategoryID INT
DECLARE @ProdCatName VARCHAR(MAX)

DECLARE ProdCatCursor CURSOR FOR
	SELECT ProductCategoryID, Name FROM Production.ProductCategory 

OPEN ProdCatCursor

FETCH NEXT FROM ProdCatCursor INTO @ProductCategoryID, @ProdCatName

WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Subcategories in Category ' + @ProdCatName
		SELECT Name FROM Production.ProductSubcategory WHERE ProductCategoryID = @ProductCategoryID

		FETCH NEXT FROM ProdCatCursor INTO @ProductCategoryID, @ProdCatName
	END

CLOSE ProdCatCursor
DEALLOCATE ProdCatCursor