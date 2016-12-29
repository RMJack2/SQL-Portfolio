--Table Valued Functions

/*This TVF allows the user to simply imput the "OrderID" and the function extracts all necessary informaiton based on the query 
in the body of the function*/
IF OBJECT_ID('dbo.ExtractCustOrderDetail') IS NOT NULL
DROP FUNCTION dbo.ExtractCustOrderDetail;
GO

CREATE FUNCTION dbo.ExtractCustOrderDetail(
     @OrderID AS INT) RETURNS TABLE 
AS

RETURN 
  SELECT CO.OrderID, CO.OrderDate, CO.ShippedDate,
         COD.UnitPrice, COD.Qty, 
		 PD.ProductName, PD.Discontinued
   FROM Sales.CustomerOrders AS CO
        INNER JOIN Sales.CustomerOrderDetails AS COD
		ON CO.OrderID = COD.OrderID
		INNER JOIN Production.ProductDetails AS PD
		ON COD.ProductID = PD.ProductID
		WHERE CO.OrderID = @OrderID;
GO 


SELECT *
FROM dbo.ExtractCustOrderDetail (10248) AS O;









