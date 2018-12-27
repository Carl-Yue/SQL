-------------------------------------------------------
-- Week 3 Working Demos
-- Created by: Clint MacDonald
-- May 22, 2018
-- Purpose: Week 3, Lesson 3 Working Demos DBS301
-- Description: Using Functions in SELECT statements
-----------------------------------------------------------------

-- From week 2 working demos
-- List all the countries that start with a letter entered by the user (prompt)
SELECT * FROM countries WHERE country_name LIKE '&EnterLetter%';
-- note the difference between entering a lowercase and an uppercase letter

-- let's make it easier for the user !!!
SELECT * FROM countries 
    WHERE UPPER(country_name) LIKE UPPER('&EnterLetter%');
-- try both lower and upper case letters with this one!

-- Calculate how many letters each country name has in it and list them from
-- most letters to least letters
SELECT  country_name AS "Country",
        LENGTH(country_name) AS "#Letters"
    FROM countries
    ORDER BY "#Letters" DESC;

-- Just for Fun, list all the countries and replace all "a"'s with "o"'s.
SELECT  country_name AS "Original",
        REPLACE(country_name,'a','o') AS "Improoved"
    FROM countries;

-- List employees stating their current salaries and then a new column giving 
-- them a $200 raise.
SELECT last_name, first_name, 
        salary AS "Old Salary",
        salary + 200 AS "Raise"
    FROM employees;
    
-- run the same query but adding a new column with a 1% raise called "Raise 2"
SELECT last_name, first_name, 
        salary AS "Old Salary",
        salary + 200 AS "Raise",
        salary * 1.01 AS "Raise 2"
    FROM employees;
    
-- show the current system date;
SELECT sysdate FROM dual;
--note: dual is a built-in temp table that can be used for this type of function

-- show the date 10 days ago
SELECT sysdate - 10 AS "10 Days Ago"
    FROM dual;
    
-- What is the date of the next Saturday
SELECT  NEXT_DAY(sysdate,'Saturday') AS "Next Saturday"
    FROM dual;
    
-- What is the date of the 3rd Sunday from today
SELECT  NEXT_DAY(sysdate,'Sunday')+14 AS "Next Saturday"
    FROM dual;
    
