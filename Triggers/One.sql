-- Syntax of Trigger
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
    -- Trigger Body (SQL Statements)
END;

-- Creating items table
CREATE TABLE items (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Inserting a row
INSERT INTO items(id, name, price)
VALUES(1, "Item", 50.00);

-- creating another table
CREATE TABLE item_changes(
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    change_type VARCHAR(10),
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

-- creating a trigger that automatically adds the changes of items table into item_changes table

DELIMITER //

CREATE TRIGGER update_item_trigger
AFTER UPDATE
ON items
FOR EACH ROW
BEGIN
    INSERT INTO item_changes (item_id, change_type)
    VALUES (NEW.id, 'UPDATE');
END;
//

DELIMITER ;

-- updating item
UPDATE items
SET price = 60.00
WHERE id = 1;

SELECT * FROM item_changes;