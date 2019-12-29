--------------------------------------------------------
--  DDL for Table EMPLOYEES
--------------------------------------------------------
CREATE TABLE "HR"."EMPLOYEES" (
    "EMPLOYEE_ID"      NUMBER(6, 0),
    "FIRST_NAME"       VARCHAR2(20 BYTE),
    "LAST_NAME"        VARCHAR2(25 BYTE),
    "EMAIL"            VARCHAR2(25 BYTE),
    "PHONE_NUMBER"     VARCHAR2(20 BYTE),
    "HIRE_DATE"        DATE,
    "JOB_ID"           VARCHAR2(10 BYTE),
    "SALARY"           NUMBER(8, 2),
    "COMMISSION_PCT"   NUMBER(2, 2),
    "MANAGER_ID"       NUMBER(6, 0),
    "DEPARTMENT_ID"    NUMBER(4, 0)
)

COMMENT ON COLUMN "HR"."EMPLOYEES"."EMPLOYEE_ID" IS
    'Primary key of employees table.';

COMMENT ON COLUMN "HR"."EMPLOYEES"."FIRST_NAME" IS
    'First name of the employee. A not null column.';

COMMENT ON COLUMN "HR"."EMPLOYEES"."LAST_NAME" IS
    'Last name of the employee. A not null column.';

COMMENT ON COLUMN "HR"."EMPLOYEES"."EMAIL" IS
    'Email id of the employee';

COMMENT ON COLUMN "HR"."EMPLOYEES"."PHONE_NUMBER" IS
    'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN "HR"."EMPLOYEES"."HIRE_DATE" IS
    'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN "HR"."EMPLOYEES"."JOB_ID" IS
    'Current job of the employee; foreign key to job_id column of the jobs table. A not null column.';

COMMENT ON COLUMN "HR"."EMPLOYEES"."SALARY" IS
    'Monthly salary of the employee. Must be greater than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN "HR"."EMPLOYEES"."COMMISSION_PCT" IS
    'Commission percentage of the employee; Only employees in sales department elgible for commission percentage';

COMMENT ON COLUMN "HR"."EMPLOYEES"."MANAGER_ID" IS
    'Manager id of the employee; has same domain as manager_id in departments table. Foreign key to employee_id 
    column of employees table. (useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN "HR"."EMPLOYEES"."DEPARTMENT_ID" IS
    'Department id where employee works; foreign key to department_idcolumn of the departments table';

COMMENT ON TABLE "HR"."EMPLOYEES" IS
    'employees table. Contains 107 rows. References with departments, jobs, job_history tables. Contains a self reference.';

--------------------------------------------------------
--  Constraints for Table EMPLOYEES
--------------------------------------------------------

ALTER TABLE "HR"."EMPLOYEES" MODIFY (
    "LAST_NAME"
        CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE
);

ALTER TABLE "HR"."EMPLOYEES" MODIFY (
    "EMAIL"
        CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE
);

ALTER TABLE "HR"."EMPLOYEES" MODIFY (
    "HIRE_DATE"
        CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE
);

ALTER TABLE "HR"."EMPLOYEES" MODIFY (
    "JOB_ID"
        CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE
);

ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_SALARY_MIN" CHECK ( salary > 0 ) ENABLE;

ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_EMAIL_UK" UNIQUE ( "EMAIL" );
  
--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEES
--------------------------------------------------------

ALTER TABLE "HR"."EMPLOYEES"
    ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ( "DEPARTMENT_ID" )
        REFERENCES "HR"."DEPARTMENTS" ( "DEPARTMENT_ID" )
    ENABLE;

ALTER TABLE "HR"."EMPLOYEES"
    ADD CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ( "JOB_ID" )
        REFERENCES "HR"."JOBS" ( "JOB_ID" )
    ENABLE;

ALTER TABLE "HR"."EMPLOYEES"
    ADD CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ( "MANAGER_ID" )
        REFERENCES "HR"."EMPLOYEES" ( "EMPLOYEE_ID" )
    ENABLE;
-- While defining these ref constraints we can configure what happens when something happens to parent, i.e. CASCADE etc.            
--------------------------------------------------------
--  DROP Table Structure & Data (AUTOCOMMIT)
--------------------------------------------------------

DROP TABLE employees;

--------------------------------------------------------
--  INSERT Data INTO Employees
--------------------------------------------------------

-- Since we configured Job ID in Employees table to be NOT NULL, we need a Job first, let's say its 1. We do need a Manager ID 
-- as well normally, but since it is NULLABLE, that's we can skip it.

INSERT INTO employees VALUES (
    1,
    'Azhar',
    'Munir',
    'azharmunir123@gmail.com',
    '+923059409933',
    '3-July-2017',
    1
);

--------------------------------------------------------
--  Deleting Data only (AUTOCOMMIT)
--------------------------------------------------------

TRUNCATE TABLE employees;

--------------------------------------------------------
--  Reading Data From Employees table
--------------------------------------------------------

SELECT
    * -- All Columns (Not a good practice)
FROM
    employees;

SELECT
    employee_id -- ONLY Required Columns
FROM
    employees; 
--------------------------------------------------------
--  WHERE & ORDER BY
--------------------------------------------------------

SELECT
    employee_id
FROM
    employees
WHERE
    employee_id = 1    -- ONLY Required Employee
    AND first_name = 'Azhar' -- Multiple Conditions Possible
    AND last_name LIKE 'M%'  -- CASE Sensitive By Default
ORDER BY
    hire_date ASC;  -- To Get in Particular order ASC | DESC, Conditions Possible

--------------------------------------------------------
--  CASE in SQL 
--------------------------------------------------------

SELECT
    CASE year(hire_date)
        WHEN '2019' THEN
            'Fresh'
        ELSE
            'Senior'
    END Seniority
FROM
    employees;

--------------------------------------------------------
--  Removing Selective Data only (NOT AUTOCOMMIT, Can be Rolled Back)
--------------------------------------------------------

DELETE FROM employees
WHERE
    employee_id = 1;

--------------------------------------------------------
--  Updating Selective Data only 
--------------------------------------------------------

UPDATE employees
SET
    job_id = 2
WHERE
    employee_id = 1;