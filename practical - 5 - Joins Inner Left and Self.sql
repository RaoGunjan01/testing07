-- Practical 5: To perform inner joins, left joins and self joins across
-- multiple related tables.
USE dbms_lab;

-- NOTE: Queries below use a Department table that is NOT created anywhere in
-- the manual. Optional setup so Query 4-7 can run (matches your output
-- screenshots: dept 20 = RESEARCH, dept 10 = ACCOUNTING in NEW YORK):
-- CREATE TABLE Department (dept_no INT, dept_name VARCHAR(20), location VARCHAR(20));
-- INSERT INTO Department VALUES (10,'ACCOUNTING','NEW YORK'),(20,'RESEARCH','DALLAS'),(30,'SALES','CHICAGO');

-- 8. Query 1: Full details of customer 'ANIL' across all related tables
SELECT C.CNAME, C.CITY, D.ACTNO, D.BNAME,
       D.AMOUNT AS DEP_AMT, B.LOANNO,
       B.AMOUNT AS LOAN_AMT
FROM CUSTOMERS C
LEFT JOIN DEPOSIT D ON C.CNAME = D.CNAME
LEFT JOIN BORROW B ON C.CNAME = B.CNAME
WHERE C.CNAME = 'ANIL';

-- 9. Query 2: Customers who are borrowers and depositors and live in Nagpur
SELECT DISTINCT C.CNAME
FROM CUSTOMERS C
JOIN DEPOSIT D ON C.CNAME = D.CNAME
JOIN BORROW B ON C.CNAME = B.CNAME
WHERE C.CITY = 'NAGPUR';

-- 10. Query 3: City of customers having same living branch
SELECT DISTINCT C1.CNAME, C2.CNAME, BR.CITY
FROM CUSTOMERS C1
JOIN DEPOSIT D1 ON C1.CNAME = D1.CNAME
JOIN DEPOSIT D2 ON D1.BNAME = D2.BNAME
JOIN CUSTOMERS C2 ON D2.CNAME = C2.CNAME
JOIN BRANCH BR ON D1.BNAME = BR.BNAME
WHERE C1.CNAME < C2.CNAME;

-- 11. Query 4: Last name, department number and department name for all employees
SELECT E.emp_name AS 'Last Name',
       E.dept_no,
       D.dept_name
FROM Employee E
LEFT JOIN Department D ON E.dept_no = D.dept_no;

-- 12. Query 5: Unique listing of all jobs in department 30 with location
SELECT DISTINCT E.dept_no, J.job_title, D.location
FROM Employee E
JOIN Job J ON E.emp_sal BETWEEN J.min_sal AND J.max_sal
JOIN Department D ON E.dept_no = D.dept_no
WHERE E.dept_no = 30;

-- 13. Query 6 & 7: Employees located in New York; Employee-Manager self join
SELECT E.emp_name, E.dept_no, D.dept_name
FROM Employee E
JOIN Department D ON E.dept_no = D.dept_no
WHERE D.location = 'NEW YORK';

SELECT E.emp_name AS 'Employee',
       E.emp_no AS 'Emp#',
       M.emp_name AS 'Manager',
       M.emp_no AS 'Mgr#'
FROM Employee E
LEFT JOIN Employee M
    ON E.dept_no = M.dept_no
   AND M.emp_sal > E.emp_sal;
