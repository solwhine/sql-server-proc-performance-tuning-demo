USE tempdb
GO
CREATE OR ALTER PROCEDURE usp_calculateSales @TotalProductsSold INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;

		DECLARE @Summary TABLE (
		ProductID INT,
		TotalQuantity INT,
		TotalRevenue MONEY
		);

		INSERT INTO @Summary
		SELECT s.ProductID,
		SUM(s.Quantity),
		SUM(s.Quantity * (p.Price - (p.Price * s.DiscountPercent)))
		FROM Sales s INNER JOIN Products p 
		ON s.ProductID=p.ProductID
		WHERE s.SaleDate >  DATEADD(YEAR,-1,GETDATE())
		GROUP BY s.ProductID

		SELECT @TotalProductsSold = COUNT(1) FROM @Summary;

		--returning result
		SELECT * FROM @Summary ORDER BY TotalRevenue DESC;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION;

		DECLARE @errmsg NVARCHAR(4000),
				@procname SYSNAME,
				@finalmsg NVARCHAR(4000)  

				SET @errmsg = ERROR_MESSAGE();
				SET @procname = ISNULL(ERROR_PROCEDURE(),OBJECT_NAME(@@PROCID));
				SET @finalmsg = CONCAT('Error occurred in procedure: ', @procname, '| Details: ',@errmsg);

		THROW 50002, @finalmsg, 1;
	END CATCH
END
GO

