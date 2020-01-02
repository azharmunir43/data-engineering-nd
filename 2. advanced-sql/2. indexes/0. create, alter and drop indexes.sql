--**---------------------------------------------------------------------------------**--
-- CREATE INDEX & See the benefit
--**---------------------------------------------------------------------------------**--

-- Let's check the cost of finding a row based on a NON Indexed column. 
-- Then compare it after creating index.

SELECT
    first_name
FROM
    employees
WHERE
    phone_number = '011.44.1344.619268'; -- Cost = 3

-- Now we Create Index on the basis of Phone Number

CREATE UNIQUE INDEX emp_phone_ix ON
    hr.employees (
        phone_number
    );

SELECT
    first_name
FROM
    employees
WHERE
    phone_number = '011.44.1344.619268'; -- Cost = 1

--**---------------------------------------------------------------------------------**--
-- CREATE INDEX (Multiple Columns)
--**---------------------------------------------------------------------------------**--

CREATE INDEX "HR"."EMP_NAME_IX" ON
    "HR"."EMPLOYEES" (
        "LAST_NAME",
        "FIRST_NAME"
    );

--**---------------------------------------------------------------------------------**--
-- CREATE Multiple Indexes for same column(s)
--**---------------------------------------------------------------------------------**--

-- We can alter an index to be invisible

ALTER INDEX emp_phone_ix INVISIBLE;

-- Now we can create another index for this column

CREATE BITMAP INDEX emp_phone_ix_bm ON
    hr.employees (
        phone_number
    );

--**----------------------------------------------------**--
-- Indexes with Functions (Example)
--**----------------------------------------------------**--

-- We already have index defined on the basis of First Name & Last Name

SELECT
    phone_number
FROM
    employees
WHERE
    first_name = 'John'; -- COST = 1

SELECT
    phone_number
FROM
    employees
WHERE
    upper(first_name) = 'JOHN'; -- COST = 3 * Indexes don't comply with Functions.
    
-- We need to do the following for such scenarios

CREATE UNIQUE INDEX emp_phone_ix ON
    hr.employees ( upper(first_name) );

--**----------------------------------------------------**--
-- DROP INDEX;
--**----------------------------------------------------**--

DROP INDEX emp_phone_ix;


--**----------------------------------------------------**--
-- DROP INDEX (Allow DML while Deletion)
--**----------------------------------------------------**--

DROP INDEX emp_phone_ix ONLINE;
