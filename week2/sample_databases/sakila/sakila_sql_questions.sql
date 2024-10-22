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

