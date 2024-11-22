--select * from actor;

--select first_name, last_name from actor;

--select first_name, last_name from actor order by last_name, first_name;

--select first_name, last_name from actor where last_name like '%D' order by last_name, first_name;

--select distinct first_name from actor order by first_name;

--select first_name, count(*) as amount from actor group by first_name order by amount desc;

--select * from staff;
--select * from store;

--select staff.first_name, staff.store_id, store.manager_staff_id
--from staff
--inner join store on staff.store_id = store.store_id;

--select * from actor;
--select * from film;
--select * from film_actor;

--select actor.first_name, actor.last_name, film.title
--from actor 
--inner join film_actor on actor.actor_id = film_actor.actor_id
--inner join film on film_actor.film_id = film.film_id

-- Koppla ihop film och category
--select * from film;
--select * from category;
--select film.title as film_title, category.name as film_category
--from film
--inner join film_category on film.film_id = film_category.film_id
--inner join category on category.category_id = film_category.category_id

--use FredrikStudents;
--select * from Trainers;
--use FredrikStudents;
--insert Trainers (FirstName, LastName) values  ('Bengan', 'Borked');
--delete Trainers where FirstName = 'Bengan';
use sakila;
--select count(*) as film_count from film;
--select * from language;
--select * from city where city = 'Bern';

--select * from address;
--select * from customer;

--select count(*) as total
--from address
--inner join customer on address.address_id = customer.address_id;

--SELECT COUNT(amount) as amountOfPayments,
--	MAX(amount) as maxAmount,
--	MIN(amount) as minAmount,
--	AVG(amount) as averageAmount,
--	SUM(amount) as totalAmount,
--	customer.first_name,
--	customer.last_name,
--	customer.email
--FROM payment
--inner join customer on payment.customer_id = customer.customer_id
--WHERE amount > 0
--GROUP BY customer.first_name,
--	customer.last_name,
--	customer.email
--ORDER BY totalAmount DESC,
--	customer.first_name,
--	customer.last_name;

select first_name, last_name, count(film_actor.actor_id) as movie_count
from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
group by first_name, last_name
order by movie_count desc

--select last_name
--from actor
--where last_name = 'kilmer'