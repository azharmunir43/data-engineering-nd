## Advanced Subqueries 

### Inline Views

```sql
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
```

In this query, we created an inline view for a subset of Departments table.

### Scaler Subqueries

A scalar subquery is a subquery that selects only one column or expression and returns one row. A scalar subquery can be used anywhere in an SQL query that a column or expression can be used.

A scalar subquery can be used in the following contexts:
* The select list of a query (that is, the expressions between the SELECT and FROM keywords)
* In a WHERE or ON clause of a containing query
* The JOIN clause of a query
* WHERE clause that contains CASE, IF, COALESCE, and NULLIF expressions
* Source to an UPDATE statement when the subquery refers to more than the modified table
* Qualifier to a DELETE statement where the subquery identifies the rows to delete
* The VALUES clause of an INSERT statement
* As an operand in any expression

```sql
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
```

#### Multiple Column Subqueries

We can also use multiple columns, pairwise in subqueries as : -

```sql
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

```

### Correlated Subqueries

* When a subquery references a columns from the parent query it is called as correlated subquery. 
* In normal subqueries, the subquery is executed first and the result is used in parent query. 
* In correlated subqueries, from the main query a candidate row is selected and used with correlated subquery, and then the result of subquery is used by the main query. 
* This operation repeats until all candidate rows are used. 
* We can use correlated subqueries with logical operators (<, =, ), IN, ANY, ALL operators. 
* For example: Let's try to find the employees who earn the maximum salary Of their departments. 

```sql
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

```

### EXISTS Operator

* We use EXISTS operator to check the existence Of the subquery. 
* EXISTS operator is used with correlated subqueries generally. 
* If the subquery returns at least one row, the operator returns true and the search does not continue in the subquery. *[Important]*
* The subquery does not need to return a specific value. It can be a constant, null or a column value. 
*    The subquery can return more than one value. 
* Let's try to find the managers using EXIST operator. 

```sql
SELECT employee_id
	,department_id
WHERE EXISTS (
		SELECT 1
			,employee_id
		FROM EMPLOYEES
		WHERE MANAGER_ID = A.EMPLOYEE_ID
		);

```

Similarly, NOT EXISTS operator can be used to test whether there is no row in subquery for a candidate row in main query.

```sql
SELECT department_id, department_name
FROM departments d 
WHERE NOT EXISTS (SELECT department_id
                 FROM employees
                 WHERE department_id = d.department_id)
```

### WITH Clause

* When a query has many references to a same query block or there are joins and aggregation functions, we can use WITH clause to improve performance and increase readability. 
* We use WITH clause when a costly query is used more than once within a complex query. 
* WITH clause retrieves the result Of a query block and stores it in the users temporary tablespace and retrieves data from this tablespace instead of retrieving from base tables. 
* WITH clause can have more than one query. If so, each query is separated by a comma (,). 

```plsql
WITH employees50 AS (
    SELECT
        *
    FROM
        employees
    WHERE department_id = 50
)
SELECT
    *
FROM
    employees50;
```

### Recursive WITH clause

* We use recursive WITH clause to enable formulation of recursive queries. 
* Recursive WITH clause can be used to retrieve hierarchical data like organization charts. 
* Recursive WITH clause contains two types of query block members which are anchor and recursive members. 
* Anchor members can be composed with set operators (UNION, UNION ALL INTERSECT, MINUS). 
* Anchor member and a recursive member can be combined with just UNION ALL set operator. 
* Let's try to find all the hierarchical managers of all employees; 

```plsql
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
```

### Correlated Delete

* We can use correlated subqueries to remove rows from a table based on another table's rows. 

```plsql
DELETE FROM tablel aliasl 
WHERE column operator 
	(SELECT expression 
     FROM table2 alias2 
     WHERE aliasl.column = alias2. column
); 
```

* Let's try to delete all the employees whose country is 'UK'. 

```sql
DELETE FROM employees
WHERE department_id IN 
	(SELECT department_id 
     FROM departments d NATURAL JOIN locations 1 
     WHERE country_id = 'UK' ) ;
```

### Correlated Update

* We can use correlated subqueries to update a table from another table. 
* Let's try to update each employee's salary and commission percentage to his or her departments average salary and commission percentages.

```sql
UPDATE employees e_main
SET (e_main.salary, e_main.commission_pct) = (
		SELECT AVG(sa1ary)
			,AVG(e.commission_pct)
		FROM employees e
		JOIN departments d ON e.department_id = d.department_id
		WHERE e_main.department_id = d.department_id
		GROUP BY d.department_id
		)
```

