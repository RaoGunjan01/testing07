-- Practical 4: To study single-row functions in SQL.
USE dbms_lab;

-- 1. Query 1: Display the current date. Label the column Date
SELECT CURDATE() AS 'Date';

-- 2. Query 2: Employee number, salary and salary increased by 15%
--    (whole number). Label New Salary
SELECT emp_no, emp_sal,
       ROUND(emp_sal * 1.15, 0) AS 'New Salary'
    FROM Employee;

-- 3. Query 3: Add a column that subtracts the old salary from the new
--    salary. Label the column Increase
SELECT emp_no, emp_sal,
       ROUND(emp_sal * 1.15, 0) AS 'New Salary',
       ROUND(emp_sal * 1.15, 0) - emp_sal AS 'Increase'
    FROM Employee;

-- 4. Query 4: Employee names with first letter capitalized, rest lowercase,
--    and name length, for names starting with J, A or M
SELECT CONCAT(
           UPPER(LEFT(emp_name, 1)),
           LOWER(SUBSTRING(emp_name, 2))
       ) AS 'Formatted Name',
       LENGTH(emp_name) AS 'Length'
    FROM Employee
    WHERE emp_name LIKE 'J%'
       OR emp_name LIKE 'A%'
       OR emp_name LIKE 'M%'
    ORDER BY emp_name;

-- 5 & 6. Query 5 & 6: Display name, hire date and day of week; order by
--        day of week starting Monday
SELECT emp_name,
       DATE_FORMAT(NOW(), '%Y-%m-%d') AS 'Mock Hiredate',
       DAYNAME(NOW()) AS 'Day of Week'
    FROM Employee
    ORDER BY WEEKDAY(NOW());

-- 6. Query 7: Display date in format 'Seventh of June 1994 12:00:00 AM'
SELECT DATE_FORMAT('1994-06-07 00:00:00', '%D of %M %Y %r')
       AS 'Formatted Date';

-- 7. Query 8: Calculate the annual compensation of all employees (sal + comm.)
SELECT emp_name,
       (emp_sal + IFNULL(emp_comm, 0)) * 12 AS 'Annual Compensation'
    FROM Employee;
