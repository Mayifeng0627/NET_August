/*** SQL 1 Homework ***/


/* Select master database */


/* Query 1 
Write a query that retrieves the columns CustomerID, ContactName, City and Region 
from the Customers table, with no filter. 
*/
USE Northwind
GO

SELECT CustomerID,ContactName,City,Region
FROM Customers



/* Query 2
Write a query that retrieves the columns CustomerID, ContactName, City, Region, PostalCode
from the Customers table, the rows that start with numbers for the column PostalCode
*/
SELECT PostalCode, CustomerID, ContactName, City, Region
FROM Customers

/* Query 3
Write a query that retrieves the columns CustomerID, ContactName, City and Region 
from the Customers table, the rows that are rows that are NULL for the Region column.
*/
SELECT CustomerID,ContactName,City,Region
FROM Customers
WHERE Region IS NULL

/* Query 4 
Write a query that retrieves the columns CustomerID, ContactName, City and Region 
from the Customers table, the rows that are not NULL for the Region column.
*/ 
SELECT CustomerID,ContactName,City,Region
FROM Customers
WHERE Region IS NOT NULL

/* Query 5
Write a query that retrieves the columns CustomerID, ContactName, City and Region 
from the Customers table, the rows that are not NULL for the column Color, 
and the column City is not London
*/
-- 1. With the column Region is not NULL
SELECT CustomerID, ContactName, City, Region
FROM Customers
WHERE Region IS NOT NULL AND City != 'London'

-- 2. With the column Fax is not NULL
SELECT CustomerID, ContactName, City, Region
FROM Customers
WHERE Fax IS NOT NULL AND City != 'London'


/* Query 6
Generate a report that concatenates the columns City and Region 
from the Customers table by excluding the rows that are null for Region.
*/
SELECT CONCAT(City,', ',Region) AS Report
FROM Customers
WHERE Region IS NOT NULL

/* Query 7
Write a query that generates the following result set  from Customers:
NAME AND TITLE
--------------------------------------------------
NAME: Manuel Pereira -- TITLE: Owner
NAME: Jaime Yorres -- TITLE: Owner
NAME: Felipe Izquierdo -- TITLE: Owner
NAME: Karl Jablonski -- TITLE: Owner
*/

-- 1. With All Title
SELECT CONCAT('NAME: ',ContactName, ' -- TITLE: ',ContactTitle) AS Result
FROM Customers

-- 2. Only With Owner Title
SELECT CONCAT('NAME: ',ContactName, ' -- TITLE: ',ContactTitle) AS Result
FROM Customers
WHERE ContactTitle = 'Owner'

/* Query 8
Write a query to retrieve the to the columns ProductID and ProductName 
from the Products table filtered by ProductID from 40 to 50
*/
SELECT ProductID, ProductName
FROM Products
WHERE ProductID BETWEEN 40 AND 50

/* Query 9
Write a query to retrieve the to the columns  ProductID, Name and CategoryID 
from the Products table restricted to the Category 1 and 2
*/
SELECT ProductID, ProductName, CategoryID
FROM Products
WHERE CategoryID = '1' OR CategoryID = '2'

/* Query 10
Write a query to generate a report on products that begins with the letter S. 
*/
SELECT * 
FROM Products
WHERE ProductName LIKE 'S%'

/* Query 11
Write a query that retrieves the columns as Name and ListPrice from the Products table. 
Your result set should look something like the following. Order the result set by the Name column. 
Name                                               ListPrice
-------------------------------------------------- -----------
Sasquatch Ale										14.00
Schoggi Schokolade									43.90
Scottish Longbreads									12.50
Singaporean Hokkien Fried Mee						14.00
Sir Rodney's Marmalade								81.00
Sir Rodney's Scones									10.00
Sirop d'��rable										28.50
Spegesild											12.00
Steeleye Stout										18.00
*/
SELECT ProductName AS Name, UnitPrice AS ListPrice
FROM Products
ORDER BY ProductName

/* Query 12
Write a query that retrieves the columns as Name and ListPrice from the Products table. 
Your result set should look something like the following. Order the result set by the Name column. 
The products name should start with either 'O' or 'T' 
Name                                               ListPrice
-------------------------------------------------- ----------
Original Frankfurter gr��ne So?e						13.00
Outback Lager										15.00
Tarte au sucre										49.30
Teatime Chocolate Biscuits							9.20
Th��ringer Rostbratwurst								123.79
Tofu												23.25
Tourti��re											7.45
Tunnbr?d											9.00
*/
SELECT ProductName AS Name, UnitPrice AS ListPrice
FROM Products
WHERE ProductName LIKE 'O%' OR ProductName LIKE 'T%'
ORDER BY ProductName

/* Query 13
Write a query so you retrieve rows that have a Name that begins with the letters SI, 
but is then not followed by the letter N. After this zero or more letters can exists. 
Order the result set by the ProductName column.
*/
SELECT *
FROM Products
WHERE ProductName LIKE 'SI[^N]%' 
ORDER BY ProductName

/* Query 14
Write a query that retrieves unique ContactTitle from the table Customers 
Order the results in descending  manner
*/
SELECT DISTINCT ContactTitle
FROM Customers
ORDER BY ContactTitle DESC

/* Query 15
Write a query that retrieves the unique combination of columns City and Region 
from the Customers table. 
Format and sort so the result set accordingly to the following. 
We do not want any rows that are NULL.in any of the two columns in the result.
*/
SELECT DISTINCT City, Region
FROM Customers
WHERE City IS NOT NULL AND Region IS NOT NULL
ORDER BY City
