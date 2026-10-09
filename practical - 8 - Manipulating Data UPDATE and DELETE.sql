-- Practical 8: To perform UPDATE and DELETE operations using joins and
-- subqueries.
USE dbms_lab;

-- 21. Query 1, 2 & 3: Apply percentage increments to deposit amounts
UPDATE DEPOSIT
SET AMOUNT = AMOUNT * 1.10;

UPDATE DEPOSIT
SET AMOUNT = AMOUNT * 1.10
WHERE BNAME = 'VRCE';

UPDATE DEPOSIT D
JOIN CUSTOMERS C ON D.CNAME = C.CNAME
SET D.AMOUNT = D.AMOUNT * 1.10
WHERE C.CITY = 'NAGPUR'
  AND D.BNAME IN (
      SELECT BNAME
      FROM BRANCH
      WHERE CITY = 'BOMBAY'
  );

-- 22. Query 5 & 8: Transfer balance between two accounts; delete a customer record
-- (The extra "SELECT ... FROM (SELECT ...) AS t" derived table is the MySQL
--  workaround for ERROR 1093: can't update a table while selecting from it.)
UPDATE DEPOSIT
SET AMOUNT = AMOUNT - 10
WHERE CNAME = 'ANIL'
  AND BNAME IN (
      SELECT BNAME
      FROM (
          SELECT BNAME
          FROM DEPOSIT
          WHERE CNAME = 'SUNIL'
      ) AS t
  );

UPDATE DEPOSIT
SET AMOUNT = AMOUNT + 10
WHERE CNAME = 'SUNIL'
  AND BNAME IN (
      SELECT BNAME
      FROM (
          SELECT BNAME
          FROM DEPOSIT
          WHERE CNAME = 'ANIL'
      ) AS t
  );

DELETE FROM DEPOSIT WHERE CNAME = 'VIJAY';
