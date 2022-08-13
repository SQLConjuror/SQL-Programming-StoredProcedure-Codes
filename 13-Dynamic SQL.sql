---------------------------------------------------------------------
-- Dynamic SQL Definition
---------------------------------------------------------------------

USE AdventureWorks
GO

-- Utilizaing Dynamic SQL

SELECT * FROM Production.Product

---------------------------------------------------------------------
-- Utilizing EXECUTE for Dynamic SQL
---------------------------------------------------------------------

USE AdventureWorks
GO

-- Using Dynamic SQL

EXEC ('SELECT * FROM Production.Product')

---------------------------------------------------------------------
-- Utilizing system stored procedure
---------------------------------------------------------------------

USE AdventureWorks;
GO

-- Implementing Dynamic SQL

EXEC sp_executesql N'SELECT * FROM Production.Product'  

---------------------------------------------------------------------
-- Linking a dynamic SQL string
---------------------------------------------------------------------

-- SQL string concatenation

N'SELECT * FROM Production.Product'


-- Concatenating a SQL String

DECLARE @TableName NVARCHAR(128)
DECLARE @SQLString NVARCHAR(MAX)

SET @TableName = N' Production.Product'

SET @SQLString = 'SELECT * FROM ' + @TableName

EXEC sp_executesql @SQLString

-- or EXEC (@SQLString)



-- Concatenating a SQL String

DECLARE @TableName NVARCHAR(128)
DECLARE @SQLString NVARCHAR(MAX)

SET @TableName = N' Production.ProductCategory'

SET @SQLString = 'SELECT * FROM ' + @TableName

EXEC sp_executesql @SQLString

-- or EXEC (@SQLString)

---------------------------------------------------------------------
-- Number Concatenation
---------------------------------------------------------------------

-- Starting point

DECLARE @Number INT
DECLARE @SQLString NVARCHAR(MAX)

N'SELECT TOP 15 * FROM Production.Product ORDER BY SellStartDate DESC'

EXEC sp_executesql @SQLString

-- Concatenating a SQL String

-- Number Concatenation

DECLARE @Number INT
DECLARE @NumberString NVARCHAR(6)
DECLARE @SQLString NVARCHAR(MAX)

SET @Number = 15
SET @NumberString = CAST(@Number AS NVARCHAR(6))

SET @SQLString = N'SELECT TOP ' + @NumberString + ' * FROM Production.Product ORDER BY SellStartDate DESC'

EXEC sp_executesql @SQLString

-- or EXEC (@SQLString)

---------------------------------------------------------------------
-- Constructing a stored procedure
---------------------------------------------------------------------

-- Creating stored procedures

CREATE PROC spTableVariable 
(
	@TName NVARCHAR(128)
)
AS
BEGIN
	
	DECLARE @SQLString NVARCHAR(MAX)

	SET @SQLString = N'SELECT * FROM ' + @TName

	EXEC sp_executesql @SQLString

END


-- To Execute

EXEC spTableVariable 'Production.Product' 

EXEC spTableVariable  

---------------------------------------------------------------------
-- Appending several parameters
---------------------------------------------------------------------

-- Creating stored procedures


CREATE PROC spTableVariable 
(
	@TName NVARCHAR(128)
)
AS
BEGIN
	
	DECLARE @SQLString NVARCHAR(MAX)

	SET @SQLString = N'SELECT * FROM ' + @TName

	EXEC sp_executesql @SQLString

END




-- Alter stored procedure

ALTER PROC spTableVariable 
(
	@TName NVARCHAR(128)
	,@Number INT
)
AS
BEGIN
	
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @NumberStr NVARCHAR(6)

	SET @NumberStr = CAST(@Number AS NVARCHAR(6))

	SET @SQL = N'SELECT TOP ' + @NumberStr + ' * FROM ' + @TName

	EXEC (@SQL)

END



-- To Execute

EXEC spTableVariable 'Production.Product', 10

EXEC spTableVariable 'HumanResources.Employee', 5

---------------------------------------------------------------------
-- Utilizing the IN Operator
---------------------------------------------------------------------
SELECT *
FROM Production.Product
WHERE YEAR(SellStartDate) IN ('2008', '2011', '2012')
ORDER BY SellStartDate



-- The IN operator within the Dynamic SQL 

USE AdventureWorks
GO

CREATE PROC spSellYears
(
	@YearSeries NVARCHAR(MAX)
)
AS
BEGIN
	
	DECLARE @SQL NVARCHAR(MAX)

	SET @SQL = 
		N'SELECT *
		FROM Production.Product
		WHERE YEAR(SellStartDate) IN (' + @YearSeries + N')
		ORDER BY SellStartDate'

		EXEC sp_executesql @SQL

END

-- N' is to declare that it unicode string



-- To Test
EXEC spSellYears '2008, 2011, 2012'


---------------------------------------------------------------------
-- Parameters of sp_executesql
---------------------------------------------------------------------


EXEC sp_executesql	
	N'SELECT e.BusinessEntityID, p.FirstName, p.LastName
	        FROM HumanResources.Employee AS e
			INNER JOIN Person.Person AS p ON p.BusinessEntityID = e.BusinessEntityID
			WHERE e.BusinessEntityID > @BusinessEID
			AND p.FirstName LIKE @FirstLetter + ''%'''
			,N'@BusinessEID INT, @FirstLetter VARCHAR(5)'
			,@BusinessEID = 150
			,@FirstLetter = 'A'

