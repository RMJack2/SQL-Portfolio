/*This stored procedure allows a user to update multiple rows within the table based on the 
OrderID. In this example, I update the "ShipName" and "Freight" attributes based on the "OrderID" 
OrderID*/
IF OBJECT_ID('dbo.UPDCustomerOrders') IS NOT NULL
DROP PROCEDURE dbo.UPDCustomerOrders;
GO


CREATE PROCEDURE dbo.UPDCustomerOrders(
    @OrderID INT,
	@CustomerID INT = NULL,
	@AssociateID INT = NULL,
	@OrderDate DATETIME = NULL,
	@RequiredDate DATETIME = NULL,
	@ShippedDate DATETIME = NULL,
	@ProductShipperID INT = NULL,
	@Freight MONEY = NULL,
	@ShipName NVARCHAR(30) = NULL,
	@ShipAddress NVARCHAR(40) = NULL,
	@ShipCity NVARCHAR(15) = NULL,
	@ShipRegion NVARCHAR(20) = NULL,
	@ShipZipCode NVARCHAR(15) = NULL,
	@ShipCountry NVARCHAR(15) = NULL)

AS

 BEGIN 
    UPDATE Sales.CustomerOrders
	SET 
	    CustomerID = ISNULL(@CustomerID, CustomerID),
		AssociateID = ISNULL(@AssociateID, AssociateID),
		OrderDate = ISNULL(@OrderDate, OrderDate),
		RequiredDate = ISNULL(@RequiredDate, RequiredDate),
		ShippedDate = ISNULL(@ShippedDate, ShippedDate),
        ProductShipperID = ISNULL(@ProductShipperID, ProductShipperID),
		Freight = ISNULL(@Freight, Freight),
		ShipName = ISNULL(@ShipName, ShipName),
        ShipAddress = ISNULL(@ShipAddress, ShipAddress),
		ShipCity = ISNULL(@ShipCity, ShipCity),
		ShipRegion = ISNULL(@ShipRegion, ShipRegion),
        ShipZipCode = ISNULL(@ShipZipCode, ShipZipCode),
		@ShipCountry = ISNULL(@ShipCountry, ShipCountry)
     WHERE OrderID = @OrderID   
  END;


EXECUTE dbo.UPDCustomerOrders @Freight = 35.00, @ShipName = 'Mattys Place', @OrderID = 10248;

---------------------------------------------------------------------------------------------------------------------------------------------------------



/*In this example, the stored procedure extracts two results from the "HR.Associates" and  "Sales.CustomerOrders" tables, here, the 
procedure displays the top 5 results from both tables based on the columns within the select statements*/
IF OBJECT_ID('dbo.AssociateCustOrders') IS NOT NULL
DROP PROCDURE dbo.AssociateCustOrders; 
GO


CREATE PROCEDURE dbo.AssociateCustOrders
AS

SELECT TOP(5) AssociateID, FirstName, LastName, HireDate
FROM HR.Associates;

SELECT TOP(5) OrderID, OrderDate, Freight
FROM Sales.CustomerOrders;
GO

EXECUTE dbo.AssociateCustOrders;
GO 
-----------------------------------------------------------------------------------------------------------------------------------------------------

/*This stored procedure extracts information about a particular Associate within the organization, the user only needs to provide the associate
first and last name */
IF OBJECT_ID('dbo.GetAssocInfo') IS NOT NULL
DROP PROCEDURE dbo.GetAssocInfo;
GO

CREATE PROCEDURE dbo.GetAssocInfo
    @FirstName NVARCHAR(25),
	@LastName  NVARCHAR(25)
AS

SET NOCOUNT ON;
SELECT A.FirstName, A.LastName,
       CO.OrderID, CO.CustomerID,
	   COD.ProductID, COD.UnitPrice, COD.Qty
