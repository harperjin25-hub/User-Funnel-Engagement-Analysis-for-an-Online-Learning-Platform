CREATE VIEW purchased_info AS 
SELECT 
	purchase_id,
	student_id,
	purchase_type,
	date_start,
    IF(date_refunded IS NULL, date_end, date_refunded) AS date_end -- IF true then date_end, ELSE date_refunded
FROM(
SELECT 
	purchase_id,
	student_id,
	purchase_type,
	date_purchased AS date_start,
	CASE WHEN purchase_type = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)
			WHEN purchase_type = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)
			WHEN purchase_type = 2 THEN DATE_ADD(date_purchased,INTERVAL 12 MONTH)
	END AS date_end,
	date_refunded
FROM student_purchases) AS a; 

SELECT 
	student_id,
    date_engaged,
    MAX(paid) AS paid
FROM(
SELECT 
	e.student_id,
    e.date_engaged,
    p.date_start,
    p.date_end,
    CASE WHEN date_start IS NULL AND date_end IS NULL THEN 0
		 WHEN date_engaged BETWEEN date_start AND date_end THEN 1
         WHEN date_engaged NOT BETWEEN date_start AND date_end THEN 0
	END AS paid
FROM student_engagement e
LEFT JOIN purchased_info p
USING (student_id)) AS a
GROUP BY student_id, date_engaged;