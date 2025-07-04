DECLARE @totalProducts INT;

EXEC usp_calculateSales @TotalProductsSold = @totalProducts OUTPUT

PRINT 'total unique products sold: ' + CAST(@totalProducts AS VARCHAR);
IF @totalProducts < 1 
	RAISERROR('No product was sold in the last year, verify the data',16,1)