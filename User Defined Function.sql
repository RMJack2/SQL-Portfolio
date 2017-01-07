/*Here, I denonstrate the use of a scalar user defined function, which 
menas that it takes a single input value and returns a single 
data value. This UDF accepts an orderid, and returns the order date that 
corresponds to the orderid provided by the user.*/
IF OBJECT_ID('dbo.UDFCustordersByDate') IS NOT NULL
DROP FUNCTION dbo.UDFCustordersByDate
GO

CREATE FUNCTION dbo.UDFCustordersByDate(

    @OrderID INT) 
	
	RETURNS TABLE 
	AS 
	RETURN 
	   (SELECT OrderDate
	   FROM Sales.CustomerOrders
	   WHERE OrderID = @OrderID);

SELECT *
FROM dbo.UDFCustordersByDate(10248); --this is the information the user supplies

/*Here, I have an inline table valued function that extracts the necessary data based on the body of the 
function. The user simply needs to input the CustomerID and the function pulls the data pertaining 
to that cutomer. Here, I used the UDF to extract the necessary informaiton for CustomerID '5'.*/
IF OBJECT_ID('dbo.UDFOrdersByCustomer') IS NOT NULL
DROP FUNCTION dbo.UDFOrdersByCustomer;
GO

CREATE FUNCTION dbo.UDFOrdersByCustomer(
   @CustomerID INT)

   RETURNS TABLE 
   AS

     RETURN 
	   (SELECT PD.ProductID, PD.ProductName,
	   SUM(COD.Qty) AS 'Total Amount Purchased',
	   CO.OrderDate, CO.ShippedDate, CO.CustomerID
	   
	   FROM Production.ProductDetails AS PD
	   INNER JOIN Sales.CustomerOrderDetails AS COD
	   ON PD.ProductID = COD.ProductID
	   INNER JOIN Sales.CustomerOrders AS CO
	   ON  COD.OrderID = CO.OrderID
	   
	   WHERE CO.CustomerID = @CustomerID
	   GROUP BY PD.ProductID, PD.ProductName, CO.OrderDate, 
	            CO.ShippedDate, CO.CustomerID);
GO

SELECT * 
FROM dbo.UDFOrdersByCustomer(5);

/*Here I have a function that extracts the number of orders processed by an 
Associate within a partuclar month.*/
IF OBJECT_ID('dbo.UDFAssociateProcessedOrders') IS NOT NULL
DROP FUNCTION dbo.UDFAssociateProcessedOrders;
GO

CREATE FUNCTION dbo.UDFAsociateProcessedOrders(
    @AssociateID INT,
	@OrderMonth INT)
	RETURNS INT
	   BEGIN
	     RETURN (SELECT COUNT(OrderID)
		         FROM Sales.CustomerOrders
				 WHERE AssociateID = @AssociateID 
				 AND MONTH(OrderDate) = @OrderMonth)
	    END;

--Here, I use the function to extract the required data, which is 
--the number of orders from Associate seven within the month of April.
SELECT dbo.UDFAsociateProcessedOrders(7, 4);


	   
	       

























	   







   

     






	  
	   
	 



    