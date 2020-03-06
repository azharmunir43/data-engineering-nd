## Advanced Subqueries 

#### Inline Views

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

#### Scaler Subqueries

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

