/*Here, I create a login with a password and specify a default database and the policy setting to off*/

USE VWRProduction;
GO

CREATE LOGIN MCCRO01 
WITH PASSWORD = N'Kreno@1996',
     DEFAULT_DATABASE = [VWRProduction],
	 CHECK_POLICY = OFF
GO


/*Here, I create a database login and then create a database user for that login.*/
CREATE LOGIN REEKA01
    WITH PASSWORD = N'Password1';
USE VWRProduction;
GO

CREATE USER REEKA01
FOR LOGIN REEKA01;
GO

/*In this example, I create a login along with a password, then the code creates a 
user associated with the login with a default schema*/
CREATE LOGIN MagKimCornZoe
   WITH PASSWORD = N'Password2';
   
USE VWRProduction;
CREATE USER Darrel
FOR LOGIN MagKimCornZoe
WITH DEFAULT_SCHEMA = Production;
GO

/*The code below grants permissins to users on on specific databse objects*/
GRANT SELECT, UPDATE, INSERT, DELETE ON 
Production.ProductDetails TO Darrel;

GRANT SELECT, UPDATE, INSERT ON
Sales.Customers TO REEKA01;