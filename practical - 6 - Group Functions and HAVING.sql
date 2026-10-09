-- Practical 6: To use group functions along with GROUP BY and HAVING clauses
-- for aggregated data analysis.
USE dbms_lab;

-- 14. Query 1 & 2: Deposit sum after a given date; deposit sum for customers
--     living in Nagpur
SELECT SUM(AMOUNT)
FROM DEPOSIT
WHERE ADATE > '1996-01-01';

SELECT SUM(D.AMOUNT)
FROM DEPOSIT D
JOIN CUSTOMERS C ON D.CNAME = C.CNAME
WHERE C.CITY = 'NAGPUR';

-- 15. Query 3, 4 & 5: Maximum deposit in Bombay; rounded aggregate functions;
--     salary range
SELECT MAX(D.AMOUNT)
FROM DEPOSIT D
JOIN CUSTOMERS C ON D.CNAME = C.CNAME
WHERE C.CITY = 'BOMBAY';

SELECT ROUND(MAX(emp_sal), 0) AS 'Maximum',
       ROUND(MIN(emp_sal), 0) AS 'Minimum',
       ROUND(SUM(emp_sal), 0) AS 'Sum',
       ROUND(AVG(emp_sal), 0) AS 'Average'
FROM Employee;

SELECT (MAX(emp_sal) - MIN(emp_sal)) AS 'DIFFERENCE'
FROM Employee;

-- 16. Query 6 & 7: Employee count by hire year; average salary by department
SELECT COUNT(*) AS 'Total Employees',
       SUM(CASE WHEN YEAR(NOW()) = 1995 THEN 1 ELSE 0 END) AS 'Hired 1995',
       SUM(CASE WHEN YEAR(NOW()) = 1996 THEN 1 ELSE 0 END) AS 'Hired 1996'
FROM Employee;

SELECT AVG(emp_sal)
FROM Employee
GROUP BY dept_no;

-- 17. Query 8, 9 & 10: Group by department and job; HAVING average salary
--     > 2000; HAVING total salary > 3000
-- NOTE: Employee has no job_id column, so the first and last queries give
-- ERROR 1054 (Unknown column 'job_id') exactly as in your manual's output.
-- To make them run:  ALTER TABLE Employee ADD job_id VARCHAR(15);
SELECT dept_no, job_id, SUM(emp_sal)
FROM Employee
GROUP BY dept_no, job_id;

SELECT AVG(emp_sal)
FROM Employee
GROUP BY dept_no
HAVING AVG(emp_sal) > 2000;

SELECT job_id, SUM(emp_sal) AS 'Total Salary'
FROM Employee
WHERE job_id <> 'PRESIDENT'
GROUP BY job_id
HAVING SUM(emp_sal) > 3000
ORDER BY SUM(emp_sal) ASC;
