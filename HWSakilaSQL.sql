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

