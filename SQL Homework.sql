
USE sakila;

#1a Display the first and last name
SELECT first_name, last_name 
FROM actors2;

#2 first and last name in single column called 'Actor Name' in capital letters
Select CONCAT(first_name,' ', last_name) as "Actor Name"
FROM actors2;

#2a First name "Joe"
SELECT * FROM actors2
WHERE first_name LIKE 'Joe%';

#2b Last name contain the letters "GEN"
SELECT * FROM actors2
WHERE last_name LIKE '%GEN%';

#2c Actor last name contain "LI". (last name, first name)
SELECT last_name, first_name FROM actors2
WHERE last_name LIKE '%LI%';

#2d Using 'IN' display 'country_id' and 'country': Afghanistan, Bangladesh, and China
SELECT country_id, country FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a Create column in actor named 'description' - type: BLOB
ALTER TABLE actors2
ADD description BLOB;
SELECT * FROM actors2;

#3b drop description
ALTER TABLE actors2
DROP COLUMN description;
SELECT * FROM actors2;

#4a List last_name and count last_name
SELECT COUNT(actor_id), last_name
From actors2
GROUP BY last_name;

#4b Same as above, but must at least have 2 names
SELECT COUNT(actor_id), last_name
FROM actors2
GROUP BY last_name
HAVING COUNT(actor_id) > 1;

#4c change Groucho to Harpo
UPDATE actors2
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#4d change Harpo back to Groucho
UPDATE actors2
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

SELECT * FROM actors2
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#5a recreate 'address' table
SHOW CREATE TABLE address;

#6a. Join staff and address tables on first and last name
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address on staff.address_id = address.address_id
ORDER BY staff.address_id;

#6b. Join staff and payment, display total amount rung up of 8/2005
#SELECT * FROM staff;
#SELECT * FROM payment;
SELECT staff.staff_id, SUM(payment.amount)
FROM staff
Inner JOIN payment on payment.staff_id = staff.staff_id
WHERE payment_date LIKE ('2005-08%')
GROUP BY staff.staff_id;

#6c. List film and # of actors in film.
#SELECT * FROM film;
#SELECT * FROM film_actor
SELECT film.title, count(actor_id)
FROM film
INNER JOIN film_actor on film_actor.film_id = film.film_id
Group By title;

#6d. Count of 'Hunchback Impossible'
#SELECT * FROM film;
#SELECT * FROM inventory;
SELECT film.title, count(inventory_id)
FROM film
INNER JOIN inventory on inventory.film_id = film.film_id
Where title ='Hunchback Impossible';

#6e. list total paid by each customer. customer in ABC order by last name.
#SELECT * FROM customer;
#SELECT * FROM payment;
SELECT customer.last_name, sum(amount)
FROM customer
INNER JOIN payment on customer.customer_id = payment.customer_id
GROUP BY last_name;

#7a. movies with titles that begin with K & Q
#SELECT * FROM film;
#SELECT * FROM language;
SELECT title #, language_id
FROM film
	Where title LIKE 'k%' OR title LIKE 'Q%'
		AND language_id = 1;

#7b diplay all actors who appear in film 'Alone Trip'
SELECT * FROM film_actor;
SELECT * FROM actors2;
SELECT * FROM film;

SELECT actors2.first_name, actors2.last_name
FROM film_actor
INNER JOIN actors2 on film_actor.actor_id = actors2.actor_id
INNER JOIN film on film.film_id = film_actor.film_id
where title = 'ALONE TRIP';

#7c names and email addresses of Canadian customers
#SELECT * FROM customer; #email, first_name, last_name, address_id 
#SELECT * FROM city; #city_id, city, country_id
#SELECT * FROM country; # country_id, country
#SELECT * FROM address;# address_id, city_id
		
SELECT customer.first_name, customer.last_name, customer.email 
FROM address 
INNER JOIN customer on address.address_id = customer.address_id
INNER JOIN city on city.city_id = address.city_id
INNER JOIN country on city.country_id = country.country_id
WHERE country.country_id ='20';

#7d. id all movies labeled family films

SELECT film.title, category.name
FROM film
INNER JOIN film_category on film.film_id = film_category.film_id
INNER JOIN category on film_category.category_id = category.category_id
    WHERE category.name = 'Family';
       
#7e most frequently rented movies in descending order
#SELECT * FROM rental;
#SELECT * FROM inventory;
#SELECT * FROM film;

SELECT film.title, count(rental.rental_date)
FROM rental
INNER JOIN inventory on inventory.inventory_id = rental.inventory_id
INNER JOIN film on inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY count(rental.rental_date) DESC;

#7f. sum of total revenue by store
#SELECT * FROM store; 
#SELECT * FROM rental; #inventory_id
#ELECT * FROM payment; #rental_id
#SELECT * FROM inventory; #store_id

SELECT store.store_id, sum(amount) AS 'Total Revenue'
FROM store
INNER JOIN inventory on inventory.store_id = store.store_id
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on rental.rental_id = payment.rental_id
GROUP BY store.store_id;

#7g. diplay store ID, city, country
SELECT store.store_id, city.city, country.country
FROM store
INNER JOIN address on address.address_id = store.address_id
INNER JOIN city on city.city_id = address.city_id
INNER JOIN country on country.country_id = city.country_id
GROUP BY store_id;

#7h. top five genres in gross revenue

SELECT category.name AS 'Genre'
FROM category
INNER JOIN film_category on film_category.category_id = category.category_id
INNER JOIN inventory on inventory.film_id = film_category.film_id
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on payment.rental_id = rental.rental_id 
GROUP BY category.name
ORDER BY sum(category.name) DESC LIMIT 5;

#8a Easy way to view to 5 genres by revenue
SELECT category.name AS 'Genre', sum(payment.amount) AS 'Gross Revenue'
FROM category
INNER JOIN film_category on film_category.category_id = category.category_id
INNER JOIN inventory on inventory.film_id = film_category.film_id
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on payment.rental_id = rental.rental_id 
GROUP BY category.name
ORDER BY sum(payment.amount) DESC LIMIT 5;

#8b  create view from 8a
CREATE VIEW Top_Genre AS
SELECT category.name AS'Genre', sum(payment.amount) AS 'Gross Revenue'
FROM category
INNER JOIN film_category on film_category.category_id = category.category_id
INNER JOIN inventory on inventory.film_id = film_category.film_id
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on payment.rental_id = rental.rental_id 
GROUP BY category.name
ORDER BY sum(payment.amount) DESC LIMIT 5;

#8c Drop view from 8b
DROP VIEW Top_Genre