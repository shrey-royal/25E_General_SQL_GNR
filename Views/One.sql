CREATE VIEW customerPayments
AS
SELECT
    customerName,
    checkNumber,
    paymentDate,
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);


SELECT * FROM customerPayments;


CREATE VIEW daysofweek (day) AS
    SELECT 'Mon' 
    UNION 
    SELECT 'Tue'
    UNION 
    SELECT 'Web'
    UNION 
    SELECT 'Thu'
    UNION 
    SELECT 'Fri'
    UNION 
    SELECT 'Sat'
    UNION 
    SELECT 'Sun';

SELECT * FROM daysofweek;


-- to see all tables (base tables + views)
SHOW FULL TABLES;

-- to see only views
SHOW FULL TABLES WHERE Table_Type = "VIEW";


-- displaying which select query runs under a view
SHOW CREATE VIEW customerPayments;

-- renaming a view
RENAME TABLE daysofweek TO daysofweek1;

-- deleting a view
-- DROP VIEW [IF EXISTS] view_name;
DROP VIEW daysofweek1;


