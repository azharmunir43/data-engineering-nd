--**----------------------------------------------------**--
-- Window Functions

--   A GROUP BY combined with aggregation compacts result in
--   one row. However, window function can be used to produce
--   result for each row.
--**----------------------------------------------------**--
SELECT
    employee_id,
    first_name,
    salary,
    department_id,
    AVG(salary) OVER() ovrall_avg_sal,
    AVG(salary) OVER(
        PARTITION BY department_id
    ) dpartment_avg_sal
FROM
    employees;

--**----------------------------------------------------**--
-- NOTES
--**----------------------------------------------------**--

--* Each window operation in the query is signified by inclusion of an OVER clause that specifies how to 
--  partition query rows into groups for processing by the window function:
--*    * The first OVER clause is empty, which treats the entire set of query rows as a single partition. 
--       The window function thus produces a global average, but does so for each row.
--*    * The second OVER clause partitions rows by department, producing a sum per partition (per deparment). 
--       The function produces this average for each partition row.


--** OTHER AGG FUNCTIONS include MIN, MAX, SUM etc. However SQL Server and MySQL also support some interesting functions like:
--              * RANK()
--              * DENSE_RANK()
--              * ROW_NUMBER()
