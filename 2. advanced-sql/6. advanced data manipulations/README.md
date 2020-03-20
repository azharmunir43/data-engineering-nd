## Advanced Data Manipulations

### DEFAULT Keyword

* We can use DEFAULT keyword for a column value when inserting or updating a column to it's default value. 
* We set the default value of a column while creating a table or modify it after the creation. 
* To use the DEFAULT keyword the column must have a default value in the data dictionary. 
* If we hard code the default value for a column in our application, without using DEFAULT, we will have to change this code when the default value changes. The DEFAULT keyword saves us from this unnecessary work. 
* With default option we don't need to find a column's default value from the data dictionary view. 

```sql
INSERT INTO departments (
	department_id
	,department_name
	,manager_id
	,location_id
	)
VALUES (
	310
	,'Temp Department '
	,DEFAULT
	,2000
	)
```

For Updates

```plsql
UPDATE departments 
SET manager_id = DEFAULT; 
```

### Multitable INSERT Statements 

- If we need to insert the same data into more than one table we can use multitable insert statements. 
- If we don't use multitable insert statements, we need to retrieve the same data for each insert statement and this will increase database workload unnecessarily. 
- Multitable insert statements will increase performance. 
- Multitable insert statements are generally used in data warehousing because you need to load a data into many tables regularly in data warehousing. 
- There are 4 types Of multitable insert statements: 
  - Unconditional INSERT Statement
  - Conditional INSERT ALL Statement
  - Conditional INSERT FIRST Statement
  - Pivoting INSERT Statement

#### Unconditional INSERT Statement