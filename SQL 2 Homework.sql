/*** SQL 2 Homework ***/


/** Part 1 Answer following questions **/

-- What is a result set?
-- The result set is an object that represents a set of data returned from a data source, usually as the result of a query. 
-- The result set contains rows and columns to hold the requested data elements, and it is navigated with a cursor.


-- What is the difference between Union and Union All?
-- UNION and UNION ALL in SQL are used to retrieve data from two or more tables. 
-- UNION returns distinct records from both tables, while UNION ALL returns all the records from both tables

-- What are the other Set Operators SQL Server has?
-- UNION, UNION ALL, INTERSECT, and EXCEPT

-- What is the difference between Union and Join?
-- The difference between JOIN and UNION in SQL lies in their fundamental purposes and the way they merge data. 
-- JOIN is used to combine rows from two or more tables based on a related column, while UNION is used to combine the results of two or more SELECT statements into a single result set.

-- What is the difference between INNER JOIN and FULL JOIN?
-- Inner join returns only the matching rows between both the tables, non-matching rows are eliminated. 
-- Full Join or Full Outer Join returns all rows from both the tables (left & right tables), including non-matching rows from both the tables.

-- What is difference between left join and outer join
-- LEFT JOIN returns all rows from the left table and only matched rows from the right table.
-- While OUTER JOIN refers to all types of joins that can involve unmatched rows, including LEFT JOIN, RIGHT JOIN, and FULL OUTER JOIN.
-- LEFT JOIN is a specific type of OUTER JOIN that includes unmatched rows from the left table only.


-- What is cross join?
-- A cross join is a type of join that returns the Cartesian product of rows from the tables in the join. 
-- In other words, it combines each row from the first table with each row from the second table.


-- What is the difference between WHERE clause and HAVING clause?
-- the WHERE clause allows you to filter data from specific rows (individual rows) from a table based on certain conditions. 
-- In contrast, the HAVING clause allows you to filter data from a group of rows in a query based on conditions involving aggregate values.
-- WHERE clause can be used with SELECT, UPDATE and DELETE statements and clauses but HAVING clause can only be used with SELECT statements.



-- Can there be multiple group by columns?
-- Yes, we can use two GROUP BY columns in SQL by simply specifying both column names separated by commas in the GROUP BY clause.


/** Part 2 Write queries for following scenarios **/

/* Select master Database */
Use master
GO

/* Query 1
How many products can you find in the Products table?
*/
SELECT COUNT(ProductID) AS Numbers_of_Products
FROM Products

/* Query 2
Write a query that retrieves the number of products in the Products table that are out of stock. 
The rows that have 0 in column UnitsInStock are considered to be out of stock. 
*/
SELECT COUNT(ProductID) AS Numbers_of_Products_out_of_stock
FROM Products
WHERE UnitsInStock = '0'

/* Query 3
How many Products reside in each Category? Write a query to display the results with the following titles.
CategoryID CountedProducts
---------- ---------------
*/
SELECT CategoryID, COUNT(ProductID) AS CountedProducts
FROM Products
GROUP BY CategoryID


/* Query 4
How many products that are not in category 6. 
*/
SELECT COUNT(ProductID) AS CountedNotCategory6
FROM Products
WHERE CategoryID != '6'


/* Query 5
Write a query to list the sum of products UnitsInStock in Products table.
*/
SELECT SUM(UnitsInStock) AS TotalUnitsInStock
FROM Products

/* Query 6 
Write a query to list the sum of products by category in the Products table 
and UnitPrice over 25 and limit the result to include just summarized quantities larger than 10.
CategoryID			TheSum
-----------        ----------
*/
SELECT CategoryID, SUM(UnitsInStock) AS TheSum
FROM Products
WHERE UnitPrice > 25
GROUP BY CategoryID
HAVING SUM(UnitsInStock) > 10


/* Query 7
Write a query to list the sum of products with productID by category in the Products table 
and UnitPrice over 25 and limit the result to include just summarized quantities larger than 10.
ProductID  CategoryID	  TheSum
---------- -----------    -----------
*/
SELECT ProductID, CategoryID, SUM(UnitsInStock) AS TheSum
FROM Products
WHERE UnitPrice > 25
GROUP BY ProductID, CategoryID
HAVING SUM(UnitsInStock) > 10


/* Query 8
Write the query to list the average UnitsInStock for products 
where column CategoryID has the value of 2 from the table Products.
*/
SELECT AVG(UnitsInStock) AS AverageUnitsInStock
FROM Products
WHERE CategoryID = '2'


