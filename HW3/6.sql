CREATE FUNCTION actor_film(actor_first_name TEXT, actor_last_name TEXT) RETURNS TABLE(film_title TEXT, rental_count int) AS $$
SELECT (
		SELECT title
		FROM film
		WHERE film.film_id = film_actor.film_id
	) AS film_title,
	(
		SELECT COUNT(*)
		FROM rental,
			inventory
		WHERE inventory.inventory_id = rental.inventory_id
			AND film_actor.film_id = inventory.film_id
	) AS rental_count
FROM film_actor,
	actor
WHERE actor.actor_id = film_actor.actor_id
	AND actor.first_name = actor_first_name
	AND actor.last_name = actor_last_name;
$$ LANGUAGE SQL;