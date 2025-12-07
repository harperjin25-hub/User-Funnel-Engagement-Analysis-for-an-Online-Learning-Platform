-- /*Enrolled in a track*/ --
SELECT 
	'Enrolled in a track' AS action,
     track_id AS track,
     COUNT(DISTINCT student_id) AS count
FROM student_career_track_enrollments
GROUP BY track_id

UNION

-- /*Attempted a course Exam*/ --
-- SELECT * FROM career_track_info;
SELECT 
	'Attempted a course Exam' AS action,
    career_track_info.track_id AS track,
    COUNT(DISTINCT student_exams.student_id) AS count
FROM student_exams
JOIN exam_info USING(exam_id)
JOIN career_track_info USING(course_id)
JOIN student_career_track_enrollments ON student_exams.student_id = student_career_track_enrollments.student_id
AND career_track_info.track_id = student_career_track_enrollments.track_id
WHERE exam_info.exam_category = 2 -- course exam
GROUP BY career_track_info.track_id

UNION

-- /*Completed a course Exam*/ --
SELECT 
	'Completed a course Exam' AS action,
    cti.track_id AS track,
    COUNT(DISTINCT sc.student_id) AS count
FROM student_certificates sc
JOIN career_track_info cti USING (course_id)
JOIN  student_career_track_enrollments en
ON sc.student_id = en.student_id
AND cti.track_id = en.track_id
WHERE sc.certificate_type = 1 -- course-level certification
GROUP BY cti.track_id

UNION

-- /*Attempted a final Exam*/ --
SELECT 
	'Attempted a final Exam' AS action,
    ei.track_id AS track,
    COUNT(DISTINCT se.student_id) AS count
FROM student_exams se
JOIN exam_info ei USING (exam_id)
JOIN  student_career_track_enrollments en
ON se.student_id = en.student_id
AND ei.track_id = en.track_id
WHERE ei.exam_category = 3
GROUP BY ei.track_id

UNION

-- /*Earned a career track certificate*/ --
SELECT 
	'Earned a career track certificate' AS action,
    sc.track_id AS track,
    COUNT(DISTINCT sc.student_id) AS count
FROM student_certificates sc
JOIN  student_career_track_enrollments en
ON sc.student_id = en.student_id
AND sc.track_id = en.track_id
WHERE sc.certificate_type = 2
GROUP BY sc.track_id;
