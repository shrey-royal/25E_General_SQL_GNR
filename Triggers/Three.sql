DELIMITER $$
CREATE TRIGGER trigger_name
{BEFORE|AFTER}{INSERT|UPDATE|DELETE} 
ON table_name
FOR EACH ROW 
{FOLLOWS|PRECEDES} existing_trigger_name
BEGIN
    -- statements
END$$
DELIMITER ;

CREATE TABLE PriceLogs (
    id INT AUTO_INCREMENT,
    productCode VARCHAR(15) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    updated_at TIMESTAMP NOT NULL 
			DEFAULT CURRENT_TIMESTAMP 
            ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (productCode)
        REFERENCES products (productCode)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

DELIMITER $$

CREATE TRIGGER before_products_update 
   BEFORE UPDATE ON products 
   FOR EACH ROW 
BEGIN
     IF OLD.msrp <> NEW.msrp THEN
         INSERT INTO PriceLogs(productCode,price)
         VALUES(old.productCode,old.msrp);
     END IF;
END$$

DELIMITER ;


SELECT 
    productCode,
    msrp
FROM products 
WHERE productCode = 'S12_1099';

UPDATE products
SET msrp = 200
WHERE productCode = 'S12_1099';

CREATE TABLE UserChangeLogs (
    id INT AUTO_INCREMENT,
    productCode VARCHAR(15) DEFAULT NULL,
    updatedAt TIMESTAMP NOT NULL 
	DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,
    updatedBy VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (productCode)
        REFERENCES products (productCode)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

DELIMITER $$

CREATE TRIGGER before_products_update_log_user
   BEFORE UPDATE ON products 
   FOR EACH ROW 
   FOLLOWS before_products_update
BEGIN
    IF OLD.msrp <> NEW.msrp THEN
	INSERT INTO 
            UserChangeLogs(productCode,updatedBy)
        VALUES
            (OLD.productCode,USER());
    END IF;
END$$

DELIMITER ;

UPDATE 
    products
SET 
    msrp = 220
WHERE 
    productCode = 'S12_1099';


SHOW TRIGGERS
FROM classicmodels
WHERE `table` = 'products';


/*
use classicmodels;

show triggers;

desc products;

select * from products;

select * from pricelogs;

select * from userchangelogs;

SHOW TRIGGERS
FROM classicmodels
WHERE `table` = 'products';
*/