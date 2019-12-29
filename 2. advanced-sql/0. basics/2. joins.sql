--**----------------------------------------------------**--
-- CROSS JOIN - Just A X B (Does not involve condition)
--**----------------------------------------------------**--

-- 107 Employees
-- 27 Departments

SELECT
    COUNT(*) -- 107 * 27 = 2889 Rows
FROM
    employees     emp,
    departments   dept;
    
SELECT
    COUNT(*) -- 27 * 107 = 2889 Rows
FROM
    departments   dept,
    employees     emp;
    

--**----------------------------------------------------**--
-- JOIN or INNER JOIN
--**----------------------------------------------------**--

-- 107 Employees
-- 27 Departments
SELECT
    COUNT(*) -- 106 Rows
FROM
    employees     emp
INNER JOIN
        departments   dept
    ON emp.department_id = dept.department_id;
    
-- We have 1 employee with NULL department ID 

--**----------------------------------------------------**--
-- LEFT or LEFT OUTER JOIN
--**----------------------------------------------------**--

-- 107 Employees
-- 27 Departments
SELECT
    COUNT(*) -- 107 Rows
FROM
    employees     emp
LEFT JOIN
        departments   dept
    ON emp.department_id = dept.department_id;
    
-- We have one employee with NULL department ID 

--**----------------------------------------------------**--
-- RIGHT or RIGHT OUTER JOIN
--**----------------------------------------------------**--

-- 107 Employees
-- 27 Departments but only 11 are referred in Employees

SELECT --*
    COUNT(*) 
    -- 122 Rows (106 rows for employees with empl, 16 rows for non-referred departments)
    -- Employee with NULL department ID will not be included
FROM
    employees     emp
RIGHT OUTER JOIN
        departments   dept
    ON emp.department_id = dept.department_id;

--**----------------------------------------------------**--
-- FULL or FULL OUTER JOIN
--**----------------------------------------------------**--

-- 107 Employees
-- 27 Departments but only 11 are referred in Employees

SELECT --*
    COUNT(*) 
    -- 123 Rows (107 rows for employees with empl, 16 rows for non-referred departments)
    -- Employee with NULL department ID will be included
FROM
    employees     emp
FULL OUTER JOIN
        departments   dept
    ON emp.department_id = dept.department_id;


--**----------------------------------------------------**--
-- SELF JOIN
--**----------------------------------------------------**--

SELECT
    emp.first_name "Emp Name",
    CASE WHEN mangr.first_name IS NULL THEN 'Super Manager' ELSE mangr.first_name END "Manager Name"
FROM
    employees     emp
LEFT JOIN
        employees     mangr
    ON emp.manager_id = mangr.employee_id;
    
--**----------------------------------------------------**--
-- Notes
--**----------------------------------------------------**--

-- * IF JOIN Operator is =, we call it an Equi Join
-- * IF JOIN Operator is NOT =, we call it an Non-Equi Join. Other operators can be <, >, BETWEEN etc.
-- * NATURAL JOIN
--      It is based on the two conditions :
--          the JOIN is made on all the columns with the same name for equality.
--          Removes duplicate columns from the result.

--      This seems to be more of theoretical in nature and as a result (probably) most DBMS don't even bother supporting this.