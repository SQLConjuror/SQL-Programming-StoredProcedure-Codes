---------------------------------------------------------------------
-- Temporary table creation - technique 1
---------------------------------------------------------------------
SELECT 
	Name
	,SellStartDate
INTO #TempName
FROM	
	[Production].[Product]
WHERE
	Name LIKE '%Thin%'

SELECT * FROM #TempName



---------------------------------------------------------------------
-- Temporary table creation - technique 2
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
-- Temporary Tables Location
---------------------------------------------------------------------

CREATE TABLE #TempName  
(
	Name VARCHAR(MAX)
	,SellStartDate DATETIME
)


---------------------------------------------------------------------
-- Temporary Table Scope
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
-- Global temporary tables
---------------------------------------------------------------------

IF OBJECT_ID('tempdb..##TempName') IS NOT NULL
	DROP TABLE ##TempName;
GO

CREATE TABLE ##TempName
(
	Name VARCHAR(MAX)
	,SellStartDate DATETIME
)
INSERT INTO ##TempName
SELECT 
	Name  
	,SellStartDate
FROM	
	[Production].[Product]
WHERE
	Name LIKE '%Thin%'

SELECT * FROM ##TempName















