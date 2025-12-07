-- SELECT * FROM course_info;
-- SELECT * FROM student_learning;
SELECT 
	ci.course_id,
    ci.course_title,
    ROUND(SUM(sl.minutes_watched), 2) AS minutes_watched,
    ROUND(SUM(sl.minutes_watched)/COUNT(DISTINCT sl.student_id), 2) AS minutes_per_student,
    ROUND(SUM(sl.minutes_watched)/COUNT(DISTINCT sl.student_id)/ci.course_duration, 2) AS completion_rate
FROM course_info ci
JOIN student_learning sl USING(course_id)
GROUP BY ci.course_id, ci.course_title;