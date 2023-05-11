BEGIN;
INSERT INTO department
VALUES ('Medical', 'Pasteur', 700000);
INSERT INTO department
VALUES ('Dental', 'Pasteur', 800000);
COMMIT;
BEGIN;
UPDATE department
SET budget = budget + (
        SELECT budget * 0.1
        FROM department
        WHERE dept_name = 'Medical'
    )
WHERE dept_name = 'Dental';
UPDATE department
SET budget = budget * 0.9
WHERE dept_name = 'Medical';
COMMIT;