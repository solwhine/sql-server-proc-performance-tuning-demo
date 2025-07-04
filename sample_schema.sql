USE tempdb

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	ProductName NVARCHAR(50),
	Category NVARCHAR(50),
	Price MONEY
	);

CREATE TABLE Sales (
	SaleID INT PRIMARY KEY,
	ProductID INT,
	SaleDate DATE,
	Quantity INT,
	DiscountPercent FLOAT
	);

INSERT INTO Products
	SELECT TOP 5000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
	CONCAT('Product_' ,ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
	CASE WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 5 =0 THEN 'Electronics'
	ELSE 'General' END,
	ABS(CHECKSUM(NEWID())) % 500 + 100
	FROM sys.objects a CROSS JOIN sys.objects b;

WITH SeedRows AS (
	SELECT TOP (100000)
		ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
	FROM sys.objects a
	CROSS JOIN sys.objects b
	CROSS JOIN sys.objects c
)
INSERT INTO Sales (SaleID, SaleDate, ProductID, Quantity, DiscountPercent)
SELECT
	rn,
	DATEADD(DAY, -rn % 730, GETDATE()),         
	1 + rn % 1000,                              
	1 + rn % 10,                                
	CAST((rn % 30) / 100.0 AS DECIMAL(5,2))      
FROM SeedRows;	


