## Materialized Views

* While creating reports on our data in the database, generally, we need to write complex SQL queries with huge costs. And we may need use this query like a table and in many places of the report. 
* A solution for this is creating views. Creating view will prevent code crowd when we use this view instead of it's SQL code. 
* Even so, this will not reduce query, disc, network costs. 
* To reduce SQL costs, we use Materialized Views. 
* Materialized views are useful for reducing network loads and improving performance for retrieving data from another database. 
* Materialized Views are views beyond the normal view. 
* A materialized view has a stored SQL query like normal views and a table which keeps the returning data of the stored SQL query. 
* This table has the same name with the materialized view. 
* The materialized view refreshes this table on a specified time frequency or on demand. 
* When we query from this materialized view, Oracle Server returns the data in this table instead of the real tables in the stored SQL query. 
* Because this table is refreshed with a specific time it may not have the current data. 
* Using materialized view is a choice between performance and live-old data. 
* We can keep this data up to date with decreasing refresh time. 