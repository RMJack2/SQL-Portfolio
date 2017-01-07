/*This trigger is designed to log all modifications to the "Sales.Customers" table. 
What this trigger does is it records all deletions, updates, insertions, modification dates as well as and the user who made the alterations. 
This is all inserted into the "dbo.Customers_Audit" table.
*/

USE VWRProduction
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('Sales.CustomersTrigger') IS NOT NULL
DROP TRIGGER Sales.CustomersTrigger
GO


CREATE TRIGGER Sales.CustomersTrigger
   ON Sales.Customers
   AFTER INSERT, DELETE, UPDATE
   AS
    BEGIN
	   /*These declared variables will hold the old and new data extracted from the "inserted" and "deleted" tables.*/
	   DECLARE @Old_CustomerID INT
	   DECLARE @Old_NameOfCompany VARCHAR(40)
	   DECLARE @Old_ContactName VARCHAR(30)
	   DECLARE @Old_TitleOfContact VARCHAR(30)
	   DECLARE @Old_Address VARCHAR(60)
	   DECLARE @Old_City VARCHAR(15)
	   DECLARE @Old_Region VARCHAR(15)
	   DECLARE @Old_ZipCode VARCHAR(15)
	   DECLARE @Old_Country NVARCHAR(15)
	   DECLARE @Old_Phone VARCHAR(24)
	   DECLARE @Old_Fax  VARCHAR(12)

	   DECLARE @New_CustomerID INT
	   DECLARE @New_NameOfCompany VARCHAR(40)
	   DECLARE @New_ContactName VARCHAR(30)
	   DECLARE @New_TitleOfContact VARCHAR(30)
	   DECLARE @New_Address VARCHAR(60)
	   DECLARE @New_City VARCHAR(15)
	   DECLARE @New_Region VARCHAR(15)
	   DECLARE @New_ZipCode VARCHAR(15)
	   DECLARE @New_Country VARCHAR(15)
	   DECLARE @New_Phone VARCHAR(24)
	   DECLARE @New_Fax  VARCHAR(12)



	   --Here, I select the Old Values from the deleted table and insert that data into the corresponding variable.
	   
	   SELECT @Old_CustomerID = CustomerID from deleted
	   SELECT @Old_NameOfCompany = NameOfcompany FROM deleted
	   SELECT @Old_ContactName = ContactName FROM deleted
	   SELECT @Old_TitleOfContact = TitleOfContact FROM deleted
	   SELECT @Old_Address = Address FROM deleted
	   SELECT @Old_City = City FROM deleted
	   SELECT @Old_Region = Region FROM deleted
	   SELECT @Old_ZipCode = ZipCode FROM deleted
	   SELECT @Old_Country = Country FROM deleted
	   SELECT @Old_Phone = Phone FROM deleted
	   SELECT @Old_Fax = Fax FROM deleted

	   
	   --Here, I select the new values from the inserted table and insert that data into the corresponding variable.
	   SELECT @New_CustomerID = CustomerID from inserted
	   SELECT @New_NameOfCompany = NameOfcompany FROM inserted
	   SELECT @New_ContactName = ContactName FROM inserted
	   SELECT @New_TitleOfContact = TitleOfContact FROM inserted
	   SELECT @New_Address = Address FROM inserted
	   SELECT @New_City = City FROM inserted
	   SELECT @New_Region = Region FROM inserted
	   SELECT @New_Zipcode = ZipCode FROM inserted
	   SELECT @New_Country = Country FROM inserted
	   SELECT @New_Phone = Phone FROM inserted
	   SELECT @New_Fax = Fax FROM inserted

/*This insert statement places the appropriate data into the columns, the data comes from the values statement below which gets its data
	from the variables above after the data has been inserted into them from the inserted and deleted tables. When this data is output to the 
	user, it will show the old and new values when column data is updated as well as the timestamp and the user who performed the alterations.*/
	   INSERT INTO dbo.Customers_Audit (LastUpdateTime, Old_CustomerID, New_CustomerID, Old_NameOfCompany, New_NameOfCompany,
	                             Old_ContactName, New_ContactName, Old_TitleOfContact, 
								 New_TitleOfContact, Old_Address, New_Address, Old_City, New_City, Old_Region, 
								 New_Region, Old_ZipCode, New_ZipCode, Old_Country, New_Country, Old_Phone, 
								 New_Phone, Old_Fax, New_Fax, SystemUser)
	    VALUES (GETDATE(), @Old_CustomerID, @New_CustomerID, @Old_NameOfCompany,@New_NameOfCompany, @Old_ContactName, @New_ContactName, @Old_TitleOfContact, 
								 @New_TitleOfContact, @Old_Address, @New_Address, @Old_City, @New_City, @Old_Region, 
								 @New_Region, @Old_ZipCode, @New_ZipCode, @Old_Country, @New_Country, @Old_Phone, 
								 @New_Phone, @Old_Fax, @New_Fax, SYSTEM_USER)
    END
	

