-- Practical 9: To study and implement Transaction Control Language (TCL) and
-- Data Control Language (DCL) commands in SQL.
USE dbms_lab;

-- 23. Query 1: COMMIT - permanently save all changes made in the current transaction
START TRANSACTION;   -- (added) turns off auto-commit for this block
UPDATE DEPOSIT SET AMOUNT = AMOUNT + 500 WHERE CNAME = 'ANIL';
COMMIT;
SELECT CNAME, AMOUNT FROM DEPOSIT WHERE CNAME = 'ANIL';

-- 24. Query 2: ROLLBACK - undo all changes made since the last COMMIT
START TRANSACTION;   -- (added)
UPDATE DEPOSIT SET AMOUNT = AMOUNT - 1000 WHERE CNAME = 'SUNIL';
ROLLBACK;
SELECT CNAME, AMOUNT FROM DEPOSIT WHERE CNAME = 'SUNIL';

-- 25. Query 3: SAVEPOINT - mark a point within a transaction to roll back to
-- (Your output showed "ERROR 1305: SAVEPOINT sp1 does not exist" because
--  auto-commit was ON. START TRANSACTION fixes that.)
START TRANSACTION;   -- (added)
UPDATE DEPOSIT SET AMOUNT = AMOUNT + 200 WHERE CNAME = 'MEHUL';
SAVEPOINT sp1;
UPDATE DEPOSIT SET AMOUNT = AMOUNT + 300 WHERE CNAME = 'MADHURI';
ROLLBACK TO sp1;
COMMIT;

-- 26. Query 4: GRANT - give a database user specific privileges on a table
-- (added) the user must exist before GRANT in MySQL 8:
CREATE USER IF NOT EXISTS 'student_user'@'localhost' IDENTIFIED BY 'student123';
GRANT SELECT, INSERT, UPDATE ON DEPOSIT TO 'student_user'@'localhost';
GRANT ALL PRIVILEGES ON dbms_lab.* TO 'student_user'@'localhost';
FLUSH PRIVILEGES;

-- 27. Query 5: REVOKE - remove previously granted privileges from a database user
REVOKE INSERT, UPDATE ON DEPOSIT FROM 'student_user'@'localhost';
REVOKE ALL PRIVILEGES ON dbms_lab.* FROM 'student_user'@'localhost';
FLUSH PRIVILEGES;
