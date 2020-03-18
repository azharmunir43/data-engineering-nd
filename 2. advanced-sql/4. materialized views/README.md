## Materialized Views

* While creating reports on our data in the database, generally, we need to write complex SQL queries with huge costs. And we may need use this query like a table and in many places of the report. 
* A solution for this is creating views. Creating view will prevent code crowd when we use this view instead of it's SQL code. 
* Even so, this will not reduce query, disc, network costs. 
* To reduce SQL costs, we use Materialized Views. 
* Materialized views are useful for reducing network loads and improving performance for retrieving data from another database. 
* Materialized Views are views beyond the normal view. 
* A materialized view has a stored SQL query like normal views and a table which keeps the returning data of the stored SQL query. 
* This table has the same name as the materialized view. 
* The materialized view refreshes this table on a specified time frequency or on demand. 
* When we query from this materialized view, Oracle Server returns the data in this table instead of the real tables in the stored SQL query. 
* Because this table is refreshed with a specific time it may not have the current data. 
* Using materialized view is a choice between performance and live-old data. 
* We can keep this data up to date by decreasing refresh time. 

### Creating Materialized Views

```sql
CREATE MATERIALIZED VIEW view-name 
BUILD [IMMEDIATE | DEFERRED]
REFRESH [FAST | COMPLETE | FORCE ]
ON [COMMIT | DEMAND ] 
[[ENABLE | DISABLE] QUERY REWRITE ]
[ON PREBUILT TABLE] 
AS SELECT ...
```

- **BUILD IMMEDIATE** : Populates the MV immediately. 
* **BUILD DEFERRED**: Populates the MV on the first refresh request. 
* **REFRESH FAST** : Refresh the MV with just the changes of the existing data instead of repopulate entire MV. 
* **REFRESH COMPLETE**: The table of materialized is truncated and repopulated with the associated query. 
* **REFRESH FORCE**:A fast refresh is attempted. If fast refresh is not possible, complete refresh is performed. 
* **ON COMMIT**: The refresh is performed on a commit of any dependent tables. 
* **ON DEMAND**: The refresh is performed manually or a scheduled task. 
* **ENABLE QUERY REWRITE** : Allows the optimizer to use query rewrite option to improve performance for expensive and time consuming process of the associated SQL query. 
* **DISABLE QUERY REWRITE** : Disallows the optimizer for query rewriting. This option is default. 
* **ON PREBUILT TABLE** : Provides creating materialized view on an existing table. For example; this is useful if we lose the link between materialized view and it's table on database transportation. We can easily create materialized view on this table without recreating-refilling it. 
* **AS SELECT** : Query of the materialized view. The relevant table is populated with this query. It can be simple or complex query. 

**Example 1**

```sql
CREATE MATERIALIZED VIEW departments_summary_mv 
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND
AS
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

In this example we are using COMPLETE refresh option which actually truncates the table and reloads it every time a refresh is performed. However, we might want to use FAST refresh option which keeps track of  changes that have happened to base tables since the last refresh. For FAST refresh we need to configure materialized view logs on base tables. And if our view refers to multiple base tables, we need to configure logs on every table.

```sql
CREATE MATERIALIZED VIEW LOG on employees;
```

### Refreshing Materialized Views

We can refresh a materialized view on demand (manually) or on commit. 

#### **Refreshing Materialized Views Manually** 

We can refresh materialized views manually in multiple ways. 

 * We can use DBMS_MVlEW.REFRESH ( mview_name,refresh_type) procedure. 
    * Refresh Types : F (Force) , C (Complete) 

    * ```sql
      EXECUTE DBMS_MVIEW.REFRESH(departments_summary_mv2, 'F')
      ```

 * We can use DBMS_SNAPSHOT package instead of DBMS_MVIEW. Actually, DBMS_MVIEW is just a synonym for DBMS_SNAPSHOT. 

 * We can refresh all materialized views in the system if we have ALTER ANY MATERIALIZED VIEW system privilege with using the code below. 

  ```sql
  DECLARE 
  FAILURES NUMBER; -- Variable to count failures
  BEGIN 
  	DBMS_MVIEW.REFRESH_ALL_WIEWS (failures, 'C' , ' ' , TRUE, FALSE,FALSE)
  END
  ```

 * There are several overloads for REFRESH and REFRESH_ALL_MVIEWS procedures.

We can schedule refresh of materialized views as well.