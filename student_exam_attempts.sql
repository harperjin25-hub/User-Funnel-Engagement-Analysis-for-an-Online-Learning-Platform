-- SELECT * FROM student_exams;
-- SELECT * FROM exam_info;

SELECT 
	exam_attempt_id,
    student_id,
    exam_id,
    exam_category,
    exam_passed,
    date_exam_completed
FROM student_exams
JOIN exam_info USING(exam_id)