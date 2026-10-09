-- Practical 10: To write PL/SQL blocks / stored procedures for basic
-- programming logic.
USE dbms_lab;

-- Program 1: Procedure to Add 2 Numbers
DELIMITER //
CREATE PROCEDURE AddTwoNumbers(
    IN num1 INT,
    IN num2 INT,
    OUT sum_res INT
)
BEGIN
    SET sum_res = num1 + num2;
END //
DELIMITER ;

CALL AddTwoNumbers(10, 20, @result);
SELECT @result AS Sum;

-- Program 2: Procedure to find Area of Rectangle, Triangle and Square
DELIMITER //
CREATE PROCEDURE CalculateAreas(
    IN rect_w DECIMAL(10,2),
    IN rect_h DECIMAL(10,2),
    IN tri_b DECIMAL(10,2),
    IN tri_h DECIMAL(10,2),
    IN sq_side DECIMAL(10,2)
)
BEGIN
    SELECT rect_w * rect_h AS Rect_Area,
           0.5 * tri_b * tri_h AS Tri_Area,
           sq_side * sq_side AS Square_Area;
END //
DELIMITER ;

CALL CalculateAreas(10, 5, 8, 6, 4);

-- Program 3: Procedure to find Maximum of 3 Numbers
DELIMITER //
CREATE PROCEDURE FindMaxOfThree(
    IN n1 INT, IN n2 INT, IN n3 INT,
    OUT max_val INT
)
BEGIN
    IF n1 >= n2 AND n1 >= n3 THEN
        SET max_val = n1;
    ELSEIF n2 >= n1 AND n2 >= n3 THEN
        SET max_val = n2;
    ELSE
        SET max_val = n3;
    END IF;
END //
DELIMITER ;

CALL FindMaxOfThree(25, 70, 40, @max);
SELECT @max AS Maximum;

-- Program 4: Procedure to print Sum of N Numbers using Loop
DELIMITER //
CREATE PROCEDURE SumOfN(
    IN n INT,
    OUT total INT
)
BEGIN
    DECLARE i INT DEFAULT 1;
    SET total = 0;
    WHILE i <= n DO
        SET total = total + i;
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL SumOfN(10, @total);
SELECT @total AS Sum;

-- Program 5: Procedure to generate Fibonacci Series up to N Numbers
DELIMITER //
CREATE PROCEDURE GenerateFibonacci(IN n INT)
BEGIN
    DECLARE a INT DEFAULT 0;
    DECLARE b INT DEFAULT 1;
    DECLARE temp INT;
    DECLARE count INT DEFAULT 2;

    CREATE TEMPORARY TABLE IF NOT EXISTS FibSeries (val INT);
    TRUNCATE TABLE FibSeries;

    IF n >= 1 THEN INSERT INTO FibSeries VALUES (a); END IF;
    IF n >= 2 THEN INSERT INTO FibSeries VALUES (b); END IF;

    WHILE count < n DO
        SET temp = a + b;
        INSERT INTO FibSeries VALUES (temp);
        SET a = b;
        SET b = temp;
        SET count = count + 1;
    END WHILE;

    SELECT * FROM FibSeries;
END //
DELIMITER ;

CALL GenerateFibonacci(10);
