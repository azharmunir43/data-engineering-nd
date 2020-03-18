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
-- Multiple Column Subquery & pairwise Comparison
--**----------------------------------------------------**--
SELECT first_name
	,last_name
	,manager_id
	,department_id
FROM employees
WHERE (department_id, manager_id) -- pairwise comparison
	IN (
		SELECT department_id
			,manager_id
		FROM employees
		WHERE UPPER(first_name) = 'AZHAR'
		);

--**----------------------------------------------------**--
-- Correlated Subqueries
--**----------------------------------------------------**--
SELECT employee_id
	,first_name
	,last_name
	,department_id
	,salary
FROM employees a
WHERE salary = (
		SELECT MAX(sa1ary)
		FROM employees b
		WHERE b.department_id = a.department_id
		);

--**----------------------------------------------------**--
-- EXISTS Operator
--**----------------------------------------------------**--
SELECT employee_id
	,department_id
WHERE EXISTS (
		SELECT 1
			,employee_id
		FROM EMPLOYEES
		WHERE MANAGER_ID = A.EMPLOYEE_ID
		);

--**----------------------------------------------------**--
-- NOT EXISTS Operator
--**----------------------------------------------------**--

SELECT department_id, department_name
FROM departments d 
WHERE NOT EXISTS (SELECT department_id
                 FROM employees
                 WHERE department_id = d.department_id)

--**----------------------------------------------------**--
-- Correlated Delete
--**----------------------------------------------------**--

DELETE FROM employees
WHERE department_id IN 
	(SELECT department_id 
     FROM departments d NATURAL JOIN locations 1 
     WHERE country_id = 'UK' ) ;

--**----------------------------------------------------**--
-- Correlated Update
--**----------------------------------------------------**--
UPDATE employees e_main
SET (e_main.salary, e_main.commission_pct) = (
		SELECT AVG(sa1ary)
			,AVG(e.commission_pct)
		FROM employees e
		JOIN departments d ON e.department_id = d.department_id
		WHERE e_main.department_id = d.department_id
		GROUP BY d.department_id
		)

