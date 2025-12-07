USE customer_engagement;

WITH table_period_to_consider AS(
SELECT 
	student_info.student_id,
    student_info.date_registered,
    CASE WHEN student_purchases.student_id IS NULL THEN 0
    ELSE 1
    END AS f2p,
    '2022-10-31' AS last_day_to_watch
FROM student_info
LEFT JOIN student_purchases USING(student_id)
GROUP BY student_info.student_id, student_info.date_registered
),
-- SELECT * FROM  table_period_to_consider;
table_minutes_summed AS(
SELECT 
	p.student_id,
    p.date_registered,
    p.f2p,
    ROUND(SUM(CASE WHEN l.minutes_watched IS NOT NULL THEN l.minutes_watched ELSE 0 END), 2) AS total_minutes_watched
FROM table_period_to_consider p
LEFT JOIN student_learning l USING(student_id)
GROUP BY p.student_id, p.date_registered, p.f2p
),
table_distribute_to_buckets AS(
SELECT 
	student_id,
    date_registered,
    f2p,
    total_minutes_watched,
    CASE WHEN total_minutes_watched = 0 THEN '[0]'
		 WHEN total_minutes_watched <= 5 THEN '(0, 5]'
         WHEN total_minutes_watched <= 10 THEN '(5, 10]'
         WHEN total_minutes_watched <= 15 THEN '(10, 15]'
         WHEN total_minutes_watched <= 20 THEN '(15, 20]'
         WHEN total_minutes_watched <= 25 THEN '(20, 25]'
         WHEN total_minutes_watched <= 30 THEN '(25, 30]'
         WHEN total_minutes_watched <= 40 THEN '(30, 40]'
         WHEN total_minutes_watched <= 50 THEN '(40, 50]'
         WHEN total_minutes_watched <= 60 THEN '(50, 60]'
         WHEN total_minutes_watched <= 70 THEN '(60, 70]'
         WHEN total_minutes_watched <= 80 THEN '(70, 80]'
         WHEN total_minutes_watched <= 90 THEN '(80, 90]'
         WHEN total_minutes_watched <= 100 THEN '(90, 100]'
         WHEN total_minutes_watched <= 110 THEN '(100, 110]'
         WHEN total_minutes_watched <= 120 THEN '(110, 120]'
         WHEN total_minutes_watched <= 240 THEN '(120, 240]'
         WHEN total_minutes_watched <= 480 THEN '(240, 480]'
         WHEN total_minutes_watched <= 1000 THEN '(480, 1000]'
         WHEN total_minutes_watched <= 2000 THEN '(1000, 2000]'
         WHEN total_minutes_watched <= 3000 THEN '(2000, 3000]'
         WHEN total_minutes_watched <= 4000 THEN '(3000, 4000]'
         WHEN total_minutes_watched <= 6000 THEN '(4000, 6000]'
         ELSE '6000+'
	END AS buckets
FROM table_minutes_summed
)
SELECT 
	student_id,
    date_registered,
    f2p,
    total_minutes_watched,
    buckets
FROM table_distribute_to_buckets;