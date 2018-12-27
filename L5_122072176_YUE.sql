--------------------------------------------------------------------------------
-- Name: Shujing Yue
-- Student#: 122072176
-- Date: June 7, 2018
-- Purpose: Lab 5 DBS301
--------------------------------------------------------------------------------

-- Part-A Simple Joins
-- Question 1.	Display the department name, city, street address and postal code for departments sorted by city and department name.
-- Q1 Solution:
SELECT d.department_name AS "Department Name", 
  l.city AS "City", 
  l.street_address AS "Street Address", 
  l.postal_code AS "Postal Code"
    FROM locations l JOIN departments d
      ON d.location_id = l.location_id
    ORDER BY l.city, d.department_name;
-- Question 2.	Display full name of employees as a single field using format of Last, First, their hire date, salary, department name and city, but only for departments with names starting with an A or S sorted by department name and employee name. 
-- Q2 Solution:
SELECT e.last_name || ', ' || e.first_name AS "Employee Name",
  e.hire_date AS "Hire Date",
  to_char((e.salary),'$999,999.99') AS "Salary",
  d.department_name AS "Department Name",
  l.city AS "City"
    FROM (employees e JOIN departments d
      ON e.department_id = d.department_id)
      INNER JOIN locations l ON d.location_id = l.location_id
    WHERE UPPER(d.department_name) LIKE UPPER('A%')
      OR UPPER(d.department_name) LIKE UPPER('C%')
    ORDER BY 4, 1;
-- Question 3.	Display the full name of the manager of each department in states/provinces of Ontario, California and Washington along with the department name, city, postal code and province name.   Sort the output by city and then by department name.
-- Q3 Solution:
SELECT e.last_name || ', ' || e.first_name AS "Manager Name",
  d.department_name AS "Department Name",
  l.city AS "City",
  l.postal_code AS "Postal Code",
  l.state_province AS "Province Name"
      FROM (employees e JOIN departments d
        ON d.manager_id = e.employee_id)
        INNER JOIN locations l ON d.location_id = l.location_id
      WHERE state_province IN ('Ontario', 'California', 'Washington')
      ORDER BY 3, 2;
-- Question 4.	Display employee’s last name and employee number along with their manager’s last name and manager number. Label the columns Employee, Emp#, Manager, and Mgr# respectively.
-- Q4 Solution:
SELECT e.last_name AS "Employee",
    e.employee_id AS "Emp#",
    ex.last_name AS "Manager",
    e.manager_id AS "Mgr#"
        FROM employees e JOIN (SELECT * FROM employees) ex
            ON e.manager_id = ex.employee_id;

-- Part-B – Non-Simple Joins
-- Question 5.	Display the department name, city, street address, postal code and country name for all Departments. Use the JOIN and USING form of syntax.  Sort the output by department name descending.
-- Q5 Solution:
SELECT d.department_name AS "Department Name",
    l.city AS "City",
    l.street_address AS "Street Address",
    l.postal_code AS "Postal Code",
    c.country_name AS "Country Name"
        FROM (departments d LEFT OUTER JOIN locations l
            USING (location_id))
            INNER JOIN countries c USING (country_id)
        ORDER BY 1 DESC;
-- Question 6.	Display full name of the employees, their hire date and salary together with their department name, but only for departments which names start with A or S. Full name should be in format of:
-- a.	First / Last. Use the JOIN and ON form of syntax.
-- b.	Sort the output by department name and then by last name.
-- Q6 Solution:
SELECT e.first_name || ' ' || e.last_name AS "Full Name",
    e.hire_date AS "Hire Date",
    e.salary AS "Salary",
    d.department_name AS "Department Name"
        FROM employees e LEFT OUTER JOIN departments d
            ON e.department_id = d.department_id
        WHERE UPPER(d.department_name) LIKE UPPER('A%')
            OR UPPER(d.department_name) LIKE UPPER('S%')
        ORDER BY d.department_name, e.last_name;
-- Question 7.	Rewrite the previous question by using Standard (Old -- prior to Oracle9i) Join method.
-- Q7 Solution:
SELECT e.first_name || ' / ' || e.last_name AS "Full Name",
    e.hire_date AS "Hire Date",
    e.salary AS "Salary",
    d.department_name AS "Department Name"
        FROM employees e, departments d
        WHERE e.department_id(+) = d.department_id
            AND (UPPER(d.department_name) LIKE UPPER('A%')
            OR UPPER(d.department_name) LIKE UPPER('S%'))
        ORDER BY d.department_name, e.last_name;
-- Question 8.	Display full name of the manager of each department in provinces Ontario, California and Washington plus department name, city, postal code and province name. Full name should be in format as follows:
-- a.	Last, First.  Use the JOIN and ON form of syntax.
-- b.	Sort the output by city and then by department name. 
-- Q8 Solution:
SELECT e.last_name || ', ' || e.first_name AS "Manager Name",
    d.department_name AS "Department Name",
    l.city AS "City",
    l.postal_code AS "Postal Code",
    l.state_province AS "Province Name"
        FROM (employees e LEFT OUTER JOIN departments d
            ON e.employee_id = d.manager_id)
            INNER JOIN locations l ON d.location_id = l.location_id
        WHERE l.state_province IN ('Ontario', 'California', 'Washington')
        ORDER BY l.city, d.department_name;
-- Question 9.	Rewrite the previous question by using Standard (Old -- prior to Oracle9i) Join method.
SELECT ed.last_name || ', ' || ed.first_name AS "Manager Name",
    ed.department_name AS "Department Name",
    l.city AS "City",
    l.postal_code AS "Postal Code",
    l.state_province AS "Province Name"
        FROM (SELECT * FROM employees e, departments d
            WHERE e.employee_id(+) = d.manager_id) ed, locations l
                WHERE ed.location_id = l.location_id
                AND l.state_province IN ('Ontario', 'California', 'Washington')
                AND (first_name IS NOT NULL AND last_name IS NOT NULL)
        ORDER BY l.city, ed.department_name;
-- Question 10.	Display the department name and Highest, Lowest and Average pay per each department. Name these results High, Low and Avg.
-- a.	Use JOIN and ON form of the syntax.
-- b.	Sort the output so that department with highest average salary are shown first.
SELECT d.department_name AS "Department Name",
    to_char(MAX(e.salary), '$999,999.99') AS "High",
    to_char(MIN(e.salary), '$999,999.99') AS "Low",
    to_char(AVG(e.salary), '$999,999.99') AS "Avg"
        FROM departments d LEFT OUTER JOIN employees e
            ON d.department_id = e.department_id
        WHERE e.salary IS NOT NULL
        GROUP BY department_name
        ORDER BY AVG(e.salary) DESC;
-- Question 11.	Display the employee last name and employee number along with their manager’s last name and manager number. Label the columns Employee, 
-- a.	Emp#, Manager, and Mgr#, respectively. Include also employees who do
-- b.	NOT have a manager and also employees who do NOT supervise anyone (or you could say managers without employees to supervise).
SELECT e.last_name AS "Employee",
    e.employee_id AS "Emp#",
    ex.last_name AS "Manager",
    e.manager_id AS "Mgr#"
     FROM employees e FULL OUTER JOIN (SELECT * FROM employees) ex
        ON e.employee_id = ex.manager_id;





    
    
    
    