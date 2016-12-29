-- In this example, I create a CTE that extracts order and product 
--information based on country
WITH FranceCust AS (
SELECT C.Country,
       CO.OrderID, CO.CustomerID, CO.OrderDate,
       COD.ProductID, COD.Qty,
	   PD.UnitPrice, PD.Discontinued
FROM Sales.Customers AS C
     INNER JOIN  Sales.CustomerOrders AS CO
	 ON C.CustomerID = CO.CustomerID
     INNER JOIN Sales.CustomerOrderDetails AS COD
     ON CO.OrderID = COD.OrderID
	 INNER JOIN Production.ProductDetails AS PD
	 ON COD.ProductID = PD.ProductID
	 WHERE C.Country = N'France')

SELECT * FROM FranceCust;

--In this CTE example I assign column aliases

WITH SalesInfo AS (
SELECT CONCAT(A.FirstName, ' ', A.LastName) AS FullName,
       CO.OrderDate AS DateOfOrder, PS.NameOfCompany AS ShippedFrom
       FROM HR.Associates AS A
	   INNER JOIN Sales.CustomerOrders AS CO
	   ON A.AssociateID = CO.AssociateID
	   INNER JOIN Sales.ProductShippers AS PS
	   ON CO.ProductShipperID = PS.ProductShipperID)
SELECT FullName
FROM SalesInfo
GROUP BY FulllName;

--Here, I have an example of multiple CTE's seperated by commas under the same WITH statement.
--The second CTE references the first and the outer query refers to all defined CTE's
WITH ProductionOrders1 AS
(

   SELECT YEAR(OrderDate) AS YearOrdered, CustomerID
   FROM Sales.CustomerOrders
),
ProductionOrders2 AS
(
   SELECT YearOrdered, COUNT(DISTINCT CustomerID) AS NumberOfCustomers
   FROM ProductionOrders1
   GROUP BY YearOrdered
)
SELECT YearOrdered, NumberOfCustomers
FROM ProductionOrders2
WHERE NumberOfCustomers < 80;


  


  





	  

