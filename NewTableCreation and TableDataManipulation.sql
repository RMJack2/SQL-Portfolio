/*This first bit of code will create and populate the "HR.SalesRepreseititives" table. The "SalesRepID" column
will be designated as the primary key. Here, I demonstrate how a new table can be added to a database consisting of relational tables.*/
IF OBJECT_ID('HR.SalesRepresentatives') IS NOT NULL
DROP TABLE HR.SalesRepresentatives;


CREATE TABLE HR.SalesRepresentatives(
    SalesRepID INT NOT NULL IDENTITY,
	LastName NVARCHAR(20) NOT NULL,
	FirstName NVARCHAR(20) NOT NULL,
	JobTitle NVARCHAR(30) NOT NULL,
	CourtesyTitle NVARCHAR(25) NOT NULL,
	BirthDate DATETIME NOT NULL,
	HireDate DATETIME NOT NULL,
	Address NVARCHAR(60) NOT NULL,
	City NVARCHAR(15) NOT NULL,
	Region NVARCHAR(15) NULL,
	ZipCode NVARCHAR(12) NULL,
	Country NVARCHAR(15) NOT NULL,
	Phone NVARCHAR(12) NOT NULL,
	ManagerID INT,
	
	CONSTRAINT PK_SalesRepID PRIMARY KEY (SalesRepID));
	
	
SET IDENTITY_INSERT HR.SalesRepresentatives ON;	
INSERT INTO HR.SalesRepresentatives(SalesRepID, LastName, FirstName, JobTitle, CourtesyTitle, BirthDate, HireDate, Address, 
                                     City, Region, ZipCode, Country, Phone, ManagerID)
VALUES (100, N'Wilson', N'Kennith', N'VP Sales', N'Mr.', N'19690124',  N'20080501', N'3456 N Taney Street', N'Upper Darby', N'Wales',
       N'19045', N'United States', N'215 567-5566', NULL),
		
	   (101, N'Fauntleroy', N'Karen', N'Medical products junior sales', N'Ms.', N'19590623',  N'20060603', N'56 N Sunsine Way', N'Tampa', NULL,
       N'40578', N'United States', N'556 676-7766', 100),
		
       (102, N'Bussie', N'April', N'South East Sales', N'Ms.', N'19640706',  N'20100404', N'53 Breey Street', N'Smithville', NULL,
       N'66789', N'United States', N'780 343-5566', 102),
		
	   (104, N'Jones', N'Jessixca', N'VP Reginal Sales', N'Ms.', N'19690608',  N'20011204', N'47th and 7th', N'New York', N'Hells Kitchen',
       N'10145', N'United States', N'212 566-5566', 103);
		
SET IDENTITY_INSERT HR.SalesRepresentatives OFF;

/*This will add a SalesRepID column to the Sales.CustomerOrders table(already in the database), because I want to establish a relationship between the 
 HR.SalesRepresentatives table and the Sales.CustomerOrders table*/
 ALTER TABLE Sales.CustomerOrders
   ADD SalesRepID INT NULL;

/*Now I designate the new "SalesRepID" column within the "Sales.CustomerOrders" table as a foreign key pointing to the 
"SalesRepID" column within the "HR.SalesRepresentatives" table*/

ALTER TABLE Sales.CustomerOrders
ADD CONSTRAINT FK_CustomerOrders_SalesRepresentitives FOREIGN KEY (SalesRepID) REFERENCES HR.SalesRepresentatives (SalesRepID);

/*In these next few steps I will use the INSERT, DELETE, UPDATE and SELECT statements on the newley created 
"SalesRepresentatives" table*/

--Add a new row
SET IDENTITY_INSERT HR.SalesRepresentatives ON;
INSERT INTO HR.SalesRepresentatives (SalesRepID, LastName, FirstName, JobTitle, CourtesyTitle, BirthDate, HireDate, Address, 
                                     City, Region, ZipCode, Country, Phone, ManagerID)
VALUES (105, N'Price', N'Greg', N'Senior VP Sales', N'Mr.', N'19730612',  N'20050314', N'8890 W. Filmore Ave.', N'Efreta', NULL,
       N'19632', N'United States', N'717 445-6415', 104);
SET IDENTITY_INSERT HR.SalesRepresentatives OFF;

--Delete a row
DELETE FROM HR.SalesRepresentatives
WHERE SalesRepID = 104;

--Update a row
UPDATE HR.SalesRepresentatives
SET LastName = N'Baxter'
WHERE LastName = N'Bussie';

--Use Select statement 'with alias'
Select FirstName, LastName, JobTitle, City AS 'Assigned City'
FROM  HR.SalesRepresentatives;







