--**-------------------------------------------------------------**--
-- Common Table Expressions (CTEs)

--   A common table expression (CTE) is a named temporary result set 
--   that exists within the scope of a single statement and that can be 
--   referred to later within that statement, possibly multiple times.
--**-------------------------------------------------------------**--
WITH cte AS (
    SELECT
        *
    FROM
        employees
)
SELECT
    *
FROM
    cte;

--**----------------------------------------------------**--
-- Example Exercise (Recursive CTE) - Complete Employee Hierarchy
--**----------------------------------------------------**--

WITH emp_cte (
    employee_id,
    first_name,
    manager_id
) AS (
    SELECT
        employees.employee_id,
        employees.first_name,
        employees.manager_id
    FROM
        employees
    WHERE
        employees.employee_id = 150
    UNION ALL
    SELECT
        e.employee_id,
        e.first_name,
        e.manager_id
    FROM
        employees   e
        INNER JOIN emp_cte     c ON e.employee_id = c.manager_id
)
SELECT
    c1.first_name "Employee Name",
    CASE
        WHEN c2.first_name IS NULL THEN
            'No Boss'
        ELSE
            c2.first_name
    END "Manager Name"
FROM
    emp_cte   c1
    LEFT JOIN emp_cte   c2 ON c1.manager_id = c2.employee_id;