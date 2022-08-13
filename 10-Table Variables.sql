---------------------------------------------------------------------
-- Temporary Tables Review
---------------------------------------------------------------------

IF OBJECT_ID('tempdb..#TempProd') IS NOT NULL
	DROP TABLE #TempProd;
GO

CREATE TABLE #TempProd
(
	Name VARCHAR(MAX)
	,SellStartDate DATETIME
)

INSERT INTO #TempProd
SELECT 
	Name
	,SellStartDate
FROM	
	[Production].[Product]
WHERE
	SellStartDate <  '2012-01-01'

SELECT * FROM #TempProd


---------------------------------------------------------------------
-- Table Variable Declaration
---------------------------------------------------------------------

USE AdventureWorks

DECLARE @TempProducts TABLE
(
	Name VARCHAR(MAX)
	,SellStartDate DATETIME
)



---------------------------------------------------------------------
-- Pushing Data into a Table Variable
---------------------------------------------------------------------


 DECLARE @TempProducts TABLE
(
	Name VARCHAR(MAX)
	,SellStartDate DATETIME
)
INSERT INTO @TempProducts 
SELECT 
	Name
	,SellStartDate
FROM	
	Production.Product
WHERE
	SellStartDate <  '2012-01-01'


SELECT * FROM @TempProducts 

---------------------------------------------------------------------
-- Table variables LifeCycle
---------------------------------------------------------------------

IF OBJECT_ID('tempdb..#TempName') IS NOT NULL
	DROP TABLE #TempName;  
GO

CREATE TABLE #TempName  
(
	Name VARCHAR(MAX)
	,SellStartDate DATETIME
)
INSERT INTO #TempName  
SELECT 
	Name
	,SellStartDate
FROM	
	[Production].[Product]
WHERE
	Name LIKE '%Thin%'

SELECT * FROM #TempName

---------------------------------------------------------------------
-- Drawbacks of Table Variables
---------------------------------------------------------------------

USE AdventureWorks
GO

SELECT 
	Name
	,SellStartDate
INTO
	#TempProducts
FROM	
	[Production].[Product]
WHERE
	SellStartDate <  '2012-01-01'

SELECT * FROM #TempProducts



-- Table Variable


SELECT 
	Name
	,SellStartDate
INTO
	@TempProducts
FROM	
	[Production].[Product]
WHERE
	SellStartDate <  '2012-01-01'

SELECT * FROM @TempProducts




