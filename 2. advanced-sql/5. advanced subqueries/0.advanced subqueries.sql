--**----------------------------------------------------**--
-- INLINE Views (Example)
--**----------------------------------------------------**--
SELECT
    *
FROM
    employees e
    INNER JOIN (
        SELECT
            *
        FROM
            departments
        WHERE
            department_name IN (
                'Marketing',
                'HR'
            )
    ) d ON d.department_id = e.department_id;

--**----------------------------------------------------**--
-- Scaler Subquery (Example)
--**----------------------------------------------------**--

SELECT
    (
        SELECT
            MAX(salary)
        FROM
            employees
        WHERE
            department_id = e.department_id
    ) AS dept_highest_salary,
    first_name AS employee_name,
    (
        SELECT
            department_name
        FROM
            departments
        WHERE
            department_id = e.department_id
    ) dept_name
FROM
    employees e;


--**----------------------------------------------------**--
-- Scaler Subquery with CASE Statement (Example)
--**----------------------------------------------------**--

SELECT
    employee_id,
    first_name,
    last_name,
    (
        CASE
            WHEN location_id = (
                SELECT
                    location_id
                FROM
                    locations
                WHERE
                    postal_code = '99236'
            ) THEN
                'San Franscisco'
            ELSE
                'Outside'
        END
    ) country
FROM
    employees     e
    NATURAL JOIN departments   d;
    
    
    
--**----------------------------------------------------**--
-- 
--**----------------------------------------------------**--