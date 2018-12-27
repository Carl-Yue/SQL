--------------------------------------------------------------------------------
-- Name: Shujing Yue
-- ID: 122072176
-- Date: May 31, 2018
-- Purpurse: Lab 3 DBS301
--------------------------------------------------------------------------------

-- Question 1.	Display the difference between the Average pay and Lowest pay in the company.  Name this result Real Amount.  Format the output as currency with 2 decimal places.
-- Q1 SOLUTION --
SELECT to_char(AVG(NVL(salary,0))-MIN(salary),'$999,999.99') AS "Real Amount"
  FROM employees;
  
-- Question 2.	Display the department number and Highest, Lowest and Average pay per each department. Name these results High, Low and Avg.  Sort the output so that the department with highest average salary is shown first.  Format the output as currency where appropriate.
-- Q2 SOLUTION --
SELECT department_id AS "Department ID", 
  to_char(MAX(salary),'$999,999.99') AS "High",
  to_char(MIN(salary),'$999,999.99') AS "Low",
  to_char(AVG(NVL(salary,0)),'$999,999.99') AS "Avg"
    FROM employees
    GROUP BY department_id
    ORDER BY "Avg" DESC;

-- Question 3.	Display how many people work the same job in the same department. Name these results Dept#, Job and How Many. Include only jobs that involve more than one person.  Sort the output so that jobs with the most people involved are shown first.
-- Q3 SOLUTION --
SELECT department_id AS "Dept#",
  job_id AS "Job",
  COUNT(employee_id) AS "How Many"
    FROM employees
    GROUP BY department_id, job_id
    HAVING COUNT(employee_id)>0
    ORDER BY "How Many" DESC;
    
-- Question 4.	For each job title display the job title and total amount paid each month for this type of the job. Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $12,000.  Sort the output so that top paid jobs are shown first.
-- Q4 SOLUTION --
SELECT job_id AS "Job Title",
  to_char(SUM(salary),'$999,999.99') AS "Total Salary"
    FROM employees
    WHERE job_id NOT IN ('AD_PRES', 'AD_VP')
    GROUP BY job_id
    HAVING SUM(salary) > 12000.0
    ORDER BY SUM(salary) DESC;
-- Question 5.	For each manager number display how many persons he / she supervises. Exclude managers with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.  Sort the output so that manager numbers with the most supervised persons are shown first.
-- Q5 SOLUTION -- 
SELECT manager_id AS "Manager#",
  COUNT(manager_id) AS "How Many"
    FROM employees
    WHERE manager_id NOT IN (100, 101, 102)
    GROUP BY manager_id
    HAVING COUNT(manager_id) > 2
    ORDER BY "How Many";
-- Question 6.	For each department show the latest and earliest hire date, BUT
--- exclude departments 10 and 20 
--- exclude those departments where the last person was hired in this century. 
--- Sort the output so that the most recent, meaning latest hire dates, are shown first.
-- Q6 SOLUTION --
SELECT department_id AS "Department",
    to_char(MIN(hire_date),'fmMon ddth, yyyy') AS "Earliest Hire Date",
    to_char(MAX(hire_date), 'fmMon ddth, yyyy') AS "Latest Hire Date"
        FROM employees
        WHERE department_id NOT IN (10, 20)
        GROUP BY department_id
        HAVING MAX(hire_date) < to_date('01012001', 'ddmmyyyy')
        ORDER BY "Latest Hire Date" DESC;
    


