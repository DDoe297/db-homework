SELECT student_instructor.name,
	student_instructor.person_type,
	instructor.salary / department.budget AS calc_number
FROM department,
	instructor,
	student_instructor
WHERE person_type = 'INS'
	AND instructor.id = student_instructor.id
	AND instructor.dept_name = department.dept_name
UNION ALL
SELECT student_instructor.name,
	student_instructor.person_type,
	department.budget /(
		SELECT COUNT(*)
		FROM student AS S
		WHERE S.dept_name = T.dept_name
	) AS calc_number
FROM department,
	student AS T,
	student_instructor
WHERE student_instructor.person_type = 'STU'
	AND T.id = student_instructor.id
	AND T.dept_name = department.dept_name;
