CREATE VIEW student_instructor AS
SELECT student.id,
	student.name,
	CASE
		WHEN student.dept_name LIKE '%Eng.' THEN 'Engineer'::character(9)
		ELSE 'Scientist'::character(9)
	END AS dept_type,
	'STU'::character(3) AS person_type
FROM student
UNION
SELECT instructor.id,
	instructor.name,
	CASE
		WHEN instructor.dept_name LIKE '%Eng.' THEN 'Engineer'::character(9)
		ELSE 'Scientist'::character(9)
	END AS dept_type,
	'INS'::character(3) AS person_type
FROM instructor;
