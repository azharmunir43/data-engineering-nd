--**----------------------------------------------------**--
-- Views

-- CREATE [OR REPLACE] [FORCE INOFORCE] VIEW view_name [(alias[, alias]...)] AS subquery 
-- [WITH CHECK OPTION [CONSTRAINT constraint_name]] 
-- [WITH read only[constraint constraint_name]]; 

-- * REPLACE If we created a view with the same name before we need to write OR REPLACE clause to change the view without dropping or regranting privileges. 
-- * FORCE Creates the view even if base table does not exist. 
-- * NOFORCE Creates the view only if base table exist.(Default) 
-- * SUBQUERY SELECT Statement for the view. 
-- * WITH CHECK OPTION Check the relevant constraint while inserting or updating. 
-- * WITH READ ONLY Prevent any DML operation on this view. 
-- * Aliases can be used to rename columns of view.
--**-------------------------------------------------------------**--

--**----------------------------------------------------**--
-- Create VIEWS (Example)
--**----------------------------------------------------**--

CREATE OR REPLACE VIEW employees50 AS
    SELECT
        *
    FROM
        employees
    WHERE
        department_id = 50;

-- Slightly complex view

CREATE OR REPLACE VIEW departments_summary_v AS
    SELECT
        d.department_name,
        COUNT(e.employee_id) no_of_employees,
        MIN(e.salary) min_salary,
        MAX(e.salary) max_salary
    FROM
        employees     e
        LEFT JOIN departments   d USING ( department_id )
    GROUP BY
        d.department_name
    ORDER BY
        COUNT(e.employee_id) DESC;

--**----------------------------------------------------**--
-- Using VIEWS
--**----------------------------------------------------**--

SELECT
    *
FROM
    employees50; -- 45 rows, only from department id = 50
    
--**----------------------------------------------------**--
-- Inserting Data Via Views
--**----------------------------------------------------**--

INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date,
    job_id, manager_id, department_id
) VALUES (
    207, 'Azhar', 'Munir', 'AMUNIR', sysdate,
    'IT_PROG', 100, 50
);
-- Result : 1 row inserted

-- Can we insert data for other departments?

INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date, 
    job_id, manager_id, department_id
) VALUES (
    208, 'Azhar','Munir', 'AZHARMUNIR', sysdate,
    'IT_PROG', 100, 30
);

-- Result : 1 row inserted

-- Same is the case for Null department ID, i.e. can be inserted.

--**----------------------------------------------------**--
-- Updating Data Via Views
--**----------------------------------------------------**--

UPDATE employees50
SET first_name = 'Muhammad Azhar'
WHERE employee_id = 208;
-- Result = 0 row updated.
 
UPDATE employees50
SET first_name = 'Muhammad Azhar'
WHERE employee_id = 207

-- Result = 1 row updated.

--**----------------------------------------------------**--
-- Controlling DML on views
--**----------------------------------------------------**--

-- In order to control insertion, we need to use WITH CHECK OPTION;

CREATE OR REPLACE VIEW employees50 AS
    SELECT
        *
    FROM
        employees
    WHERE
        department_id = 50
    WITH CHECK OPTION;

INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date, 
    job_id, manager_id, department_id
) VALUES (
    209,
    'Azhar',
    'Munir',
    'AMUNIR2',
    sysdate,
    'IT_PROG',
    100,
    50
);
-- Result : 1 row inserted

-- Can we insert data for other departments?

INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date, 
    job_id, manager_id, department_id
) VALUES (
    210,
    'Azhar','Munir',
    'AZHARMUNIR2',
    sysdate,
    'IT_PROG',
    100,
    30
);
-- Result :  view WITH CHECK OPTION where-clause violation


-- Or we canmake views readonly.




