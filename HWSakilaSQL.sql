USE sakila;

SELECT first_name, last_name
FROM actor;

SELECT CONCAT(first_name, last_name) AS Actor_Name
FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

SELECT country_id, country
FROM country AS c
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD middle_name VARCHAR(45);

ALTER TABLE actor
MODIFY COLUMN middle_name blob;

ALTER TABLE actor
	DROP COLUMN middle_name;
    
SELECT last_name, count(last_name) AS total
FROM actor	
GROUP BY last_name;

SELECT last_name, count(last_name) AS total
FROM actor	
GROUP BY last_name
HAVING total > 1;

    
UPDATE actor
    SET first_name = 'Harpo'
    WHERE first_name = 'Groucho' and last_name = 'Williams';

UPDATE actor
	SET first_name = 'Groucho'
	   WHERE actor_id = 172;
       
SHOW CREATE TABLE address;

SELECT first_name, last_name, address
FROM staff AS s
JOIN address AS a
ON s.address_id = a.address_id;

SELECT first_name, last_name, count(amount)
FROM staff AS s
JOIN payment AS p
ON s.staff_id = p.staff_id
WHERE payment_date LIKE '2005-08%'
GROUP BY last_name;
             
SELECT title, count(actor_id)
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
GROUP BY title;

SELECT f.film_id, title, count(i.film_id) 
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

SELECT first_name, last_name, count(amount) AS "Total Paid"
FROM customer AS c
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY last_name, first_name;

SELECT title
FROM film
	WHERE (title LIKE "K%" OR title LIKE "Q%") AND 
    language_id in
    (
		SELECT language_id
			FROM language
            WHERE name = "English"
	);

SELECT first_name, last_name
FROM actor
	WHERE actor_id in
    (
		SELECT actor_id
			FROM film_actor
            WHERE film_id IN
            (
				SELECT film_id
                FROM film
					WHERE title = 'Alone Trip'
			)
	);
    
SELECT first_name, last_name, email, ci.city, co.country
FROM customer AS c
INNER JOIN address AS a
ON c.address_id = a.address_id

	INNER JOIN city as ci 
    ON a.city_id = ci.city_id
    
		INNER JOIN country as co 
        ON ci.country_id = co.country_id
        
			WHERE co.country = 'Canada'
			ORDER BY last_name, first_name;

SELECT f.film_id, title, description
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
	INNER JOIN category AS c
	ON fc.category_id = c.category_id
		WHERE c.name = 'Family';
	
SELECT f.film_id, title, description, COUNT(r.rental_id) AS "Rental Count"
	FROM film as f
		INNER JOIN inventory AS i 
		ON f.film_id = i.film_id
			INNER JOIN rental AS r 
            ON i.inventory_id = r.inventory_id
				GROUP BY title
				ORDER BY COUNT(r.rental_id) DESC, title ASC;
    
SELECT s.store_id, SUM(p.amount)
	FROM store AS s
    INNER JOIN staff  AS st 
    ON s.store_id = st.store_id
		INNER JOIN payment AS p 
        ON st.staff_id = p.staff_id
			GROUP BY s.store_id;    
    
SELECT store_id, city, country
	FROM address AS a
	INNER JOIN store AS s
    ON a.address_id = s.address_id
		INNER JOIN city AS c
        ON a.city_id = c.city_id
			INNER JOIN country AS co
            ON c.country_id	= co.country_id;
            
            

CREATE VIEW TopGenresRevenue AS
	SELECT ca.name AS "CategoryName", SUM(amount) AS "GrossRevenue"
		FROM category AS ca
		INNER JOIN film_category AS fc ON ca.category_id = fc.category_id
		INNER JOIN inventory AS i ON fc.film_id = i.film_id
		INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
		INNER JOIN payment AS p ON r.rental_id = p.rental_id
		GROUP BY ca.name 
		ORDER BY SUM(amount) DESC
		LIMIT 5;
        
SELECT * FROM TopGenresRevenue;

DROP VIEW TopGenresRevenue;
