-- SELECT * FROM purchased_info;
-- SELECT * FROM student_info;
WITH table_paid_duration AS(
SELECT 
	purchased_info.student_id,
    student_info.date_registered,
    MIN(date_start) AS first_paid_day,
    IF(MAX(date_end) <= '2022-10-31',
        MAX(date_end),
        '2022-10-31')  AS last_paid_day
FROM purchased_info
JOIN student_info USING(student_id)
GROUP BY 
	purchased_info.student_id
-- HAVING student_id = 260111
), table_content_watched_1 AS(
SELECT 
	student_id,
    date_registered,
    first_paid_day,
    last_paid_day,
    ROUND(SUM(CASE WHEN l.minutes_watched IS NOT NULL THEN l.minutes_watched ELSE 0 END), 2) AS total_minutes_watched,
    DATEDIFF(last_paid_day, first_paid_day) AS num_paid_days
FROM table_paid_duration
LEFT JOIN student_learning l USING(student_id)
GROUP BY table_paid_duration.student_id
), table_distribute_to_buckets AS(
SELECT 
	student_id,
    date_registered,
    total_minutes_watched,
    num_paid_days,
    CASE WHEN total_minutes_watched = 0 THEN '[0]'
         WHEN total_minutes_watched <= 30 THEN '(0, 30]'
         WHEN total_minutes_watched <= 60 THEN '(30, 60]'
         WHEN total_minutes_watched <= 120 THEN '(60, 120]'
         WHEN total_minutes_watched <= 240 THEN '(120, 240]'
         WHEN total_minutes_watched <= 480 THEN '(240, 480]'
         WHEN total_minutes_watched <= 1000 THEN '(480, 1000]'
         WHEN total_minutes_watched <= 2000 THEN '(1000, 2000]'
         WHEN total_minutes_watched <= 3000 THEN '(2000, 3000]'
         WHEN total_minutes_watched <= 4000 THEN '(3000, 4000]'
         WHEN total_minutes_watched <= 6000 THEN '(4000, 6000]'
         ELSE '6000+'
	END AS buckets
FROM table_content_watched_1
) 

SELECT 
	student_id,
    date_registered,
    total_minutes_watched,
    num_paid_days,
    buckets
FROM table_distribute_to_buckets;