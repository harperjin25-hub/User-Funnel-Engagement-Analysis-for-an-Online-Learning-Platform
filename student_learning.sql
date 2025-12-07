-- SELECT * FROM student_learning;
-- SELECT * FROM purchased_info;
WITH learning_data AS(
SELECT 
	student_id,
    date_watched,
    minutes_watched,
    CASE WHEN date_start IS NULL AND date_end IS NULL THEN 0
		 WHEN date_watched BETWEEN date_start AND date_end THEN 1
         WHEN date_watched NOT BETWEEN date_start AND date_end THEN 0
	END paid
FROM student_learning
LEFT JOIN purchased_info USING (student_id)
), paid_status AS(
SELECT 
	student_id,
    date_watched,
    ROUND(SUM(minutes_watched), 2) AS minutes_watched,
    MAX(paid) AS paid
FROM learning_data
GROUP BY student_id, date_watched
) 
SELECT 
	student_id,
    date_watched,
    minutes_watched,
    paid
FROM paid_status
GROUP BY student_id, date_watched