--basic querying practice on dvdrental dataset 
-- all done by samiksha saini

--day 1 practice 

select customer_id, first_name, last_name from customer
order by customer_id asc;
--order by is important, without order by, postgresql is free to return rows in whatever order it may like

select * from customer 
order by first_name, last_name ; --this will sort by alphabetical order of first and last name. 



--using concatenation operator 
--this is done to join composite attributes 
--denoted by || 

select first_name || ' '|| last_name as name , email from customer
order by customer_id;
--you can order by an attribute that isn't in the select statement 

select now(); --testing out what this does
--ok this function returns date and time of the current postgresql server

select payment_id, payment_date from payment 
order by payment_date desc;
--finding the payments according to dates in descending order 

--using NULLS FIRST and NULLS last 

--when you're dealing with a relation that may contain null values, you can choose to 
--order by null values ie: whether you want the null values first or last 

select * from customer 
order by last_update asc nulls first;