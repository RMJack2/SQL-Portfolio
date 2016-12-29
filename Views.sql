--Here, I demonstrate the use of VIEW's, this view in partucular is based on a join between the "HR.Associates" and the 
--"Sales.CustomerOrders" table 
IF OBJECT_ID('dbo.VW__CustomerInfo') IS NOT NULL
DROP VIEW dbo.VW_CustomerInfo;
GO

CREATE VIEW dbo.VW_CustomerInfo AS
  SELECT A.AssociateID, A.FirstName, A.LastName, A.JobTitle,
         CO.OrderID,CO.OrderDate, CO.ShippedDate
  From HR.Associates AS A
  INNER JOIN Sales.CustomerOrders AS CO
  ON A.AssociateID = CO.AssociateID;
GO

--This select statment selects all columns defined within the view.
SELECT * 
FROM dbo.VW_CustomerInfo;


--Here, the above view is altered by including an extra table (CustomerOrderDetails)
ALTER VIEW dbo.VW_CustomerInfo AS
  SELECT A.AssociateID, A.FirstName, A.LastName, A.JobTitle,
         CO.OrderID, CO.OrderDate, CO.ShippedDate,
		 COD.UnitPrice, COD.Qty
  FROM HR.Associates AS A
  INNER JOIN Sales.CustomerOrders AS CO
  ON A.AssociateID = CO.AssociateID
  INNER JOIN Sales.CustomerOrderDetails AS COD
  ON CO.OrderID = COD.OrderID;
GO 

-- Once again, the select statement selects all columns defined within the view
SELECT * 
FROM dbo.VW_CustomerInfo;


/*Here, I demonstate how a view can be used to update a column within a 
table, I change the last a name value in the table from Davis to Williams */
UPDATE dbo.VW_CustomerInfo
SET LastName = 'Williams' 
WHERE OrderID = 10258;

SELECT *
FROM dbo.VW_CustomerInfo;

