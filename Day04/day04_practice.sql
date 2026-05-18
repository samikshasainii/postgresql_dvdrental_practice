-------------------------------------------------------------------------------------------------------------
--practicing grouping in postgresql 
--group by reduces rows, usually done to apply aggregate functions 

--using group by on dvdrental sample dataset 
--

select customer_id, sum(amount) as "net amt"
from payment 
group by customer_id --this will give us payments every customer has made.
order by "net amt" desc; 

--lets try to use this with a join table 

select payment.customer_id, sum(amount) as "net amt",first_name||' '||last_name as "full name"
from payment join customer 
on payment.customer_id = customer.customer_id
group by payment.customer_id,first_name,last_name --this will give us payments every customer has made.
order by "net amt" desc; --Elenaor hunt seems to be the one paying the most 

--using group by with a count function
--lets try to find the number of films per language 

select film.language_id, language.name,count(*)
from film join language on 
film.language_id = language.language_id
group by film.language_id,language.name;

--let's try doing multiple grouping
--the total revenue generated per movie rating per staff member.
 
--okay so for this i need to learn multiple joins which we'll do tomorrow