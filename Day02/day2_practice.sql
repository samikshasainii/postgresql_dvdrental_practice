--day 2 of postgresql practice 
-- today we're going to practice filtering data


---------------------------------------------------
--WHERE Clause

--suppose I want to find all films released in 2008,2009 and 2010 
select * 
from film 
where release_year in (2008,2009,2010);

--okay it returned nothing 
select*from film 
limit 10;

--we're going to check the release dates of the films using this, since the data is big we're limiting it
--to 10 rows

--okay I see the issue, the release_year is 2006, for all movies

select * from film 
where release_year = 2006; --this is going to give us movies released in 06

--using WHERE with OR 
--okay we're going to try to find what countries are 55 and let's say 104 , using the OR operator

select * from country 
where country_id = 1 or country_id = 104; --this gave us afghanistan and venezuela 
--both war'd with US, what a coincidence , LOL 

--USING WHERE WITH AND 
--AND GIVES US COMMON ROWS AMONG THE TWO CONDITIONS 

select * from customer 
where customer_id in (1,2,3,4,5) and activebool = true; 

--this gave us first 5 customers who are still active ! let's find customers who aren't active 
select * from customer 
where activebool = false; --goddam all are active 

--##USING WHERE WITH THE LIKE OPERATOR
select * from customer 
where first_name like 'Ann%' or first_name like 'Car%' ; --maybe i'm looking for an anne or anna or carolyn

select * from customer 
where first_name like '%lyn%'; --maybe her name had a lyn in it but i dont remember what it starts or ends with

select*from customer 
where last_name like '%al'; --her last name ended with an al ! 

--okay frick maybe her name was mohammed 
select * from customer where last_name like '%mohammed%' or last_name like '%mohammed%';
--okay that's not it

--USE WHERE WITH  BETWEEN OPERATOR 
--between operator returns true if a value lies within a range of values 

--hmm she had a pretty short name 
select * from customer 
where first_name like 'A%' and 
length(first_name) between 3 and 4
order by first_name asc; 

select * from country 
where country_id between 1 and 10
order by country_id asc; --found names of 10 countries which start with A lol

-----------------------------------------------------------------------------------------------------------
--moving on to more use cases of the AND operator

select first_name,last_name as "full name"
from actor 
where actor_id between 1 and 100 --one use case of and
and first_name like '%Ann%'; --another and used 

--and is used for boolean true false of conditions almost always in postgresql 

select title,rating
from film 
where rental_rate > 1 and language_id = 1
order by title asc; 

-----------------------------------------------------------------------------------------------------------

--#using limit and offset
select * from customer 
where first_name like '%ann%'
order by customer_id desc
limit 5 --show only 5 rows
offset 2; --skip the first 2 rows
--------------------------------------------------------------------------------------------------------
--##using FETCH clause 
--fetch is basically industry standard as compared to limit 

select * from customer 
where first_name like '%Ann%'
order by customer_id desc 
offset 1
fetch first 5 rows only; 

-------------------------------------------------------------------------------------------------------
--more use cases of the In operator 

--using it with dates

select * from payment 
where payment_date::date in ('2007-02-15','2006-02-13')
order by payment_date desc;

--using NOT IN operator
select * from country 
where country_id not in (1,2,3);
-------------------------------------------------------------------------------------------------------
--using between with a date range 
select * from payment 
where payment_date::date between '2006-02-01' and '2007-12-01';

--------------------------------------------------------------------------------------------------------