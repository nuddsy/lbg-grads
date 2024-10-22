-- 1 List all actors.
SELECT *
FROM actor;

-- 2 Find the surname of the actor with the forename 'John'.
SELECT
	last_name
FROM actor
WHERE first_name = "John";

-- 3 Find all actors with surname 'Neeson'.
SELECT *
FROM actor
WHERE last_name = "Neeson";

-- 4 Find all actors with ID numbers divisible by 10.
SELECT *
FROM actor
WHERE actor_id % 10 = 0;

-- 5 What is the description of the movie with an ID of 100?
SELECT 
	`description`
FROM film
WHERE film_id = 100;

-- 6 Find every R-rated movie.
SELECT *
FROM film
WHERE rating = "R";

-- 7 Find every non-R-rated movie.

SELECT *
FROM film
WHERE rating != "R";

-- ORRRRR 'G', 'PG', 'PG-13', 'R', 'NC-17'

SELECT *
FROM film
WHERE rating = "G" or
	rating = "PG" or
    rating = "PG-13" or
    rating = "NC-17";
    
-- 8 Find the ten shortest movies.
SELECT *
FROM film
ORDER BY length ASC
LIMIT 10;

-- 9 Find the movies with the longest runtime, without using LIMIT
SELECT *
FROM film
WHERE length = 
	(SELECT MAX(length) FROM film)
;

-- 10 Find all movies that have deleted scenes.
SELECT *
FROM film
WHERE find_in_set("Deleted Scenes", special_features);
#WHERE special_features LIKE "%deleted scenes%";

-- 11 Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name
FROM actor
group by last_name
having count(last_name) = 1
order by last_name desc;

-- 12 Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT 
	last_name,
    COUNT(last_name)
FROM actor
group by last_name
having count(last_name) >= 2
order by COUNT(last_name) desc;

-- 13 Which actor has appeared in the most films?
-- Find max from film_actor table
SELECT 
	a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.actor_id)
FROM actor AS a
inner join film_actor AS fa on a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY COUNT(fa.actor_id) DESC
LIMIT 1;

-- 14 When is 'Academy Dinosaur' due?
-- return_date rental
-- inventory_id rental
-- inventory_id inventory
-- film_id inventory
-- film_id film 
-- title film
#SELECT
#	f.title,
#	r.return_date
#from rental AS r
#inner join inventory as i 
#on r.inventory_id = i.inventory_id
#inner join film as f
#on i.film_id = f.film_id
#where f.title = "Academy Dinosaur"
#ORDER BY r.return_date desc
#LIMIT 1
#;

-- Need to redo to see which one is still out and when it is due to be returned!
-- title film
-- film_id film 
-- film_id inventory
-- inventory_id inventory
-- inventory_id rental
-- find the one that doesnt have return date
SELECT
	f.title,
	r.return_date
from rental AS r
inner join inventory as i 
on r.inventory_id = i.inventory_id
inner join film as f
on i.film_id = f.film_id
where f.title = "Academy Dinosaur" AND r.return_date = NULL
#ORDER BY r.return_date desc
#LIMIT 1
;

-- 15 What is the average runtime of all films?
SELECT AVG(`length`)
FROM film;

-- 16 List the average runtime for every film category.
-- film_id film
-- film_id film_category
-- category_id film_category
-- category_id category
-- name category
SELECT
	AVG(f.`length`),
    c.`name`
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.`name`;

-- 17 List all movies featuring a robot.

SELECT *
FROM film
WHERE `description` LIKE "%robot%"
;

-- 18 How many movies were released in 2010?
-- release_year film

SELECT COUNT(*)
FROM film
WHERE release_year = 2010;

-- 19 Find the titles of all the horror movies.
-- title film
-- film_id film
-- film_id film_category
-- category_id film_category
-- category_id category
-- name category

SELECT
	f.title,
    c.`name` AS category_name
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE
	c.`name` like "Horror"
;

-- 20 List the full name of the staff member with the ID of 2.

SELECT
	staff_id,
    CONCAT(first_name, " ", last_name) AS fullname
FROM staff
WHERE staff_id = 2;

-- 21 List all the movies that Fred Costner has appeared in.
-- first_name "Fred" actor
-- last_name "Costner" actor
-- actor_id actor
-- actor_id film_actor
-- film_id film_actor
-- film_id film
-- title film

SELECT
	f.title
FROM film as f
INNER JOIN film_actor as fa
ON f.film_id = fa.film_id
INNER JOIN actor as a
ON fa.actor_id = a.actor_id
WHERE
	a.first_name = "Fred" AND a.last_name = "Costner";
    
-- 22 How many distinct countries are there?
-- country country
SELECT
	COUNT(c.country),
    c.country as country_name
FROM country As c
group by country;
-- 109 rows

-- 23 List the name of every language in reverse-alphabetical order.
-- name language

SELECT
	`name`,
    language_id
FROM `language`
ORDER BY `name` DESC;

-- 24 List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
-- last_name actor
-- first_name actor

SELECT
	concat(first_name, " ", last_name)
FROM actor
WHERE last_name like "%son"
order by first_name asc;

-- 25 Which category contains the most films?
-- film_id film_category
-- category_id film_category
-- category_id category
-- name category

SELECT
	c.`name`,
    COUNT(fc.film_id)
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.`name`
ORDER BY COUNT(fc.film_id) DESC
;
-- Sports