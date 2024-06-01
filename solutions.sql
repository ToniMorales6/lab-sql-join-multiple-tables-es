use sakila;

-- 1 Escribe una consulta para mostrar para cada tienda su ID de tienda, ciudad y país.
SELECT store_id, city, country
FROM store, address, city, country
WHERE 
	store.address_id = address.address_id
    AND
    address.city_id = city.city_id
    AND
    city.country_id = country.country_id;
    
-- opcion con joins 
SELECT s.store_id, ci.city, co.country
	FROM sakila.store AS s
    LEFT JOIN sakila.address AS a
		ON s.address_id = a.address_id
	LEFT JOIN sakila.city AS ci
		ON a.city_id = ci.city_id
    LEFT JOIN sakila.country AS co
		ON ci.country_id = co.country_id;

-- 2 Escribe una consulta para mostrar cuánto negocio, en dólares, trajo cada tienda.
SELECT sto.store_id, count(p.amount) AS money_total
	FROM sakila.store as sto
	JOIN sakila.staff as sta
		ON sto.store_id = sta.store_id
	JOIN sakila.payment as p
		ON p.staff_id = sta.staff_id
	GROUP BY sto.store_id;
    
-- 3 ¿Cuál es el tiempo de ejecución promedio de las películas por categoría?
SELECT c.name as category, avg(f.length) as average_length
	FROM sakila.category as c
	JOIN sakila.film_category as fc
		ON c.category_id = fc.category_id
	JOIN sakila.film as f
		ON f.film_id = fc.film_id
	GROUP BY c.name;

-- 4 ¿Qué categorías de películas son las más largas?
SELECT c.name as category, avg(f.length) as average_length
	FROM sakila.category as c
	JOIN sakila.film_category as fc
		ON c.category_id = fc.category_id
	JOIN sakila.film as f
		ON f.film_id = fc.film_id
	GROUP BY c.name
	ORDER BY average_length DESC;

-- 5 Muestra las películas más alquiladas en orden descendente.
SELECT f.title AS film_title, count(r.rental_id) AS rent_frequency
	FROM sakila.film AS f
	JOIN sakila.inventory AS i
		ON f.film_id = i.film_id
	JOIN sakila.rental AS r
		ON i.inventory_id = r.inventory_id
	GROUP BY f.title
	ORDER BY COUNT(r.rental_id) DESC;

-- 6 Enumera los cinco principales géneros en ingresos brutos en orden descendente.
SELECT c.name as category, count(fc.category_id) as num_films
	FROM sakila.category as c
    JOIN sakila.film_category as fc
		ON c.category_id = fc.category_id
    GROUP BY c.name
    ORDER BY num_films DESC;

-- 7 ¿Está "Academy Dinosaur" disponible para alquilar en la Tienda 1?
SELECT i.store_id, f.title, count(i.film_id) as existing
	FROM sakila.film as f
    JOIN sakila.inventory as i
		ON f.film_id = i.film_id
    JOIN sakila.rental as r
		ON r.inventory_id = i.inventory_id
    WHERE f.title LIKE "Academy Dinosaur" AND i.store_id = 1
    GROUP BY f.title;