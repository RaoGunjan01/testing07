-- Practical 3: To perform various data manipulation commands, aggregate
-- functions and sorting concepts on all created tables.
USE dbms_lab;

-- 1. Query 1: List total deposit from DEPOSIT
SELECT SUM(AMOUNT) AS 'Total Deposit'
    FROM DEPOSIT;

-- 2. Query 2: List total loan from WESTSIDE branch
SELECT SUM(AMOUNT) AS 'Total Loan'
    FROM BORROW
    WHERE BNAME = 'WESTSIDE';

-- 3. Query 3: Give maximum loan from branch MAINST
SELECT MAX(AMOUNT) AS 'Max Loan'
    FROM BORROW
    WHERE BNAME = 'MAINST';

-- 4. Query 4: Count total number of customers
SELECT COUNT(*) AS 'Total Customers'
    FROM CUSTOMERS;

-- 5. Query 5: Count total number of customers' cities
SELECT COUNT(DISTINCT CITY) AS 'Total Unique Cities'
    FROM CUSTOMERS;

-- 6. Query 6: Create table SUPPLIER from EMPLOYEE with all columns
CREATE TABLE supplier AS
    SELECT * FROM Employee;

-- 7. Query 7: Create table SUP1 from EMPLOYEE with first two columns
CREATE TABLE sup1 AS
    SELECT emp_no, emp_name FROM Employee;

-- 8. Query 8: Create table SUP2 from EMPLOYEE with no data
CREATE TABLE sup2 AS
    SELECT * FROM Employee
    WHERE 1 = 0;

-- 9. Query 9: Insert data into SUP2 from EMPLOYEE where name matches '_n___'
INSERT INTO sup2
    SELECT * FROM Employee
    WHERE emp_name LIKE '_n___';

-- 10. Query 10: Delete all rows from SUP1
DELETE FROM sup1;

-- 11. Query 11: Delete detail of supplier whose emp_no is 103
DELETE FROM supplier
    WHERE emp_no = 103;

-- 12. Query 12: Rename table SUP2
RENAME TABLE sup2 TO sup2_new;

-- 13. Query 13: Destroy table SUP1 with all data
DROP TABLE IF EXISTS sup1;

-- 14. Query 14: Update dept_no to 10 where second character of emp_name is 'm'
UPDATE Employee
    SET dept_no = 10
    WHERE emp_name LIKE '_m%';

-- 15. Query 15: Update the value of employee name whose employee number is 103
UPDATE Employee
    SET emp_name = 'Adam_Modified'
    WHERE emp_no = 103;
