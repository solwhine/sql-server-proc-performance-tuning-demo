CREATE OR ALTER PROCEDURE calculateSalesTests.[test usp_calculateSales returns correct count and summary]
AS
BEGIN
	EXEC tsqlt.FakeTable @TableName = N'dbo.Sales';
	EXEC tsqlt.FakeTable @TableName = N'dbo.Products';

	INSERT INTO dbo.Products(ProductID,Price)
	VALUES (101,100.00),(102,150.00);

	INSERT INTO dbo.Sales (ProductID,Quantity,DiscountPercent,SaleDate)
	VALUES (101, 3, 0.1, DATEADD(DAY,-300,GETDATE())),
			(102, 2, 0.2, DATEADD(DAY,-200,GETDATE())),
			(101, 1, 0.0, DATEADD(DAY,-500,GETDATE()));

	DECLARE @TotalProductsSold INT;

	EXEC dbo.usp_calculateSales @TotalProductsSold = @TotalProductsSold OUTPUT;

	--Assert
	EXEC tSQLt.AssertEquals @Expected=2, @Actual=@TotalProductsSold

END
GO