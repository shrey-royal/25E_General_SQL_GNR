-- DROP Procedures
DELIMITER $$

CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT 
        firstName, 
        lastName, 
        city, 
        state, 
        country
    FROM employees
    INNER JOIN offices using (officeCode);
    
END$$

DELIMITER ;

-------------------------------------------------------------

DROP PROCEDURE IF EXISTS 'GetEmployees', 'AnotherProcedure';

SHOW WARNINGS;

-------------------------------------------------------------

-- CREATE A NEW SESSION VARIABLE

SET @var_name = value;

SELECT @var_name;

-------------------------------------------------------------

-- Alteration of a procedure
DELIMITER //

CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT * FROM employees;
END //

DELIMITER ;

-------------------------------------------------------------
SHOW CREATE PROCEDURE GetEmployees\G;

-------------------------------------------------------------
ALTER PROCEDURE GetEmployees COMMENT "Get Employees";

-------------------------------------------------------------
-- MySQL Stored Procedure Variables

-- dECLARING vARIABLES
-- DECLARE variable_name datatype(size) [DEFAULT default_value];

DECLARE totalSale DEC(10, 2) DEFAULT 0.0;
DECLARE totalQty, stockCount INT DEFAULT 0;

DECLARE amount DECMIAL(10,2);
DECLARE currency CHAR(3) DEFAULT 'USD';

-------------------------------------------------------------
-- Assigning Variables
-- SET variable_name = value;

DECLARE total INT DEFAULT 0;
SET total = 10;

-------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE GetTotalOrder()
BEGIN
    DECLARE totalOrder INT DEFAULT 0;

    SELECT COUNT(*)
    INTO totalOrder
    FROM orders;

    SELECT totalOrder;

END $$

DELIMITER ;

-------------------------------------------------------------
-- Listing procedures

SHOW PROCEDURE STATUS WHERE db = 'classicmodels';
-------------------------------------------------------------

SELECT 
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'PROCEDURE'
        AND routine_schema = 'classicmodels';