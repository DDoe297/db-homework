CREATE PROCEDURE change_replacement_cost(film_id_1 INT, film_id_2 INT) LANGUAGE plpgsql AS $$
DECLARE amount FLOAT;
BEGIN
SELECT replacement_cost * 0.05 INTO amount
FROM film
WHERE film_id = film_id_1;
UPDATE film
SET replacement_cost = replacement_cost - amount
WHERE film_id = film_id_1;
UPDATE film
SET replacement_cost = replacement_cost + amount
WHERE film_id = film_id_2;
END;
$$;
