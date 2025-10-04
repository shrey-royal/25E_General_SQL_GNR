-- Loops
/*
syntax:
[begin_label:] LOOP
    statements;
END LOOP [end_label]

[label]: LOOP
    ...
    -- terminate the loop
    IF condition THEN
        LEAVE [label];
    END IF;
    ...
END LOOP;
*/

CREATE TABLE calendars (
    date DATE PRIMARY KEY,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

DELIMITER //

CREATE PROCEDURE fillDates(
	IN startDate DATE,
    IN endDate DATE
)
BEGIN
	DECLARE currentDate DATE DEFAULT startDate;
    
	insert_date: LOOP
		-- increase date by one day
		SET currentDate = DATE_ADD(currentDate, INTERVAL 1 DAY);
        
        -- leave the loop if the current date is after the end date
        IF currentDate > endDate THEN
			LEAVE insert_date;
        END IF;
        
        -- insert date into the table
        INSERT INTO calendars(date, month, quarter, year)
        VALUES(currentDate, MONTH(currentDate), QUARTER(currentDate), YEAR(currentDate));
		
    END LOOP;
END //

DELIMITER ;

------------------------------------------------------------------------------------
-- While Loop
/*
Syntax:
[begin_label:] WHILE search_condition DO
    statement_list
END WHILE [end_label]
*/

DELIMITER $$

CREATE PROCEDURE loadDates(
    startDate DATE, 
    day INT
)
BEGIN
    
    DECLARE counter INT DEFAULT 0;
    DECLARE currentDate DATE DEFAULT startDate;

    WHILE counter <= day DO
        CALL InsertCalendar(currentDate);
        SET counter = counter + 1;
        SET currentDate = DATE_ADD(currentDate ,INTERVAL 1 day);
    END WHILE;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE InsertCalendar(
    IN currentDate DATE
)
BEGIN
    INSERT INTO calendars(date, month, quarter, year) VALUES(currentDate, MONTH(currentDate), QUARTER(currentDate), YEAR(currentDate));

END$$

DELIMITER ;


CALL loadDates('2024-01-01',365);

------------------------------------------------------------------------------------
-- REPEAT LOOP
/*
Syntax:
[begin_label:] REPEAT
    statement;
UNTIL condition
END REPEAT [end_label]
*/

DELIMITER $$

CREATE PROCEDURE RepeatDemo()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT '';
    
    REPEAT
        SET result = CONCAT(result,counter,',');
        SET counter = counter + 1;
    UNTIL counter >= 10
    END REPEAT;
    
    -- display result
    SELECT result;
END$$

DELIMITER ;