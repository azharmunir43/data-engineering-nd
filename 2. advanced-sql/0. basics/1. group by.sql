--**----------------------------------------------------**--
-- AGGREGARTION FUNCTIONS
--**----------------------------------------------------**--
SELECT
    COUNT(employee_id) "Total Employees",
    MAX(salary) "Maximum Salary",
    MIN(salary) "Minimum Salary",
    AVG(salary) "Average Salary",
    MEDIAN(salary) "Median Salary"
FROM
    employees;

--**----------------------------------------------------**--
--  SQL GROUP BY & AGGREGARTION FUNCTIONS
--**----------------------------------------------------**--

SELECT
    department_id "Department ID", -- Every column in SELECT (When GROUP BY is used) should either be in GROUP By list or in agg
    COUNT(employee_id) "Total Employees",
    MAX(salary) "Maximum Salary",
    MIN(salary) "Minimum Salary",
    AVG(salary) "Average Salary",
    MEDIAN(salary) "Median Salary"
FROM
    employees
GROUP BY
    department_id;
