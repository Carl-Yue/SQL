CREATE VIEW DepartmentEmployeeCount_View AS
    SELECT d.department_name 'DEPARTMENT', COUNT(e.employee_id) '# of Employees' 
    FROM rob.departments d JOIN rob.employees e
    ON d.department_id = e.department_id
    GROUP BY department_id
    ORDER BY d.department_name;