-- INSERT INTO statement insert new record(s) into one table
-- INSERT INTO example:

INSERT INTO Customer (FirstName, LastName, City, Country, Phone)
SELECT LEFT(ContactName, CHARINDEX(' ',ContactName) - 1), 
       SUBSTRING(ContactName, CHARINDEX(' ',ContactName) + 1, 100), 
       City, Country, Phone
FROM Supplier
WHERE CompanyName = 'Bigfoot Breweries'

-- We input the first name from the ContactName in Supplier table into Customer table
-- We input the last name from the ContactName in Supplier table into Customer table
-- LEFT function take the string from an input string until the specific location
-- SUBSTRING function take the string from an input string from a start location with a specific length
-- CHARINDEX function search for the specific string from another string, and return the starting point of the string we are searching for
