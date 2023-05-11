-- A --
SELECT dept_name
FROM instructor
GROUP BY dept_name
HAVING sum(salary) >(
        SELECT avg(total_salary_sum)
        FROM (
                SELECT sum(salary) AS total_salary_sum
                FROM instructor
                GROUP BY dept_name
            ) AS dept_total
    );
-- B --
WITH
instructor_teach_count(name, teach_count) AS (
        SELECT instructor.name, COUNT(*)
        FROM teaches,
            instructor
        WHERE teaches.id = instructor.id
            AND year = 2003
        GROUP BY instructor.id
    ), 
    instructor_teach_count_avg(avg_value) AS (
        SELECT avg(teach_count)
        FROM instructor_teach_count
    )
SELECT name, teach_count
FROM instructor_teach_count, instructor_teach_count_avg
WHERE teach_count>instructor_teach_count_avg.avg_value;