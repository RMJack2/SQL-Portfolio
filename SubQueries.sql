/*Here, I have a "Contained Subquery", these types of subqueries are independent of the 
outer query they are associated with. Here, the subquery assigns 
the maximum order date to the "@OrderDate" variable. Then the outer query
assigns the variable value to the "OrderDate" in the select statement
in the outer query.*/

DECLARE @OrderDate AS DATETIME = 
   (SELECT MAX(OrderDate)
    FROM Sales.CustomerOrders);
	
SELECT OrderID, OrderDate, AssociateID, CustomerID
FROM Sales.CustomerOrders 
WHERE OrderDate = @OrderDate;

/*In this example, I demonstrate a self-contained subquery that returns 
more than one value, unlike the one above that is scalar and only returns
one value. In this example, I return the AssociateID, OrderDate, CustomerID,
and OrderID based on the subquery that searches for a first name in the 
HR.Associates table that starts with the lertter "P". The outer query 
uses the IN predicate to base the outer select statement on the informaiton
extractd by the inner query.*/
SELECT AssociateID, OrderDate, CustomerID, OrderID
FROM Sales.CustomerOrders
WHERE AssociateID IN (SELECT A.AssociateID
                      FROM HR.Associates AS A
					  WHERE A.FirstName LIKE N'P%');

/*In another example of a multi-valued subquery, I write this one to extract 
orders placed by customers from a particulr country. This code pulls customers
whose OrderID's are associated with customers from Austria.*/
SELECT OrderID, CustomerID, OrderDate, AssociateID
FROM Sales.CustomerOrders
WHERE CustomerID IN (SELECT C.CustomerID
                     FROM Sales.Customers AS C
					 WHERE C.Country = N'Austria');

/*Here, I demonstrate the use of the 'Correlated Subquery', these types of queries are dependent on the outer query. In this code, the outer 
query is against the CustomerOrders table aliased as CustomerDetails1, what it does is filter the OrderID's thats equal to the value put out
by the subquery. Put simply, for each row in the CustomerDetails1 table, the subquery will return the maximum OrderID for the current customer.
When and if the OrderID in the subquery match with the OrderID in the outer query, the OrderID in CustomerDetails1 is the max for 
that customer.*/
SELECT OrderID, CustomerID, AssociateID, OrderDate
FROM Sales.CustomerOrders AS CustomerDetails1
WHERE OrderID = (SELECT MAX(CustomerDetails2.OrderID)
                 FROM Sales.CustomerOrders AS CustomerDetails2
				 WHERE CustomerDetails1.OrderID = CustomerDetails2.OrderID);
				 






					  
 