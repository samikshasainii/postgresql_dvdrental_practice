------------------------------------------------------------------------------------------------------
--multiple joins and multiple grouping

--this is gicing us number of movies per language per category per rating
select category.name, film_category.category_id,count(film.title),film.rating,language.name
from category join film_category on 
category.category_id=film_category.category_id
join 
film on film_category.film_id=film.film_id 
join language on film.language_id = language.language_id
group by film_category.category_id, film.rating,language.name,category.name;


--find number of unique films per category per inventory 
select category.name, count(distinct film.film_id), inventory.store_id
from category join film_category on 
category.category_id = film_category.category_id 
join film on film_category.film_id = film.film_id 
join inventory on film.film_id = inventory.film_id 
group by category.name,inventory.store_id
order by store_id asc;

--find number of films (including copies) per category per inventory 
select category.name, count(*), inventory.store_id
from category join film_category on 
category.category_id = film_category.category_id 
join film on film_category.film_id = film.film_id 
join inventory on film.film_id = inventory.film_id 
group by category.name,inventory.store_id
order by store_id asc; 

------------------------------------------------------------------------------------------------------
--using group by with date column 

--revenue earned on each day
select payment_date::date as "payment date", sum(payment.amount)
from payment 
group by "payment date" 
order by "payment date";

---------------------------------------------------------------------------------------------------
--Having clause 

--Show customers who made more than 30 payments.

select first_name||' '||last_name, count(p.payment_id)
from customer as c join payment as p on
c.customer_id = p.customer_id
group by c.customer_id 
having count(p.payment_id)>30;

--Show categories having more than 30 films 
select category.name,count(film.film_id)
from category join film_category on 
category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.name
having count(film.film_id)>30
order by count(film.film_id) ;


--Show customers who rented more than 40 movies.
select customer.customer_id, first_name||' '||last_name as "full name", count(rental_id)
from customer join rental on 
customer.customer_id = rental.customer_id
group by customer.customer_id, "full name"
having count(rental_id)>40
order by count(rental_id) desc;
------------------------------------------------------------------------------------------------------
--grouping sets 
--Show:

--total payments per customer
--total payments per staff member
--overall total payments

select customer.customer_id, staff.staff_id,count(payment_id)
from customer 
join payment on customer.customer_id = payment.customer_id 
join staff on payment.staff_id = staff.staff_id 
group by grouping sets (
(customer.customer_id),
(staff.staff_id),
()
)
order by staff.staff_id desc ,customer.customer_id desc;


--lets try cube group by
SELECT
    film.rating,
    language.name,
    COUNT(*)
FROM film
JOIN language
ON film.language_id = language.language_id
GROUP BY CUBE(film.rating, language.name)
ORDER BY
    film.rating,
    language.name;