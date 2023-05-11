-- A --
CREATE TABLE uni_data (
    stu_id VARCHAR(5),
    stu_name VARCHAR(20) NOT NULL,
    stu_dept_name VARCHAR(20),
    year NUMERIC(4, 0) CHECK (
        year > 1701
        AND year < 2100
    ),
    semester VARCHAR(6) CHECK (
        semester IN ('Fall', 'Winter', 'Spring', 'Summer')
    ),
    course_name VARCHAR(50),
    score SMALLINT,
    is_rank SMALLINT
);
-- B --
INSERT INTO uni_data WITH takes_scored AS (
        SELECT *,
            (
                CASE
                    WHEN takes.grade LIKE 'A+' THEN 100
                    WHEN takes.grade LIKE 'A' THEN 95
                    WHEN takes.grade LIKE 'A-' THEN 90
                    WHEN takes.grade LIKE 'B+' THEN 85
                    WHEN takes.grade LIKE 'B' THEN 80
                    WHEN takes.grade LIKE 'B-' THEN 75
                    WHEN takes.grade LIKE 'C+' THEN 70
                    WHEN takes.grade LIKE 'C' THEN 65
                    WHEN takes.grade LIKE 'C-' THEN 60
                    ELSE 0
                END
            ) AS score
        FROM takes
    )
SELECT student.id AS stu_id,
    student.name AS stu_name,
    student.dept_name AS stu_dept_name,
    takes_scored.year AS year,
    takes_scored.semester AS semester,
    course.title AS course_name,
    takes_scored.score AS score,
    (
        CASE
            WHEN takes_scored.score > 70 THEN 1
            ELSE 0
        END
    ) AS is_rank
FROM student,
    course,
    takes_scored
WHERE student.id = takes_scored.id
    AND takes_scored.course_id = course.course_id;
-- C --
UPDATE uni_data
SET score = (
        CASE
            WHEN score >= 75 THEN score + 15
            WHEN score < 75 THEN score + 10
        END
    )
WHERE stu_dept_name LIKE 'Physics';
-- D --
DELETE FROM uni_data AS u
WHERE u.stu_name LIKE 'T%'
    AND u.score > (
        SELECT avg(score)
        FROM uni_data AS t
        GROUP BY stu_dept_name
        HAVING t.stu_dept_name = u.stu_dept_name
    );