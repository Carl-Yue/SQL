-------------------------------------------------------
-- Week 4 Working Demos
-- Created by: Clint MacDonald
-- May 29, 2018
-- Purpose: Week 4, Lesson 5 Working Demos DBS301
-- Description: Multi-Row Functions, Aggregate functions, and Grouping
-----------------------------------------------------------------

-- GENERIC UPDATED SYNTAX
-- SELECT column, group_function
--   FROM table
--   [WHERE condition]
--   [GROUP BY group_by_expression]
--   [HAVING group_condition]
--   [ORDER BY column];

-- Let's get the total number of employees that work for the company
SELECT * FROM Employees;
-- Nope, not just a list
SELECT COUNT(employee_id) AS "Num Employees"
    FROM employees;
    -- or adding string concatenation
SELECT to_char(COUNT(employee_id)) || ' employees' AS "Num Employees"
    FROM employees;
    
-- Now let's get the number of employees that work in each department
SELECT department_id, COUNT(employee_id) AS "Num Employees"
    FROM Employees
    GROUP BY department_id
    ORDER BY department_id;
    
    -- or sort by Num employees
SELECT department_id, COUNT(employee_id) AS "Num Employees"
    FROM Employees
    GROUP BY department_id
    ORDER BY "Num Employees" DESC;
    
-- ANY FIELD IN THE SELECT STATEMENT NOT PART OF AN 
-- AGGREGATE FUNCTION MUST BE INCLUDED IN A GROUP BY 

-- Using DISTINCT
-- Let's display the number of different departments that have employees in the database
SELECT COUNT(department_id) AS "Num Depts"
    FROM employees;
    -- WHAT??? there are only 8 departments, why 19???
SELECT COUNT(DISTINCT department_id) AS "Num Depts"
    FROM employees;

-- USING NVL
-- Find the average commission rate for employees
SELECT AVG(commission_pct)
  FROM employees;
-- now to include all 20 employees....
SELECT AVG(NVL(commission_pct,0))
    FROM employees;
    
-- OTHER FUNCTIONS
-- Produce a SINGLE sql statement that returns a SINGLE line result that displays 
--   the minimum, maximum, and average salaries for all employees
SELECT to_char(MIN(salary),'$999,999.99') AS "Min", 
    to_char(MAX(salary),'$999,999.99') AS "Max", 
    to_char(AVG(NVL(salary,0)),'$999,999.99') AS "Average"
        FROM employees;
        
-- GROUPING BY MULTIPLE COLUMNS
-- display the average salary for employees in each job-title in each department
SELECT job_id, 
    department_id, 
    to_char(AVG(salary), '$999,999.99') AS "Avg Salary"
        FROM employees
        GROUP BY job_id, department_id;
    -- note that the grouping is performed on the combination of the two fields 
    -- being distinct, not each field being distinct.
    
-- HAVING
-- display the average salary for emplyees in each job title in each department, 
-- but only show those where the average is over $10,000.00.
SELECT job_id, 
    department_id, 
    to_char(AVG(salary), '$999,999.99') AS "Avg Salary"
        FROM employees
        GROUP BY job_id, department_id
        HAVING AVG(salary) > 10000.0;


-- Using HAVING and WHERE

SELECT job_id, department_id, to_char(AVG(salary), '$999,999.99') AS "Avg Salary"
    FROM employees
    WHERE LENGTH(job_id) > 0
    GROUP BY job_id, department_id
    HAVING AVG(salary) > 10000.0;
    
-- repeat the previous example but only include departments 20, 60, 80 and 90
SELECT job_id, department_id, to_char(AVG(salary), '$999,999.99') AS "Avg Salary"
    FROM employees
    WHERE department_id IN(20, 60, 80, 90)
    GROUP BY job_id, department_id
    HAVING AVG(salary) > 10000.0;