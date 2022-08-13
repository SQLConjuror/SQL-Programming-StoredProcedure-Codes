---------------------------------------------------------------------
-- Defining variables
---------------------------------------------------------------------
USE AdventureWorks2017
GO

-- Union
SELECT 
	TransactionID ,TransactionDate, 'Transactions' AS [Type]
FROM 
	Production.TransactionHistory
WHERE
	TransactionDate >= '2012-05-31 00:00:00.000'

UNION ALL  
  
SELECT  
	SalesOrderID, OrderDate, 'SalesOrders'
FROM 
	Sales.SalesOrderHeader
WHERE 
	OrderDate >= '2012-05-31 00:00:00.000'


---------------------------------------------------------------------
-- Variable Declaration
---------------------------------------------------------------------

USE AdventureWorks2017
GO

DECLARE @Date DATETIME

SELECT 
	TransactionID ,TransactionDate, 'Transactions' AS [Type]
FROM 
	Production.TransactionHistory
WHERE
	TransactionDate >= '2012-05-31 00:00:00.000'

UNION ALL  
  
SELECT  
	SalesOrderID, OrderDate, 'SalesOrders'
FROM 
	Sales.SalesOrderHeader
WHERE 
	OrderDate >= '2012-05-31 00:00:00.000'


---------------------------------------------------------------------
-- Referencing a Variable in a Query
---------------------------------------------------------------------
USE AdventureWorks2017
GO

DECLARE @Date DATETIME

SET  @Date = '2014-05-31'

 
SELECT 
	TransactionID ,TransactionDate, 'Transactions' AS [Type]
FROM 
	Production.TransactionHistory
WHERE
	TransactionDate >= @Date

UNION ALL

SELECT  
	SalesOrderID, OrderDate, 'SalesOrders'
FROM 
	Sales.SalesOrderHeader
WHERE 
	OrderDate >= @Date

---------------------------------------------------------------------
-- Query Results Stored in Variables
---------------------------------------------------------------------
USE AdventureWorks
GO

DECLARE @Date DATETIME
DECLARE @NumTran INT -- typed

SET  @Date = '2014-05-01'
SET @NumTran = (SELECT COUNT(*) FROM Production.TransactionHistory WHERE >= @Date)     --typed

SELECT 
	TransactionID ,TransactionDate, 'Transactions'
FROM 
	Production.TransactionHistory
WHERE
	TransactionDate >= @Date

UNION ALL

SELECT  
	SalesOrderID, OrderDate, 'SalesOrders'
FROM 
	Sales.SalesOrderHeader
WHERE 
	OrderDate >= @Date


---------------------------------------------------------------------
-- Querying the Value in a Variable
---------------------------------------------------------------------

USE AdventureWorks
GO

DECLARE @Date DATETIME
DECLARE @NumTran INT
DECLARE  @NumSales INT

SET @Date = '2014-05-31'
SET @NumTran = (SELECT COUNT(*) FROM Production.TransactionHistory WHERE TransactionDate  >= @Date) 
SET @NumSales = (SELECT COUNT(*) FROM Sales.SalesOrderHeader WHERE OrderDate >= @Date)


SELECT 'Number of Transactions', @NumTran  
UNION
SELECT 'Number of Sales', @NumSales

SELECT 
	TransactionID ,TransactionDate, 'Transactions' AS [Type]
FROM 
	Production.TransactionHistory
WHERE
	TransactionDate >= @Date

UNION ALL

SELECT  
	SalesOrderID, OrderDate, 'SalesOrders'
FROM 
	Sales.SalesOrderHeader
WHERE 
	OrderDate >= @Date

---------------------------------------------------------------------
-- Showing the value of variable in messages tab
---------------------------------------------------------------------
USE AdventureWorks
GO

DECLARE @Date DATETIME
DECLARE @NumTran INT
DECLARE @NumSales INT

SET  @Date = '2012-01-01'
SET @NumTran = (SELECT COUNT(*) FROM Production.TransactionHistory WHERE TransactionDate >= @Date)
SET @NumSales = (SELECT COUNT(*) FROM Sales.SalesOrderHeader WHERE OrderDate  >= @Date)

PRINT @NumTran     
PRINT @NumSales

SELECT 
	TransactionID ,TransactionDate, 'Transactions'
FROM 
	Production.TransactionHistory
WHERE
	TransactionDate >= @Date

UNION ALL

SELECT  
	SalesOrderID, OrderDate, 'SalesOrders'
FROM 
	Sales.SalesOrderHeader
WHERE 
	OrderDate >= @Date


---------------------------------------------------------------------
-- Referring a Record into a Set of Variables
---------------------------------------------------------------------

USE AdventureWorks;
GO

SELECT TOP 1
	so.SalesOrderID,
	p.Name
	,so.OrderDate
FROM	
	Sales.SalesOrderHeader so  
	INNER JOIN Sales.SalesOrderDetail sod ON so.SalesOrderID = sod.SalesOrderID
	INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE	
	so.OrderDate >= '2012-01-01'
ORDER BY
	so.OrderDate DESC

---------------------------------------------------------------------
-- Gathering values in variables 
---------------------------------------------------------------------

USE AdventureWorks2017;
GO

DECLARE @ProdLis VARCHAR(MAX)
SET @ProdList = ''  --type

SELECT
	@ProdList = @ProdList + Name + CHAR(10)  
FROM	
	Production.Product
WHERE
	YEAR(SellStartDate) = 2008

PRINT @ProdList --type

---------------------------------------------------------------------
-- What are Global Variables
---------------------------------------------------------------------

SELECT @@SERVERNAME

SELECT @@VERSION


SELECT * FROM Sales.SalesOrderHeader
SELECT @@ROWCOUNT


