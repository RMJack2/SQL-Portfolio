--In this example, I demonstrate the use of "Union" and "Union All"
/*This first example uses "Union All" which does not eliminate duplicates, 
this gives a multiset result of both queries involved, which means the same 
row can appear multiple times in the result*/
SELECT Address, City, Region, ZipCode, Country, Phone
FROM HR.Associates

UNION ALL

SELECT Address, City, Region, ZipCode, Country, Phone
FROM Sales.Customers;


/*In this example, I use the "Union" operator this opertor eliminates 
duplicates between two queries. Basically, when the same row appears in the 
input, that data will only show up once in the result*/
SELECT Address, City, Region, ZipCode, Country, Phone
FROM HR.Associates

UNION

SELECT Address, City, Region, ZipCode, Country, Phone
FROM Sales.Customers;





