WITH film_rental_amount AS (
    SELECT inventory.film_id AS film_id,
        SUM(amount) AS amount
    FROM payment,
        rental,
        inventory
    WHERE rental.rental_id = payment.rental_id
        AND inventory.inventory_id = rental.inventory_id
    GROUP BY inventory.film_id
)
SELECT title,
    rating,
    amount,
    RANK() OVER(ORDER BY amount DESC) AS overall_rank,
    RANK() OVER(PARTITION BY film.rating ORDER BY amount DESC) AS rating_rank,
    (
        CASE
            WHEN NTILE(4) OVER(
                ORDER BY amount DESC
            ) = 1 THEN 'Yes'
            ELSE 'No'
        END
    ) AS first_quartile
FROM film,
    film_rental_amount
WHERE film_rental_amount.film_id = film.film_id
ORDER BY film.title;