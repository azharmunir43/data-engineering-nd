


--**-------------------------------------------------------------**--
-- Materialized Views


-- CREATE MATERIALIZED VIEW view-name 
-- BUILD [IMMEDIATE | DEFERRED]
-- REFRESH [FAST | COMPLETE | FORCE ]
-- ON [COMMIT | DEMAND ] 
-- [[ENABLE | DISABLE] QUERY REWRITE ]
-- [ON PREBUILT TABLE] 
-- AS SELECT ...

-- * BUILD IMMEDIATE : Populates the MV immediately. 
-- * BUILD DEFERRED: Populates the MV on the first refresh request. 
-- * REFRESH FAST : Refresh the MV with just the changes of the existing data instead of repopulate entire MV. 
-- * REFRESH COMPLETE: The table of materialized is truncated and repopulated with the associated query. 
-- * REFRESH FORCE:A fast refresh is attempted. If fast refresh is not possible, complete refresh is performed. 
-- * ON COMMIT: The refresh is performed on a commit of any dependent tables. 
-- * ON DEMAND: The refresh is performed manually or a scheduled task. 
-- * ENABLE QUERY REWRITE : Allows the optimizer to use query rewrite option to improve performance for expensive and time consuming process of the associated SQL query. 
-- * DISABLE QUERY REWRITE : Disallows the optimizer for query rewriting. This option is default. 
-- * ON PREBUILT TABLE : Provides creating materialized view on an existing table. For example; this is useful if we lose the link between materialized view and it's table on database transportation. We can easily create materialized view on this table without recreating-refilling it. 
-- * AS SELECT : Query of the materialized view. The relevant table is populated with this query. It can be simple or complex query. 

--**-------------------------------------------------------------**--


--**----------------------------------------------------**--
-- Create Materialized View (Example)
--**----------------------------------------------------**--


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