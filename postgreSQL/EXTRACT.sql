SELECT * FROM payment;

SELECT EXTRACT(YEAR FROM payment_date) AS year 
FROM payment;

SELECT EXTRACT(QUARTER FROM payment_date) AS year 
FROM payment;

SELECT EXTRACT(MONTH FROM payment_date) AS year 
FROM payment;

SELECT AGE(payment_date) AS year 
FROM payment;

SELECT TO_CHAR(payment_date,'MONTH-YYYY') FROM payment;


SELECT TO_CHAR(payment_date,'MON-day-YY') FROM payment

-- During which the payments occur
SELECT  TO_CHAR(payment_date,'Day') FROM payment;

SELECT DISTINCT(TO_CHAR(payment_date,'MONTH')) FROM payment;

SELECT COUNT(*) FROM payment
WHERE TO_CHAR(payment_date,'Day')='Monday   '

SELECT COUNT(*) FROM payment
WHERE EXTRACT(DOW FROM payment_date)=1
