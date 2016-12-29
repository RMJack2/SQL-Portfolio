/*Here, I demonstrate the various ways to manipulate data within the rows of a table using the UPDATE, INSERT, DELETE, and 
SELECT statements*/

/*In this first example, I Insert one row into the Sales.ProductShippers table*/
SET IDENTITY_INSERT Sales.ProductShippers ON;
INSERT INTO Sales.ProductShippers (ProductShipperID, NameOfCompany, Phone)
 VALUES (4, N'Woodford Hardware', N'(567) 567-4456');
 SET IDENTITY_INSERT Sales.ProductShippers OFF;


/*In this next example, I demonstrate how to add multiple rows into a table at one time, */
SET IDENTITY_INSERT Sales.ProductShippers ON;
INSERT INTO Sales.ProductShippers (ProductShipperID, NameOfCompany, Phone)
 VALUES (5, N'Kreno Electrical Supply', N'(678) 567-6678'),
        (6, N'Kroger Electronics', N'(212) 778-5565'),
		(7, N'Wilson Plastics', N'(567) 978-7975'),
		(8, N'Johnson and Sons Bearings', N'(678) 567-6672')
 SET IDENTITY_INSERT Sales.ProductShippers OFF;


 /*Another option is the Insert/Select  statement, this can be used to populate one table with the query results of another 
 table. In this example, I create a table  called "dbo.ProductCategories" I then insert the new table with the rows from the 
 "Production.ProductCategories" table that already exists in the database*/

--First I create the new CustomerOrders table with the identical columns and thier data types
 IF OBJECT_ID('dbo.ProductCategories') IS NOT NULL
 DROP TABLE dbo.ProductCategories;

 CREATE TABLE dbo.ProductCategories(
       ProductCategoryID INT NOT NULL PRIMARY KEY,
	   CategoryName NVARCHAR(15) NOT NULL,
	   ProductDescription NVARCHAR(200) NOT NULL);

--This next step inserts data into the new table "dbo.ProductCategories" by way of an insert / select statement, in
--this case I insert the data based on a where clause that filters all rows based on a specific category name
INSERT INTO dbo.ProductCategories (ProductCategoryID, CategoryName, ProductDescription)

SELECT ProductCategoryID, CategoryName, ProductDescription
FROM Production.ProductCategories
WHERE CategoryName IN (N'Beverages', N'Condiments');

--In this example, I demonstrate the "delete" statement.

/*Here, I use the "delete statement" with a "where" clause in an effort to remove a row based on 
a partucular specification, this delete statement removes orders before July 4, 2006*/

DELETE FROM Sales.CustomerOrders
WHERE OrderDate < 20060704;


/*In this example, I remove data based on a join,his query joins the orders table 
and the customers table by way of the 'ON'
predicate that matches the orders customerID and the customers table customerID.
It filters for orders placed by customers from France and deletes orders based on
that specifiation.*/
DELETE FROM O
FROM dbo.Orders AS O
JOIN dbo.Customers AS C
ON O.custid = C.custid
WHERE C.country = N'France';




--Here, I use a subquery to remove data from one table based on a where clause imposed 
--on another table. The subquery searches for the city "Berlin" in the customers table,
--the where clause delete's order data in the Orders table based on the 
--matched customerID. 
DELETE FROM dbo.Orders
WHERE EXISTS 
        (SELECT *
		FROM dbo.Customers AS C
		WHERE Orders.Custid = C.Custid
		AND C.City = N'Berlin');


--Here, I demonstrate how to update a row, this code will 
--increase the unit price of an item by $10 based on the productID
UPDATE Sales.CustomerOrderDetails
  SET UnitPrice = UnitPrice + 10.00
WHERE ProductID = 11;

--In this example I update data based on two joined tables, the discount will be increased by 
-- 10% based on a where clause for a specific customerID via a match between the orderID's
--of both tables
UPDATE COD
  SET discount = discount + 0.10
  FROM Sales.CustomerOrderDetails AS COD
  JOIN Sales.CustomerOrders AS CO
  ON COD.OrderID = CO.OrderID
  WHERE CO.CustomerID = 20;


--Here, I perform an update but use a subquery to get my desired result 
--which is to increase the discount by 20% in the CustomerOrderDetails table
--based on the CustomerID of the CustomerOrders table.
--The subquery matches the inner and outer query based on the orderID's and 
-- filters based on the customerID of the CustomerOrders table
UPDATE Sales.CustomerOrderDetails
   SET discount = discount + 0.20
 WHERE EXISTS
          (SELECT *
		   FROM Sales.CustomerOrders AS CO
		   WHERE CO.OrderID = CustomerOrderDetails.OrderID AND CO.CustomerID = 18);


--Here, I demonstrate various examples of the "select" statement

--This first one is very basic and uses aliases to rename columns in the output.
--Here, I remane the UnitPrice and Qty columns

SELECT OrderID, ProductID, UnitPrice AS 'Price Per Unit', Qty AS 'Amount Ordered'
FROM Sales.CustomerOrderDetails; 


/*Here, I use a select statement to display only three columns in the CustomerOrder table
and display the month from the OrderDate column to emphasize the month the item 
was purchased*/
SELECT OrderID, AssociateID, MONTH(OrderDate) AS 'Month Ordered'
FROM Sales.CustomerOrders
GROUP BY OrderID, AssociateID, MONTH(OrderDate);

/*In this example I display columns from two different tables. The information from both 
tables are brought together based on the on the 'ON' predicate which bases the tables 
relationship between the CustomerID columns. This allows the select statement to have 
access across multiple tables*/
SELECT CO.OrderID, CO.OrderDate, CO.Freight,
       C.NameOfCompany, C.Country
FROM Sales.CustomerOrders AS CO
INNER JOIN Sales.Customers AS C
ON CO.CustomerID = C.CustomerID;












































  
    




