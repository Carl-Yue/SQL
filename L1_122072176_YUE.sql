-------------------------------------------------------------------------------
-- Name: Shujing Yue
-- ID#: 122072167
-- Date: May 10, 2018
-------------------------------------------------------------------------------

-- Question 1: Start by entering in the SQL Developer worksheet:
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_HISTORY;
-- d. Which one of these tables appeared to be the widest? or longest? (Answer in commented text)
-- Answer Question 1d: table a is the widest because it has the most colomns, and it is the longest as well, because it has the most records.

-- Question 2: Using SQL Plus – enter the same three lines (one at a time) – Provide answers to questions below in commented lines in SQL file.
-- a. at the prompt enter the command
-- SET pagesize 200
-- b.	Choosing the widest table from question 1, rerun the SELECT. 
-- Did it have an effect to improve the look of the display?
-- Answer Question 2b: 
-- It improves the looking of the table, it eliminated the colomn name for every single record.
-- c.	Do the same for the longest table.
-- You should have seen that there were not headings every 10 lines as it increased the page length to 200.  
-- d.	You should try to find a SET command that will increase the length of each line to improve readability and remove the word wrap effect. 
-- HINT: It was in the demobld file.
-- Q2d SOLUTION --
SET linesize 200

-- Question 3: If the following SELECT statement does NOT execute successfully, how would you fix it?
-- SELECT last_name “LName”, job_id “Job Title”, Hire Date “Job Start”
--        FROM employees;
-- Q3 SOLUTION --
SELECT last_name AS "LName", job_id AS "Job Title", hire_date AS "Job Start"
FROM employees;

-- Question 4: There are THREE coding errors in this statement. Can you identify them?
-- SELECT employee_id, last name, commission_pct Emp Comm,
-- FROM employees;
-- Q4 SOLUTION --
-- 1. the alias for commission_pct should has a keyword AS
-- 2. the alias should have ""
-- 3. , should not appear in the end of select statement
-- The right form should be shown as following:
-- SELECT employee_id, last_name, commission_pct AS "Emp Comm"
-- FROM employees;

-- Question 5: What command would show the structure of the LOCATIONS table?
-- Q5 SOLUTION --
DESCRIBE locations;

-- Question 6: Create a query to display the output shown below.
-- City# 		City 			Province with Country Code 
---------------------------------------------------------------------------------
--        1000 	Roma 			IN THE IT 
--        1100 	Venice 		IN THE IT
-- Q6 SOLUTION --
SELECT location_id AS "City#", city AS "City", 'IN THE ' || country_id AS "Province with Country"
FROM locations;

