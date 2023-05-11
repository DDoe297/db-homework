SELECT DISTINCT rating,
    SUM(amount) OVER(
        PARTITION BY rating
        ORDER BY date_part('month', payment_date) RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING
    ) as previous_month,
    SUM(amount) OVER(
        PARTITION BY rating,
        date_part('month', payment_date)
    ) as this_month,
    SUM(amount) OVER(
        PARTITION BY rating
        ORDER BY date_part('month', payment_date) RANGE BETWEEN 1 FOLLOWING AND 1 FOLLOWING
    ) as next_month,
    date_part('month', payment_date) AS month
FROM film,
    inventory,
    rental,
    payment
where film.film_id = inventory.film_id
    AND inventory.inventory_id = rental.inventory_id
    AND rental.rental_id = payment.rental_id
ORDER BY month;