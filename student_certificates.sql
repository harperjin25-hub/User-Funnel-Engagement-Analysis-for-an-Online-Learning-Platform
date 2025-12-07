-- SELECT * FROM student_certificates;
-- SELECT * FROM purchased_info;
SELECT 
	certificate_id,
    student_id,
    certificate_type,
    date_issued,
    MAX(paid) AS paid
FROM(
SELECT 
	certificate_id,
    student_id,
    certificate_type,
    date_issued,
    CASE WHEN date_start IS NULL AND date_end IS NULL THEN 0
		 WHEN date_issued BETWEEN date_start AND date_end THEN 1
         WHEN date_issued NOT BETWEEN date_start AND date_end THEN 0
	END AS paid
FROM student_certificates
LEFT JOIN purchased_info USING (student_id)) a
GROUP BY certificate_id
