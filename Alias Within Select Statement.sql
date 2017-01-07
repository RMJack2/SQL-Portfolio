--This code demonstrates how to use aliases inside select statements to
--rename columns
USE VWRProduction;
GO

SELECT OrderID, CustomerID AS 'Customer Identification' , AssociateID, OrderDate AS 'Product Orderdate', 
       ShippedDate AS 'Date Shipped'
FROM Sales.CustomerOrders
ORDER BY OrderID;
