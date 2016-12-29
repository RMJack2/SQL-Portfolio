--This code demonstrates the "Group By" & "Having"clause.

/*In this example, I demonstrate the 'GROUP BY' clause, it groups the output by productID*/
SELECT ProductID, MAX(UnitPrice)
FROM Production.ProductDetails
WHERE ProductSupplierID = 2 
GROUP BY ProductID;

--In this example, I demonstrate the use of the "having clause" as well as "group by". This code displays the results by grouping 
--the UnitPrice and ProductID where the UnitPrice is either $22.00 and $17.00.
SELECT UnitPrice, ProductID
FROM Production.ProductDetails
GROUP BY UnitPrice, ProductID
HAVING UnitPrice IN (22.00, 17.00);

/*Here, I use the "WHERE", "GROUP BY", and "HAVING" clauses, these clauses extract and display data based on specific 
needs. The WHERE clause extacts data based on a specific last names. The GROUP BY arrganges data based on the 
colmns specified and HAVING clause specifies results based on a specific amount of orders*/
SELECT A.FirstName, A.LastName , COUNT(CO.OrderID) AS NumberOfItemsOrdered
FROM HR.Associates AS A
INNER JOIN Sales.CustomerOrders AS CO
ON A.AssociateID = CO.AssociateID
WHERE LastName = N'Cameron' OR LastName = N'Williams'
GROUP BY FirstName, LastName
HAVING COUNT(CO.OrderID) > 50;






