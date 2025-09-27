/*
-- Stored Procedures
-- A Stored Procedure is a set of declarative SQL statements stored within the MySQL Server.
*/


DELIMITER $$

CREATE PROCEDURE GetCustomers()
BEGIN
    SELECT 
        customerName, 
        city, 
        state, 
        postalCode, 
        country
    FROM
        customers
    ORDER BY customerName;

END$$
DELIMITER ;

DELIMITER //

--------------------------------------------------
DELIMITER $$

CREATE PROCEDURE CreatePersonTable()
BEGIN
    -- drop person table
    DROP TABLE IF EXISTS persons;

    -- create persons table
    CREATE TABLE persons (
        id INT AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL
    );

    -- insert data into the persons table
    INSERT INTO persons(first_name, last_name)
    VALUES ('John', 'Doe'), ('Jane', 'Doe');

    -- retrieve data from the persons table
    SELECT id, first_name, last_name
    FROM persons;

END $$

DELIMITER ;



-------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS GetAllProducts()
BEGIN
    SELECT * FROM products;
END $$

DELIMITER ;

-------------------------------------------------------

-- PARAMETERS
-- MODES of parameters: IN(default), OUT, INOUT

-------------------------------------------------------

-- IN 
DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
    IN countryName VARCHAR(255)
)
BEGIN
    SELECT *
    FROM offices
    WHERE country = countryName;
END //

DELIMITER ;

-------------------------------------------------------

-- OUT
DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus(
    IN orderStatus VARCHAR(25),
    OUT total INT
)
BEGIN
    SELECT COUNT(orderNumber)
    INTO total
    FROM orders
    WHERE status = orderStatus;
END $$

DELIMITER ;