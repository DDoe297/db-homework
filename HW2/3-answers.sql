-- A --
WHERE SUBSTR(first_name, 1, 2) = 'me' AND SUBSTR(lastname, LENGTH(lastname) - 2, 3) = 'avi'
-- B --
SELECT CONCAT(first_name, last_name) from STUDENT