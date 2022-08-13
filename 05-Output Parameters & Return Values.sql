---------------------------------------------------------------------
-- Parameters Review
---------------------------------------------------------------------

USE AdventureWorks
GO

CREATE PROC spSellStartInYear
	(
		@Year INT
	)
AS
BEGIN
	SELECT 	
		Name
	FROM 
		Production.Product
	WHERE 
		YEAR(SellStartDate) = @Year
	ORDER BY 
		Name ASC
END


-- To execute
EXEC spSellStartInYear @Year = 2013


---------------------------------------------------------------------
-- Vid2.Describing Output Parameters
---------------------------------------------------------------------
USE AdventureWorks
GO

ALTER PROC spSellStartInYear
	(
		@Year INT
		,@ProductList VARCHAR(MAX) OUTPUT
		,@ProductCount INT OUTPUT
	)
AS
BEGIN
	SELECT 	
		Name
	FROM 
		Production.Product
	WHERE 
		YEAR(SellStartDate) = @Year
	ORDER BY 
		Name ASC
END


---------------------------------------------------------------------
-- Setting the value of output parameters
---------------------------------------------------------------------

USE AdventureWorks
GO

ALTER PROC spSellStartInYear
	(
		@Year INT
		,@ProductList VARCHAR(MAX) OUTPUT
		,@ProductCount INT OUTPUT
	)
AS
BEGIN
	
	DECLARE @Products VARCHAR(MAX) -- type
	SET @Products = ''

	SELECT 	
		@Products = @Products + Name + ', ' -- type
	FROM 
		Production.Product
	WHERE 
		SellStartDate>= @Year
	ORDER BY 
		Name ASC

	SET @ProductCount = @@ROWCOUNT -- type
	SET @ProductList = @Products
END

---------------------------------------------------------------------
-- Retrieving the Results of Output Parameters
---------------------------------------------------------------------

USE AdventureWorks
GO

ALTER PROC spSellStartInYear
	(
		@Year INT
		,@ProductList VARCHAR(MAX) OUTPUT
		,@ProductCount  INT OUTPUT
	)
AS
BEGIN

	DECLARE @Products VARCHAR(MAX)
	SET @Products = ''

	SELECT 	
		@Products = @Products + Name + ', '
	FROM 
		Production.Product
	WHERE 
		YEAR(SellStartDate) = @Year
	ORDER BY 
		Name ASC

	SET @ProductCount = @@ROWCOUNT
	SET @ProductList = @Products

END


-- To Execute
EXEC spSellStartInYear 
	@Year = 2013


	
DECLARE @ProdNames VARCHAR(MAX)
DECLARE @Count INT

EXEC spSellStartInYear 
	@Year = 2013
	,@ProductList = @ProdNames OUTPUT
	,@ProductCount = @Count OUTPUT

SELECT @Count AS [Number of Products], @ProdNames AS [List of Products]



---------------------------------------------------------------------
-- Utilizing Stored Procedure Return Values
---------------------------------------------------------------------

USE AdventureWorks;
GO

ALTER PROC spSellStartInYear
	(
		@Year INT
	)
AS
BEGIN
	SELECT 	
		Name
	FROM 
		Production.Product
	WHERE 
		YEAR(SellStartDate) = @Year
	ORDER BY 
		Name ASC

	RETURN @@ROWCOUNT
END


-- To execute
DECLARE @Count INT

EXEC @Count  = spSellStartInYear @Year = 2013

SELECT @Count AS [Number of Products]

---------------------------------------------------------------------
-- Get the result of a return value
---------------------------------------------------------------------

DECLARE @Total INT

EXEC @Total = spSellStartInYear @Year = 2013

SELECT @Total AS [Number of Products]

