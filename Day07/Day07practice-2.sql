--practicing subqueries and basic subquerying

--find films longer than the average film length 
select length from film; --okay format is in minutes 

select * from film 
where length > 
(select avg(length)
from film
);

--find customers who made atleast one payment 
select * from customer 
where customer_id in (
select customer_id from payment);

--Find films whose rental rate is higher than the average rental rate.

select * from film 
where rental_rate > 
(select avg(rental_rate)
from film);

--Find actors who appear in at least one film.

select * from actor 
where actor_id in 
( select actor_id from film_actor
);

--Find customers whose total payments exceed the average customer spending.



select c.customer_id,sum(amount)
from customer c join payment p 
on c.customer_id = p.customer_id 
group by c.customer_id 
having sum(amount) > 
(
select avg(total_amt) --this will give average of customer payments
from
(
select customer_id, sum(amount) as total_amt
from payment--this gives sum of all payments
group by customer_id
)t
);


--Find films whose length equals the maximum film length

select *
from film f
where f.length = 
(
select max(length)
from film f );

--Find customers who have never made a payment. 
select * from customer 
where customer_id not in (
select customer_id from payment);

--Find films that have never been rented. 

--for this we have to  inventory join rental 

select * 
from film 
where film_id not in (
select film_id from inventory i right join rental r
on i.inventory_id = r.inventory_id);

--Find categories that contain more films than the average number of films 

select count(film_id),rating from film
group by rating
having count(*) > 
(select avg(film_count)
from
(
select count(film_id) as film_count 
from film 
group by rating
)t
);