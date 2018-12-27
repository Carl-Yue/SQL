--------------------------------------------------------------------------------------------------------------------------------
-- Name: Shujing Yue
-- Student#: 122072176
-- Date: June 14, 2018
-- Purpose: DBS301 Lab 06
--------------------------------------------------------------------------------------------------------------------------------

-- Question 1.	SET AUTOCOMMIT ON (do this each time you log on) so any updates, deletes and inserts are automatically committed before you exit from Oracle.
-- Question 2.	Create an INSERT statement to do this.  Add yourself as an employee with a NULL salary, 0.2 commission_pct, in department 90, and Manager 100.  You started TODAY.
-- Q2 SOLUTION --
INSERT INTO employees
    (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
    VALUES(207, 'Shujing', 'Yue', 'syue9@myseneca.ca', '647.111.1111', to_date('2018/06/14', 'yyyy/mm/dd'), 'IT_PROG', null, 0.2, 100, 90);
-- Question 3.	Create an Update statement to: Change the salary of the employees with a last name of Matos and Whalen to be 2500.
-- Q3 SOLUTION --
UPDATE employees
    SET salary = 2500
    WHERE last_name IN (Matos, Whalen);
-- Question 4.	Display the last names of all employees who are in the same department as the employee named Abel.
-- Q4 SOLUTION --
SELECT last_name
    FROM employees
    WHERE department_id = 
        (SELECT department_id
        FROM employees
        WHERE last_name = 'Abel');
-- Question 5.	Display the last name of the lowest paid employee(s)
-- Q5 SOLUTION --
SELECT last_name
    FROM employees
    WHERE salary = 
        (SELECT min(salary)
            FROM employees);
-- Question 6.	Display the city that the lowest paid employee(s) are located in.
-- Q6 SOLUTION --
SELECT city
    FROM locations
    WHERE location_id =
        (SELECT location_id
            FROM departments
            WHERE department_id = 
                (SELECT department_id
                    FROM employees
                    WHERE salary = 
                        (SELECT min(salary)
                            FROM employees)));
-- Question 7.	Display the last name, department_id, and salary of the lowest paid employee(s) in each department.  Sort by Department_ID. (HINT: careful with department 60)
-- Q7 SOLUTION --
SELECT last_name AS "Last Name", department_id AS "Department ID", to_char(salary,'$999,999.99') AS "Salary"
    FROM employees
    WHERE salary IN 
        (SELECT min(salary)
            FROM employees
            GROUP BY department_id)
    ORDER BY department_id;
-- Question 8.	Display the last name of the lowest paid employee(s) in each city
-- Q8 SOLUTION --
SELECT e.last_name AS "Last Name",
    l.city AS "City"
    FROM (employees e JOIN departments d
            ON e.department_id = d.department_id)
            JOIN locations l ON l.location_id = d.location_id
    WHERE salary IN
        (SELECT MIN(e.salary)
            FROM (employees e JOIN departments d
            ON e.department_id = d.department_id)
            JOIN locations l ON l.location_id = d.location_id
            GROUP BY city);
-- Question 9.	Display last name and salary for all employees who earn less than the lowest salary in ANY department.  Sort the output by top salaries first and then by last name.
-- Q9 SOLUTION --
SELECT last_name AS "Last Name",
    to_char(salary, '$999,999.99') AS "Salary"
    FROM employees
    WHERE salary < ANY
        (SELECT MIN(salary)
            FROM employees
            GROUP BY department_id)
    ORDER BY salary DESC, last_name;
-- Question 10.	Display last name, job title and salary for all employees whose salary matches any of the salaries from the IT Department. Do NOT use Join method.
-- Q10 SOLUTION --
SELECT last_name AS "Last Name", job_id AS "Job Title", 
    to_char(salary, '$999,999.99') AS "Salary"
    FROM employees
    WHERE salary = ANY
        (SELECT salary
            FROM employees
            WHERE job_id LIKE 'IT%')
    ORDER BY salary, last_name;
    
    
    