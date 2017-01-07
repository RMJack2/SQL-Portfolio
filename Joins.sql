--JOINS--

/*This is an example of an "Inner Join", I filter the rows based on th "ON" predicete
that dictates what will be matched between the two tables. In this example, the CustomerID's
on the "Sales.CustomerOrder" table is matched with the CustomerID's on the "Sales.Customer" table
and returns all coresponding rows from each side*/
SELECT CO.OrderID, CO.OrderDate, CO.ProductShipperID,
       C.CustomerID, C.ContactName, C.TitleOfContact
FROM Sales.CustomerOrders AS CO
     INNER JOIN Sales.Customers AS C
	 ON C.CustomerID = CO.CustomerID;

/*This example demonstrates the use of "Outer Joins", the types are: Left, Right and Full.*/

/*This example is a "Left Outer Join", it will return 
data from the nonpreserved side even if there is no match, in this example, 
all of the information will appear in the output. However, the orderID will show "NULL" for any 
order not yet made*/
SELECT C.CustomerID, C.NameOfCompany, C.Address, C.City, C.Region, C.ZipCode,
       CO.OrderID
FROM Sales.Customers AS 
LEFT OUTER JOIN Sales.CustomerOrders AS CO
ON C.CustomerID = CO.CustomerID;


/*Unlike a "Left Outer Join", when a "Right Outer Join" is used if no match is located based on the "ON" predicate, no
information for that row is returned.*/
SELECT C.CustomerID, C.NameOfCompany, C.Address, C.City, C.Region, C.ZipCode,
       CO.OrderID
FROM Sales.Customers AS C
RIGHT OUTER JOIN Sales.CustomerOrders AS CO
ON C.CustomerID = CO.CustomerID;

/*Here, I have a Full Outer Join, this type of join return all the rows from all tables involved, we basically get the result of LEFT and 
RIGHT JOINS*/
SELECT C.CustomerID, C.NameOfCompany, C.Address, C.City, C.Region, C.ZipCode,
       CO.OrderID
FROM Sales.Customers AS C
FULL OUTER JOIN Sales.CustomerOrders AS CO
ON C.CustomerID = CO.CustomerID;












       


