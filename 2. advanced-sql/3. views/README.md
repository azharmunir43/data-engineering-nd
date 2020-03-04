## Views

### What is a View and why is it used? 

* A view is a schema object formed of a stored SELECT statement based on a table or another view. 
* The view is stored in the data dictionary as a SELECT statement. 
* There is no data in a view. We can think a view as a window that we can view or change in a table. 
* The tables that views are based on are called based tables. 
* Views are used for: 
  * Restricting access to data, 
  * Making complex queries easy and readable, 
  * Present different views of the same data. 
  * Provide schema knowledge independence / abstraction (search from a view without knowing exact tables)

### Creating Views

```sql 
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[, alias]...)] AS subquery 
[WITH CHECK OPTION] 
[WITH READ ONLY]; 
```

* REPLACE If we created a view with the same name before we need to write OR REPLACE clause to change the view without dropping or regranting privileges. 
* FORCE Creates the view even if base table does not exist. 
* NOFORCE Creates the view only if base table exist.(Default) 
* SUBQUERY SELECT Statement for the view. 
* WITH CHECK OPTION Check the relevant constraint while inserting or updating. 
* WITH READ ONLY Prevent any DML operation on this view. 

**Example 1**

```sql
CREATE OR REPLACE VIEW Employees50 AS
SELECT * FROM employees WHERE department_id = 50;
```

**Example 2**

```sql
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
```

USER_VIEWS dictionary view can be queried to explore details about all views.

### Performing DML on Views

Usually we can perform DML Operations with simple views. We can not perform DML Operations if the view includes: 

* Group functions 
* GROUP BY clause 
* DISTINCT keyword 
* ROWNUM keyword 
* NOT NULL columns (if NOT NULL column does not have a default value) 
* Columns defined by expressions. 
* WITH READ ONLY keyword. 

#### Insertion

If a view is defined without **WITH READ ONLY** check, DML operations can be performed on it. For example in above view *Employees50*, it is possible to insert following data.

```sql
INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date,
    job_id, manager_id, department_id
) VALUES (
    207, 'Azhar', 'Munir', 'AMUNIR', sysdate,
    'IT_PROG', 100, 50
);
```

And if **WITH CHECK OPTION** isn't configured as well, we can insert rows for any other department or in fact rows with NULL department ID can also be inserted. 

```sql
INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date,
    job_id, manager_id, department_id
) VALUES (
    208,
    'Azhar','Munir', 'AZHARMUNIR', sysdate,
    'IT_PROG', 100, 30
);
```

#### Updates

Since we created view only for employees belonging to department id 50, so we can update employees belonging to that department only.

```sql
UPDATE employees50
SET first_name = 'Muhammad Azhar'
WHERE employee_id = 208;
```

*Result : 0 rows updated.*

But when we try to update employee from department id 50, we get the row updated successfully.

```sql
UPDATE employees50
SET first_name = 'Muhammad Azhar'
WHERE employee_id = 207;
```

*Result : 1 row updated.*

#### How to control DML on views?

As long as updates are concerned, we are good because we can not change data that does not belong to that view. However, for insertions we can use WITH CHECK OPTION.

```sql
CREATE OR REPLACE VIEW Employees50 AS
SELECT * FROM employees WHERE department_id = 50
WITH CHECK OPTION;
```

Now when we insert with department id 50

```sql
INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date,
    job_id, manager_id, department_id
) VALUES (
    209, 'Azhar', 'Munir', 'AMUNIR2', sysdate,
    'IT_PROG', 100, 50
);
```

*Result : 1 row inserted.*

But when we try some other department id, let's say, 30.

```sql
INSERT INTO employees50 (
    employee_id, first_name, last_name, email, hire_date,
    job_id, manager_id, department_id
) VALUES (
    210,
    'Azhar','Munir', 'AZHARMUNIR2', sysdate,
    'IT_PROG', 100, 30
);
```

*Result : view WITH CHECK OPTION where-clause violation*

Alternatively we can configure view to be just read only using WITH READ ONLY.

### Dropping Views

```sql
DROP VIEW employees50;
```
