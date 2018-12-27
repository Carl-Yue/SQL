-------------------------------------------------------------------------------
-- Name: Shujing Yue
-- ID: 122072176
-- Date: May 24, 2018
-- Purpose: Lab 3 DBS301
-------------------------------------------------------------------------------

-- Question 1.	Write a query to display the tomorrow’s date in the following format:
     -- September 28th of year 2016
-- Your result will depend on the day when you RUN/EXECUTE this query.  Label the column Tomorrow.

-- Q1 SOLUTION --
SELECT to_char(sysdate + 1, 'fmMonth') || ' ' || to_char(sysdate + 1, 'fmddth') || ' of year ' || to_char(sysdate + 1, 'fmyyyy') AS "Tomorrow" FROM dual;

-- Question 2.	For each employee in departments 20, 50 and 60 display last name, first name, salary, and salary increased by 5% and expressed as a whole number.  Label the column Good Salary.  
-- Also add a column that subtracts the old salary from the new salary and multiplies by 12. Label the column "Annual Pay Increase".

-- Q2 SOLUTION --
SELECT last_name, first_name, salary, salary*1.05 AS "Good Salary", (salary*1.05-salary)*12 AS "Annual Pay Increase" 
  FROM employees
  WHERE department_id IN (20,50,60);

-- Question 3.	Write a query that displays the employee’s Full Name and Job Title in the following format:
          -- DAVIES, CURTIS is ST_CLERK 
-- Only employees whose last name ends with S and first name starts with C or K.  Give this column an appropriate label like Person and Job.  Sort the result by the employees’ last names.

-- Q3 SOLUTION --
SELECT upper(last_name) || ', ' || upper(first_name) || ' is ' || job_id AS "Person and Job"
  FROM employees
  WHERE upper(last_name) LIKE '%S' AND (first_name LIKE 'C%' OR first_name LIKE 'K%')
  ORDER BY last_name;

-- Question 4.	For each employee hired before 1992, display the employee’s last name, hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
-- a.	Label the column Years worked. 
-- b.	Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.

-- Q4 SOLUTION --
SELECT last_name, hire_date, to_char(round((sysdate - hire_date)/365)) AS "Years worked"
  FROM employees
  WHERE hire_date < to_date('01011992', 'ddmmyyyy')
  ORDER BY 3 DESC;
  
-- Question 5.	Create a query that displays the city names, country codes and state province names, but only for those cities that starts with S and has at least 8 characters in their name. If city does not have a province name assigned, then put Unknown Province.  Be cautious of case sensitivity!

-- Q5 SOLUTION --
SELECT city AS "City", country_id AS "Country Code", NVL(state_province, 'Unknown Province') AS "State/Province"
  FROM locations
  WHERE city LIKE 'S%' AND length(city) >=8;
  
-- Question 6.	Display each employee’s last name, hire date, and salary review date, which is the first Thursday after a year of service, but only for those hired after 1997.  
-- a.	Label the column REVIEW DAY. 
-- b.	Format the dates to appear in the format like:
    -- THURSDAY, August the Thirty-First of year 1998
-- c.	Sort by review date

-- Q6 SOLUTION --
SELECT last_name, hire_date, 
       to_char(next_day(add_months(hire_date, 12), 'Thursday'), 'fmDAY') || ', ' || to_char(next_day(add_months(hire_date, 12), 'Thursday'), 'fmMonth') || ' the ' || to_char(next_day(add_months(hire_date, 12), 'Thursday'), 'fmDdspth') || ' of year ' || to_char(next_day(add_months(hire_date, 12), 'Thursday'), 'fmyyyy') AS "Review Day"
  FROM employees
  WHERE hire_date > to_date('01011997', 'ddmmyyyy')
  ORDER BY next_day(add_months(hire_date, 12), 'Thursday');

