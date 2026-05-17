--day 3 , boutta learn joins

----------------------------------------------------------------------------------------------------------
--Inner join on our same dvdrental dataset 

--we're going to try to find the address of Anne 
select customer.address_id,
address,
phone,
postal_code,
first_name,
last_name
from customer inner join address 
on address.address_id = customer.address_id
where customer.first_name like '%Anne%' and customer.last_name like '%Pow%'; --found anne powell 

--show first name, last name, address, district and phone 
select first_name, last_name, address,address2,district,postal_code,phone
from  customer inner join address 
on customer.address_id = address.address_id;

--show film title, release year and lnaguage name 
select title, release_year, language.name
from film inner join language 
on film.language_id = language.language_id;

---------------------------------------------------------------------------------------------------------

--basic left join on dvdrental dataset
--show all customers and their payments
select customer.first_name||' '||customer.last_name as "full name", payment.amount, payment.payment_date 
from customer left join payment 
on customer.customer_id = payment.customer_id;

--show all films with their language 
select title,name from 
film left join language
on film.language_id = language.language_id;

--show all staff members' names and their storeid with manager staff id 
select first_name||' '||last_name as "full name", staff.store_id, manager_staff_id
from staff left join store 
on staff.store_id = store.store_id;

--show all customers including those with no rentals

select first_name||' '||last_name as "full name",rental_date,return_date 
from customer left join rental 
on customer.customer_id = rental.customer_id
order by rental_date nulls first; 

--left anti join
select first_name||' '||last_name as "full name",rental_date,return_date 
from customer left join rental 
on customer.customer_id = rental.customer_id
where rental.customer_id is null; --okay so there's like no nulls in these relations at all 

---------------------------------------------------------------------------------------------------------
--right joins and right anti joins 
--show film titles and inventory IDs, but show all the films that exist in the inventory 
--ie: right join on inventory 

select title, inventory.inventory_id 
from film right join inventory 
on film.film_id = inventory.film_id;

--anti right join 
--find possible null rows 
--lets try to find all rentals without a valid staff
--for this we will perform right anti join 
select staff.first_name, staff.last_name, rental_date, rental_id 
from staff right join rental 
on staff.staff_id = rental.staff_id
where staff.staff_id is null; --as expected this returns nothing because this dataset is too good

------------------------------------------------------------------------------------------------------------
--full outer join 
--find all customers, with all payments and matching customer payment records, including no payments etc etc 

select first_name||' '||last_name as "full name", email,payment_id,payment_date,amount 
from customer full outer join payment 
on customer.customer_id=payment.customer_id
order by payment.amount nulls first;

--------------------------------------------------------------------------------------------------------------
--table aliases 
--we can rename the tables using keyword as 
select first_name||' '||last_name as "full name", email,payment_id,payment_date,amount 
from customer as c full outer join payment as p
on c.customer_id =p.customer_id ;

--this is done for easier querying 

---------------------------------------------------------------------------------------------------------