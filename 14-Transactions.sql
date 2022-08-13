---------------------------------------------------------------------
-- Define Transactions
---------------------------------------------------------------------
-- Adding new records
INSERT INTO  Orders.Customers ( CustName, CustStreet, CityStateID,  SalutationID)
VALUES ( 'Bob Jones','77 Somewhere Street', 3, 3)

-- Update existing records
UPDATE Orders.Orders 
SET OrderRequestedDate = '30000101'
WHERE OrderID = 1;

  
select * from Orders.Orders 

select * from Orders.Customers


---------------------------------------------------------------------
-- Begin a transaction
---------------------------------------------------------------------

BEGIN TRANSACTION -- BEGIN TRAN

SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee WHERE BusinessEntityID = 7

UPDATE HumanResources.Employee
SET JobTitle = 'Data Scientist'
WHERE BusinessEntityID = 7

SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee WHERE BusinessEntityID = 7

COMMIT -- or COMMIT TRAN, or COMMIT TRANSACTION



---------------------------------------------------------------------
-- Commit Transactions
---------------------------------------------------------------------

BEGIN TRANSACTION -- BEGIN TRAN

UPDATE HumanResources.Employee
SET JobTitle = 'Data Scientist'
WHERE BusinessEntityID = 7

SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee WHERE BusinessEntityID = 7

COMMIT -- or COMMIT TRAN, or COMMIT TRANSACTION



---------------------------------------------------------------------
-- Rollback transactions
---------------------------------------------------------------------

BEGIN TRANSACTION -- BEGIN TRAN

UPDATE HumanResources.Employee
SET JobTitle = 'DevOps Engineer'
WHERE BusinessEntityID = 268

SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee WHERE BusinessEntityID = 268

ROLLBACK TRANSACTION

SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee WHERE BusinessEntityID = 268


---------------------------------------------------------------------
-- Naming  transactions
---------------------------------------------------------------------
BEGIN TRANSACTION UpdateJobTitle

UPDATE HumanResources.Employee
SET JobTitle = 'DevOps Engineer'
WHERE BusinessEntityID = 268

COMMIT TRAN UpdateJobTitle


---------------------------------------------------------------------
-- Utilizing IIF statements to commit or rollback
---------------------------------------------------------------------

-- Verifying that an object exists
-- The following example checks for the existence of a specified table by verifying that the table has an object ID. If the table exists, it is deleted. 
-- If the table does not exist, the DROP TABLE statement is not executed.

-- Create test table
IF OBJECT_ID(N'dbo.books', N'U') IS NOT NULL  
   DROP TABLE dbo.books;  
GO

CREATE TABLE dbo.books
(
	id INT IDENTITY (1,1)
	,book_name VARCHAR(100) NOT NULL
	,sold_copies INT NOT NULL
);

-- Insert Records
INSERT INTO dbo.books (book_name, sold_copies) VALUES 
('book_1', 10),
('book_2', 20),
('book_3', 30),
('book_4', 40),
('book_5', 50);

-- Check data
SELECT * FROM dbo.books;

---------------------------------------------------------------------

-- Conditionally committing or rolling back

DECLARE @BookName INT

BEGIN TRAN AddBook

INSERT INTO dbo.books (book_name, sold_copies)
VALUES ('book_6', 60)

---------------------------------------------------------------------
-- Parameters of sp_executesql
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Parameters of sp_executesql
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Parameters of sp_executesql
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Parameters of sp_executesql
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Parameters of sp_executesql
---------------------------------------------------------------------
