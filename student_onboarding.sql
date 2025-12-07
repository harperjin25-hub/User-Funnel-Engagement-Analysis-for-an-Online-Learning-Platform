-- SELECT * FROM student_info;
-- SELECT * FROM student_engagement;

SELECT 
	student_info.student_id,
    date_registered,
    CASE WHEN e.student_id IS NULL THEN 0 ELSE 1 END AS student_onboarded
FROM student_info
LEFT JOIN (SELECT DISTINCT student_id FROM student_engagement) e
ON e.student_id = student_info.student_id