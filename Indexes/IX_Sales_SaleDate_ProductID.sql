CREATE NONCLUSTERED INDEX IX_Sales_SaleDate_ProductID
ON Sales (SaleDate, ProductID)
INCLUDE(Quantity,DiscountPercent);
GO