FROM HR.Associates AS A
INNER JOIN Sales.CustomerOrders AS CO
ON A.AssociateID = CO.AssociateID
INNER JOIN Sales.CustomerOrderDetails AS COD
ON CO.OrderID = COD.OrderID
WHERE FirstName = @FirstName AND LastName = @LastName
GO

EXECUTE dbo.GetAssocInfo N'John', N'McDanials';

-----------------------------------------------------------------------------------------------------------------------------------------------------





/*This stored procedure inserts a row if it does not already exists in the table.*/
IF OBJECT_ID('SP_InsertProductCategories') IS NOT NULL
DROP PROCEDURE SP_InsertProductCategories;
GO
CREATE PROCEDURE SP_InsertProductCategories
   @ProductCategoryID INT,
   @CategoryName VARCHAR(15),
   @ProductDescription NVARCHAR(200)

AS

   DECLARE @COUNT INT

   SELECT @COUNT = COUNT(*) 
   FROM Production.ProductCategories
   WHERE ProductCategoryID = @ProductCategoryID

   IF @COUNT = 0
      
        BEGIN
		  SET IDENTITY_INSERT Production.ProductCategories ON;
          INSERT INTO Production.ProductCategories (ProductCategoryID, CategoryName, ProductDescription)
            VALUES (@ProductCategoryID, @CategoryName, @ProductDescription)
		  SET IDENTITY_INSERT Production.ProductCategories OFF;
        END;

EXECUTE SP_InsertProductCategories
 @ProductCategoryID = 9,
 @CategoryName = 'Shark',
 @ProductDescription = 'Exotic Sea Food';
 
 ----------------------------------------------------------------------------------------------------------------------------------------------------



/*This stored procedure allows a user to update any paramater within the table based on the 
OrderID. In this example, the user is able to update the "ShipName" paramater based on the 
OrderID*/

IF OBJECT_ID('dbo.UPDCustomerOrders') IS NOT NULL
DROP PROCEDURE dbo.UPDCustomerOrders;
GO


CREATE PROCEDURE dbo.UPDCustomerOrders(
    @OrderID INT,
	@CustomerID INT = NULL,
	@AssociateID INT = NULL,
	@OrderDate DATETIME = NULL,
	@RequiredDate DATETIME = NULL,
	@ShippedDate DATETIME = NULL,
	@ProductShipperID INT = NULL,
	@Freight MONEY = NULL,
	@ShipName NVARCHAR(30) = NULL,
	@ShipAddress NVARCHAR(40) = NULL,
	@ShipCity NVARCHAR(15) = NULL,
	@ShipRegion NVARCHAR(20) = NULL,
	@ShipZipCode NVARCHAR(15) = NULL,
	@ShipCountry NVARCHAR(15) = NULL)

AS

 BEGIN 
    UPDATE Sales.CustomerOrders
	SET 
	    CustomerID = ISNULL(@CustomerID, CustomerID),
		AssociateID = ISNULL(@AssociateID, AssociateID),
		OrderDate = ISNULL(@OrderDate, OrderDate),
		RequiredDate = ISNULL(@RequiredDate, RequiredDate),
		ShippedDate = ISNULL(@ShippedDate, ShippedDate),
        ProductShipperID = ISNULL(@ProductShipperID, ProductShipperID),
		Freight = ISNULL(@Freight, Freight),
		ShipName = ISNULL(@ShipName, ShipName),
        ShipAddress = ISNULL(@ShipAddress, ShipAddress),
		ShipCity = ISNULL(@ShipCity, ShipCity),
		ShipRegion = ISNULL(@ShipRegion, ShipRegion),
        ShipZipCode = ISNULL(@ShipZipCode, ShipZipCode),
		ShipCountry = ISNULL(@ShipCountry, ShipCountry)
     WHERE OrderID = @OrderID   
  END;


EXECUTE dbo.UPDCustomerOrders @ShipName = 'Mattys Place', @OrderID = 10248;

------------------------------------------------------------------------------------------------------------------------------------------------------


















   