/* Query 9
Write query to see the average quantity of products by Category from the table Products.
CategoryID      TheAvg
----------    -----------
*/
SELECT CategoryID, AVG(UnitsInStock) AS TheAvg
FROM Products
GROUP BY CategoryID


/* Query 10
Write query  to see the average quantity  of  products by Category and product id
excluding rows that has the value of 1 in the column Discontinued from the table Products
ProductID   CategoryID   TheAvg
----------- ----------   -----------
*/
SELECT ProductID, CategoryID, AVG(UnitsInStock) AS TheAvg
FROM Products
WHERE Discontinued != '1'
GROUP BY ProductID, CategoryID


/* Query 11
List the number of members (rows) and average UnitPrice in the Products table. 
This should be grouped independently over the SupplierID and the CategoryID column. Exclude the discountinued products (discountinue = 1)
SupplierID      CategoryID		TheCount   		AvgPrice
--------------	------------ 	----------- 	---------------------
*/
SELECT SupplierID, CategoryID, COUNT(*) AS TheCount, AVG(UnitPrice) AS AvgPrice
FROM Products
WHERE Discontinued != '1'
GROUP BY SupplierID, CategoryID


-- Joins
-- Using Northwnd Database: (Use aliases for all the Joins)
USE Northwind
GO 

/* Query 12
Write a query that lists the Territories and Regions names from Territories and Region tables. 
Join them and produce a result set similar to the following. 
Territory           Region
---------         ----------------------
*/
SELECT t.TerritoryDescription AS Territory, r.RegionDescription AS Region
FROM Territories t
JOIN Region r ON t.RegionID = r.RegionID


/* Query 13
Write a query that lists the Territories and Regions names from Territories and Region tables. 
and list the Territories filter them by Eastern and Northern. Join them and produce a result set similar to the following.
Territory           Region
---------     ----------------------
*/
SELECT t.TerritoryDescription AS Territory, r.RegionDescription AS Region
FROM Territories t
JOIN Region r ON t.RegionID = r.RegionID
WHERE r.RegionDescription = 'Eastern' OR r.RegionDescription = 'Northern'


/* Query 14
List all Products that has been sold at least once in last 25 years.
*/
SELECT DISTINCT p.ProductID, p.ProductName
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) >= YEAR(GETDATE())-25;


/* Query 15
List top 5 locations (Zip Code) where the products sold most.
*/
SELECT TOP 5 o.ShipPostalCode, COUNT(*) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.ShipPostalCode
ORDER BY TotalSales DESC


/* Query 16
List top 5 locations (Zip Code) where the products sold most in last 25 years.
*/
SELECT TOP 5 o.ShipPostalCode, COUNT(*) AS TotalSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= DATEADD(YEAR,-25,GETDATE())
GROUP BY o.ShipPostalCode
ORDER BY TotalSales DESC


/* Query 17
List all city names and number of customers in that city. 
*/
SELECT City, COUNT(*) AS ToTalCustomerNumbers
FROM Customers
GROUP BY City


/* Query 18
List city names which have more than 2 customers, and number of customers in that city 
*/
SELECT City, COUNT(*) AS ToTalCustomerNumbers
FROM Customers
GROUP BY City
HAVING COUNT(*) > 2


/* Query 19
List the names of customers who placed orders after 1/1/98 with order date.
*/
SELECT c.ContactName
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '1998-01-01'


/* Query 20
List the names of all customers with most recent order dates 
*/
SELECT TOP 1 c.ContactName, MAX(o.OrderDate) AS MostRecentOrder
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY ContactName


/* Query 21
Display the names of all customers along with the count of products they bought
*/



/* Query 22
Display the customer ids who bought more than 100 Products with count of products.
*/



/* Query 23
List all of the possible ways that suppliers can ship their products. Display the results as below
Supplier Company Name   	Shipping Company Name
----------------------      ----------------------------------
*/



/* Query 24
Display the products order each day. Show Order date and Product Name.
*/



/* Query 25
Displays pairs of employees who have the same job title.
*/


/* Query 26
Display all the Managers who have more than 2 employees reporting to them.
*/



/* Query 27
Display the customers and suppliers by city. The results should have the following columns
City 
Name 
Contact Name,
Type (Customer or Supplier)
*/



/* Query 28
For example, you have two exactly the same tables T1 and T2 with two columns F1 and F2
	F1	F2
	--- ---
	1	2
	2	3
	3	4
Please write a query to inner join these two tables and write down the result of this query.
*/


/* Query 29
Based on above two table, Please write a query to left outer join these two tables and write down the result of this query.
*/

