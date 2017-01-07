

--Here, I demonstrate the use of a derived table, this is basically a table sub query. 
--This derived table extracts the number of orders by year.
SELECT YearOrdered, COUNT(DISTINCT OrderID) AS NumberOfOrders
FROM (SELECT YEAR(OrderDate) AS YearOrdered, OrderID
      FROM Sales.CustomerOrders) AS OrderInfo
GROUP BY YearOrdered;

--In this example, I use a nested derived table.
SELECT YearOrdered, NumberOfOrders
FROM (SELECT YearOrdered, COUNT(DISTINCT OrderID) AS NumberOfOrders
      FROM (SELECT YEAR(OrderDate) AS YearOrdered, OrderID
      FROM Sales.CustomerOrders) AS TableExtract1
GROUP BY YearOrdered) AS TableExtract2
WHERE NumberOfOrders > 150;


--In this example, I use multple derived tables, however they are based on one 
--query. I use the same table in a join in order to compare orders based on years and then extract if there has been 
--any growth.
SELECT CUR.YearOrdered,
  CUR.NumberOfOrders AS CurrentNumberOfOrders, 
  PREV.NumberOfOrders AS PreviousNumberOfOrders,
  CUR.NumberOfOrders - PREV.NumberOfOrders AS OrderGrowth
FROM (SELECT YEAR(OrderDate) AS YearOrdered,
       COUNT(DISTINCT OrderID) AS NumberOfOrders
	   FROM Sales.CustomerOrders
	   GROUP BY YEAR(OrderDate)) AS CUR
LEFT OUTER JOIN (SELECT YEAR(OrderDate) AS YearOrdered,
                  COUNT(DISTINCT OrderID) AS NumberOfOrders 
				  FROM Sales.CustomerOrders
				  GROUP BY YEAR(OrderDate)) AS PREV
				  ON CUR.YearOrdered = PREV.YearOrdered + 1;



	    
       


