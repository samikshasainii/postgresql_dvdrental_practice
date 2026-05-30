--------------------------------------------------------------------------------------------------------------
--transactions and DML commands 
--INSERT 

--lets insert a new customer into customer 
select * 
from customer
order by customer_id desc; --okay a customer id we can make is 600

rollback;
begin;
insert into address(address_id,address,address2,district,city_id,postal_code,phone,last_update)
values (606,'c5 prakash apartment','Ramaiah Nagar','RT Nagar',100,'560032',+91123456789,CURRENT_DATE)
returning*;

	insert into customer(customer_id,store_id,first_name,last_name,email,address_id,activebool,create_date, last_update,active)
	values (600,2,'Samiksha','Sai','samikshasaii@look.com',606,true,CURRENT_DATE,now(),1)
	returning * ;
rollback;

--to find the most recent updated address 
select address_id from address 
order by address_id desc; --okay so we can insert a 606 

--lets update some value 
select * from city 
where city like '%Bhopal'; --trying to find bhopal 
--city id = 76 okay 

begin;
 ---------------------------------------------------------------------------------------------------------
--update 
--a basic single row update 

select * from customer 
where first_name like '%Ann%';
rollback;
begin;
update customer 
set email = 'Annevans@gmail.com'
where first_name = 'Ann' and last_name = 'Evans'
returning *;
commit; 

--updating multiple columns 
select * from city 
join country on 
city.country_id = country.country_id
where country like '%India%'; 
rollback;
begin;
update city 
set city = 'Allahabad'
where city_id = 18 and country_id = 44;
commit;

select * from address join city on address.city_id = city.city_id 
where city = 'Allahabad';
--okay they've messed up the entire address so 
rollback;
begin;
update address 
set address = '73, Noorullah Rd, near Prayagraj junction',
    address2 = 'Miurabad',
    district = 'Prayagraj',
    postal_code = '211003'
where address_id = 179
returning *;
commit;


--updating using calculations
--increase replacement cost of adult films 

select replacement_cost 
from film 
where rating = 'PG'; --okay due to inflation everything goes up by 10 dollars 

begin;
update film 
set replacement_cost =replacement_cost+10
where rating = 'PG'
returning *;
commit; --LOL 

------functions inside update 
begin;
update customer 
set email = LOWER(email)
returning *;
commit; 

select * from customer 
where email like '%gmail.com%'; --yay found anne 
----------
--updating using joins 
rollback;
select * from customer join address on customer.address_id = address.address_id 
join city on address.city_id = city.city_id
where city = 'Allahabad'; --what the hell is anette olson doing in prayagraj

begin;
update customer 
set first_name = 'Diya',
    last_name = 'Mirza',
    email = 'diya.mirza69@gmail.com'
from address 
where customer.address_id = address.address_id and
customer_id = 175 and address_id = 179
returning *;
commit; 

--lets find all details of diya mirza 
select * from customer 
where customer_id = 175;
rollback;
----------------------------------------------------------------------------------------------------------
 --DELETE clause 

--trying to delete one row from the table 
--delete child rows that depend on parent thru fkey constraint to maintain data consistency 

--parent : customer 
--child : payment and rental
begin;
delete from payment 
where customer_id = 300
returning *;

select distinct customer_id 
from payment
order by customer_id asc; --300 succesfully deleted inside the transaction

--now rental 
delete from rental 
where customer_id = 300
returning *;

select distinct customer_id 
from rental
order by customer_id asc;
--and then parent customer 
delete from customer 
where customer_id = 300
returning *;

select distinct customer_id 
from customer
order by customer_id asc;
rollback;