-- Practical 2: To create Job and Employee tables, insert data, and study
-- various options of the LIKE predicate.
USE dbms_lab;

-- 1. Create Job and Employee tables
CREATE TABLE Job (
    job_id VARCHAR(15),
    job_title VARCHAR(30),
    min_sal DECIMAL(7,2),
    max_sal DECIMAL(7,2)
);

CREATE TABLE Employee (
    emp_no INT,
    emp_name VARCHAR(30),
    emp_sal DECIMAL(8,2),
    emp_comm DECIMAL(8,2),
    dept_no INT
);

-- 2. Insert data
INSERT INTO Job VALUES
    ('IT_PROG','Programmer',4000.00,10000.00),
    ('MK_MGR','Marketing manager',9000.00,15000.00),
    ('FI_MGR','Finance manager',8200.00,12000.00),
    ('FI_ACC','Account',4200.00,9000.00),
    ('LEC','Lecturer',6000.00,17000.00),
    ('COMP_OP','Computer Operator',1500.00,3000.00);

INSERT INTO Employee VALUES
    (101,'Smith',800.00,20.00,20),
    (102,'Sandra',1600.00,300.00,25),
    (103,'Adam',1100.00,0.00,20),
    (104,'Alan',3000.00,15.00,NULL),
    (105,'Anna',5000.00,50000.00,10),
    (106,'Susan',2450.00,24500.00,10),
    (107,'Alanda',2975.00,30.00,NULL);

-- 3. Query 1: Retrieve all data from Employee, Job and Deposit
SELECT * FROM Employee;
SELECT * FROM Job;
SELECT * FROM DEPOSIT;

-- 4. Query 2: Account no. and deposited amount of customers with account
--    opened between 01-01-06 and 25-07-06
SELECT ACTNO, AMOUNT
    FROM DEPOSIT
    WHERE ADATE BETWEEN '2006-01-01' AND '2006-07-25';

-- 5. Query 3: Display all jobs with minimum salary greater than 4000
SELECT *
    FROM Job
    WHERE min_sal > 4000;

-- 6. Query 4: Name and salary of employees whose department no is 20 (alias)
SELECT emp_name AS 'Employee Name', emp_sal
    FROM Employee
    WHERE dept_no = 20;

-- 7. Query 5: Employee no, name and department for employees whose
--    department lies in (10,20)
SELECT emp_no, emp_name, dept_no
    FROM Employee
    WHERE dept_no IN (10, 20);

-- 8. Query 7: Employees whose name starts with 'A' and third character is 'a'
--    ( _ = exactly one character, % = any number of characters )
SELECT *
    FROM Employee
    WHERE emp_name LIKE 'A_a%';

-- 9. Query 8: Name, number and salary of employees whose name is 5 characters
--    long, starting with 'Ani'
SELECT emp_name, emp_no, emp_sal
    FROM Employee
    WHERE emp_name LIKE 'Ani__';

-- 10. Query 9: Non-null dept employees whose name's second character is 'n'
--     and is 5 characters long
SELECT *
    FROM Employee
    WHERE dept_no IS NOT NULL
      AND emp_name LIKE '_n___';

-- 11. Query 10: Null dept employees whose name's third character is 'a'
SELECT *
    FROM Employee
    WHERE dept_no IS NULL
      AND emp_name LIKE '__a%';

-- 12. Query 11: Output of LIKE predicate as '%=%' ESCAPE '='
SELECT *
    FROM Employee
    WHERE emp_name LIKE '%=%' ESCAPE '=';
