-------------------------------------------------------------------------------
-- Name: Shujing Yue
-- ID: 122072176
-- Date: 5/17/2018
-- Purpose: Lab 2 DBS301
-------------------------------------------------------------------------------

-- 1.	Display the employee_id, last name and salary of employees earning in the range of $8,000 to $15,000.  Sort the output by top salaries first and then by last name.
-- Q1 SOLUTION --
SELECT employee_id, last_name, salary
  FROM employees
  WHERE 8000 <= salary AND salary <= 15000
  ORDER BY salary DESC, last_name;
  -- to_char(salary, '$999,999.99') AS "Salary"
-- 2.	Modify previous query (#1) so that additional condition is to display only if they work as Programmers or Sales Representatives. Use same sorting as before.
-- Q2 SOLUTION --
SELECT employee_id, last_name, salary
  FROM employees
  WHERE 8000 <= salary AND salary <= 15000 AND (job_id = 'IT_PROG' OR job_id = 'SA_REP')
  ORDER BY salary DESC, last_name;
-- 3.	The Human Resources department wants to find high salary and low salary employees. Modify previous query (#2) so that it displays the same job titles but for people who earn outside the given salary range from question 1. Use same sorting as before.
-- Q3 SOLUTION --
SELECT employee_id, last_name, salary
  FROM employees
  WHERE 8000 > salary OR salary > 15000 AND (job_id = 'IT_PROG' OR job_id = 'SA_REP')
  ORDER BY salary DESC, last_name;
-- 4.	The company needs a list of long term employees, in order to give them a thank you dinner. Display the last name, job_id and salary of employees hired before 1998. List the most recently hired employees first.
-- Q4 SOLUTION --
SELECT last_name, job_id, salary
  FROM employees
  WHERE hire_date < to_date('01011998', 'ddmmyyyy')
  ORDER BY hire_date DESC;
-- 5.	Modify previous query (#4) so that it displays only employees earning more than $10,000. List the output by job title alphabetically and then by highest paid employees.
-- Q5 SOLUTION --
SELECT last_name, job_id, salary
  FROM employees
  WHERE hire_date < to_date('01011998', 'ddmmyyyy') and salary >= 10000.0
  -- When we compare decimal to integer, rounding will be done by compiler
  ORDER BY job_id, salary DESC;
-- 6.	Display the job titles and full names of employees whose first name contains an �e� or �E� anywhere. The output should look like:
-- Q6 SOLUTION --
SELECT job_id AS "Job Title", first_name || ' ' || last_name AS "Full Name"
  FROM employees
  WHERE first_name LIKE '%e%' OR first_name LIKE '%E%';
  -- WHERE REGEXP_LIKE(first_name,'{eE}');
-- 7.	Create a report to display last name, salary, and commission percent for all employees that earn a commission.
-- Q7 SOLUTION --
SELECT last_name, salary, commission_pct
  FROM employees
  WHERE commission_pct > 0;
  -- WHERE commission_pct IS NOT NULL;
-- 8.	Do the same as question 7, but put the report in order of descending salaries.
-- Q8 SOLUTION --
SELECT last_name, salary, commission_pct
  FROM employees
  WHERE commission_pct > 0
  ORDER BY salary DESC;
-- 9.	Do the same as 8, but use a numeric value instead of a column name to do the sorting.
-- Q9 SOLUTION --
SELECT last_name, salary, commission_pct
  FROM employees
  WHERE commission_pct > 0
  ORDER BY 2 DESC;