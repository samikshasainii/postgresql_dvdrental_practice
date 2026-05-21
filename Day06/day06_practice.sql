-- recursive CTE is not possible in this dataset (dvdrental  because it isnt hierarchical)
--Set operations in postgresql 
--union 

--trying to find movies stored in film
select film_id 
from film
union 
select film_id 
from inventory 
order by film_id asc; 

--so this will remove duplicate rows
select film_id 
from film
union 
select film_id 
from inventory 
order by film_id asc; --this will give me duplicate rows as well 

--------------------------------------------------------------------------------------------------------- 
--intersect operator 
--returns rows available in both tables 

--Find the customer_ids of customers who:

--made at least one payment and rented atleast one movie 

select customer.customer_id
from customer join payment 
on customer.customer_id = payment.customer_id
intersect
select customer.customer_id
from customer join rental 
on customer.customer_id= rental.customer_id ; --intersect compares whole rows not individual columns

-------------------------------------------------------------------------------------------------------
--CTE (Common Table Expressions)


--Find customers whose total payment amount is greater than 200.
with customer_total as (
select customer.customer_id, sum(amount) as total
from customer join payment 
on customer.customer_id = payment.customer_id 
group by (customer.customer_id))
select * from customer_total 
where total>200;

--find films that have been rented more than 30 times 

with times_rented as (
select film.film_id, title, count(rental_id) as rented_count
from inventory join rental 
on inventory.inventory_id = rental.inventory_id 
join film 
on film.film_id = inventory.film_id
group by film.film_id, title)
select * from times_rented 
where rented_count > 30
order by rented_count desc;

--Find staff members who processed more than 300 payments.

with staff_payment as (
select staff.staff_id, first_name||' '||last_name as "full name",count(payment_id) as payment_count
from payment join staff on payment.staff_id = staff.staff_id 
group by staff.staff_id, "full name") 
select * from staff_payment 
where payment_count >300;

--Find customers whose total payment is greater than the average total payment of all customers.

--first use CTE to find avg total payment 
with avg_payment as (
select avg(amount)as avg_amt
from payment) 
select distinct customer.customer_id,first_name||' '||last_name as "full name",payment.amount
from customer join payment 
on customer.customer_id = payment.customer_id
cross join avg_payment
where payment.amount > avg_amt
order by customer.customer_id asc

-----------------------------------------------------------------------------------------------------
--multiple CTEs 
--example 1 : Find customers whose total payment is above the average customer total. 

--first we'll find avg customer total 

with sum_customer_total as(
select customer.customer_id, sum(payment.amount) as sum_total_amount
from customer join payment on customer.customer_id = payment.customer_id
group by customer.customer_id),
avg_customer_total as(
select avg(sum_total_amount) as avg_spending 
from sum_customer_total)
select * from 
sum_customer_total cross join avg_customer_total
where avg_spending>sum_total_amount
order by customer_id ;
----------------------------------------------------------------------------------------------------------