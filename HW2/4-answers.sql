-- A --
SELECT id,
    name
FROM student
WHERE name LIKE 'M%a';
-- B --
SELECT course.title
FROM section,
    course
WHERE section.course_id = course.course_id
    AND section.semester = 'Fall'
    AND section.year = 2009
    AND course.dept_name like '%Eng.';
-- C --
WITH take_more_than_3 AS (
    SELECT id,
        course_id
    FROM takes
    GROUP BY id,
        course_id
    HAVING count(*) >= 3
)
SELECT student.name,
    course.title
FROM student,
    take_more_than_3,
    course
WHERE student.id = take_more_than_3.id
    AND course.course_id = take_more_than_3.course_id;
-- D --
SELECT prereq_id AS course_id,
    sum(credits) AS sum_credits
FROM prereq,
    course
WHERE prereq.course_id = course.course_id
GROUP BY prereq_id
HAVING sum(credits) > 4
ORDER BY sum_credits DESC;
-- E --
SELECT section.room_number
FROM section,
    time_slot
WHERE section.time_slot_id = time_slot.time_slot_id
    AND section.semester = 'Spring'
    AND section.year = 2008
GROUP BY section.room_number
HAVING sum(time_slot.end_hr - time_slot.start_hr) >= 2;
-- F --
WITH avg_count AS (
    SELECT avg(count) AS avg
    FROM (
            SELECT count(*)
            FROM teaches
            WHERE year = 2003
            GROUP BY id
        ) AS course_count
)
SELECT teaches.id,
    count(*)
FROM teaches,
    avg_count
WHERE teaches.year = 2003
GROUP BY teaches.id
HAVING count(*) < avg(avg_count.avg);
-- G --
SELECT distinct course_id
FROM section,
    time_slot
WHERE section.building = 'Taylor'
    AND section.year = 2007
    AND time_slot.time_slot_id = section.time_slot_id
    AND time_slot.start_hr BETWEEN 8 and 12;
-- H --
WITH passed_course AS (
    SELECT takes.id,
        sum(course.credits) as credits
    FROM takes,
        course
    WHERE takes.course_id = course.course_id
        AND (
            grade like 'A%'
            OR grade like 'B%'
        )
    GROUP BY takes.id
)
SELECT student.name,
    passed_course.credits
FROM student,
    passed_course
WHERE passed_course.id = student.id;