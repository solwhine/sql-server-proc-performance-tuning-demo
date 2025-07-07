USE tempdb
GO
CREATE OR ALTER PROCEDURE usp_calculateSales @TotalProductsSold INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION;

		--SARGable filter variable
		DECLARE @startDate DATE = DATEADD(YEAR,-1,CAST(GETDATE() AS DATE));

		--usage of temp table instead of table variable
		CREATE TABLE #Summary (
		ProductID INT,
		TotalQuantity INT,
		TotalRevenue MONEY
		);

		INSERT INTO #Summary (ProductID, TotalQuantity, TotalRevenue)
		SELECT s.ProductID,
		SUM(s.Quantity),
		SUM(CAST(s.Quantity * p.Price * (1 - s.DiscountPercent) AS MONEY)) AS TotalRevenue
		FROM Sales s INNER JOIN Products p 
		ON s.ProductID=p.ProductID
		WHERE s.SaleDate > @startDate
		GROUP BY s.ProductID

		SELECT @TotalProductsSold = COUNT(1) FROM #Summary;

		--returning result
		SELECT * FROM #Summary ORDER BY TotalRevenue DESC;

		DROP TABLE #Summary

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
