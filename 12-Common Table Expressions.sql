---------------------------------------------------------------------
-- Basic CTE Construction
---------------------------------------------------------------------

WITH SoldEarly AS
(
	SELECT
		Name
		,SellStartDate
		, ListPrice
	FROM 
		Production.Product
	WHERE
		SellStartDate < '2012-01-01'
)
SELECT 
	*
FROM 
	SoldEarly
WHERE
	ListPrice > 200

---------------------------------------------------------------------
-- Computing Aggregates using CTEs
---------------------------------------------------------------------

SELECT 
	SalesPersonID
	,COUNT(*)  AS [NumberOfItemsSold]
FROM 
	 [Sales].[Store]
GROUP BY 
	SalesPersonID




WITH ItemCounts AS  
(
	SELECT 
		SalesPersonID
		,COUNT(*)  AS [NumberOfItemsSold]    
	FROM 
		 [Sales].[Store]
	GROUP BY 
		SalesPersonID
)
SELECT
	AVG(NumberOfItemsSold) 
FROM 
	ItemCounts


---------------------------------------------------------------------
-- Labelling CTE columns
---------------------------------------------------------------------


WITH ItemCounts AS  
(
	SELECT 
		SalesPersonID
		,COUNT(*)  AS [NumberOfItemsSold]    
	FROM 
		 [Sales].[Store]
	GROUP BY 
		SalesPersonID
)
SELECT
	AVG(NumberOfItemsSold) 
FROM 
	ItemCounts


-- Next

WITH ItemCount (SalesPerson, NumberOfItemsSold) AS  
(
	SELECT 
		SalesPersonID
		,COUNT(*) 
	FROM 
		 [Sales].[Store]
	GROUP BY 
		SalesPersonID
)
SELECT
	SalesPerson
	,NumberOfItemSold
FROM 
	ItemCount

-- If you  labelled a certain number of columns in the definition of the CTE, you need to make sure that you select the same number of columns in your select clause



---------------------------------------------------------------------
-- Constructing muliple CTEs
---------------------------------------------------------------------

WITH SoldEarly AS
(
	SELECT
		Name
		,SellStartDate
	FROM 
		Production.Product
	WHERE
		SellStartDate < '2011-01-01'
),
SoldRecently AS
(
	SELECT
		Name
		,SellStartDate
	FROM 
		Production.Product
	WHERE
		SellStartDate >= '2011-01-01'
 )
SELECT
	*
FROM
	SoldEarly AS se
	FULL JOIN SoldRecently AS sr
		ON se.Name=sr.Name

