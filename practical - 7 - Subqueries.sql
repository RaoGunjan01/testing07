-- Practical 7: To write nested subqueries for complex, multi-level data
-- retrieval.
USE dbms_lab;

-- 18. Query 1 & 2: Employees in the same department as 'SCOTT';
--     depositors in SUNIL's city branch
SELECT emp_name
FROM Employee
WHERE dept_no = (
    SELECT dept_no
    FROM Employee
    WHERE emp_name = 'SCOTT'
)
AND emp_name <> 'SCOTT';

SELECT DISTINCT CNAME
FROM DEPOSIT
WHERE BNAME IN (
    SELECT BNAME
    FROM BRANCH
    WHERE CITY = (
        SELECT CITY
        FROM CUSTOMERS
        WHERE CNAME = 'SUNIL'
    )
);

-- 19. Query 3 & 4: Deposit and loan entries in PRAMOD's city;
--     employees earning above average salary
SELECT *
FROM DEPOSIT
WHERE CNAME IN (
    SELECT CNAME
    FROM CUSTOMERS
    WHERE CITY = (
        SELECT CITY
        FROM CUSTOMERS
        WHERE CNAME = 'PRAMOD'
    )
);

SELECT *
FROM BORROW
WHERE CNAME IN (
    SELECT CNAME
    FROM CUSTOMERS
    WHERE CITY = (
        SELECT CITY
        FROM CUSTOMERS
        WHERE CNAME = 'PRAMOD'
    )
);

SELECT emp_no, emp_name, emp_sal
FROM Employee
WHERE emp_sal > (
    SELECT AVG(emp_sal)
    FROM Employee
)
ORDER BY emp_sal ASC;

-- 20. Query 5 - 9: Nested subqueries for deposits, managers, department
--     lookup and peak branch/city
SELECT CNAME
FROM DEPOSIT
WHERE AMOUNT > 2000
AND CNAME IN (
    SELECT CNAME
    FROM CUSTOMERS
    WHERE CITY = (
        SELECT CITY
        FROM CUSTOMERS
        WHERE CNAME = 'ANIL'
    )
);

SELECT emp_name, emp_sal
FROM Employee
WHERE dept_no = (
    SELECT dept_no
    FROM Employee
    WHERE emp_name = 'FORD'
);

-- (needs the Department table - see optional setup in Practical 5)
SELECT emp_no, emp_name
FROM Employee
WHERE dept_no = (
    SELECT dept_no
    FROM Department
    WHERE dept_name = 'ACCOUNTING'
);

SELECT BNAME, COUNT(*)
FROM DEPOSIT
GROUP BY BNAME
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT CITY, COUNT(*)
FROM BRANCH
GROUP BY CITY
ORDER BY COUNT(*) DESC
LIMIT 1;
