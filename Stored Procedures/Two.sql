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
