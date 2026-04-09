-- SQL dialect: MySQL 8.0 (MySQL Workbench)
use sakila;
-- =========================================================


-- Question 1
select c.customer_id, c.first_name, c.last_name, c.email, c.address_id, c.active
from customer c
where c.customer_id in (
    select p.customer_id
    from payment p
    group by p.customer_id
    having count(*) > 5
);

-- Question 2
with actor_film_count as (
    select fa.actor_id, count(*) as film_total
    from film_actor fa
    group by fa.actor_id
)
select a.first_name, a.last_name
from actor a
join actor_film_count afc
    on a.actor_id = afc.actor_id
where afc.film_total > 10;

-- Question 3
select c.first_name, c.last_name
from customer c
where not exists (
    select 1
    from payment p
    where p.customer_id = c.customer_id
);

-- Question 4
select f.title, f.rental_rate
from film f
where f.rental_rate > (
    select avg(rental_rate)
    from film
);

-- Question 5
drop view if exists rented_film_ids;

create view rented_film_ids as
select distinct i.film_id
from inventory i
join rental r
    on r.inventory_id = i.inventory_id;

select f.title
from film f
left join rented_film_ids rf
    on f.film_id = rf.film_id
where rf.film_id is null;

-- Question 6
drop temporary table if exists cust5_rental_months;

create temporary table cust5_rental_months
select distinct month(rental_date) as rent_month
from rental
where customer_id = 5;

select distinct c.customer_id, c.first_name, c.last_name
from customer c
join rental r
    on c.customer_id = r.customer_id
where month(r.rental_date) in (
    select rent_month
    from cust5_rental_months
)
and c.customer_id <> 5;

-- Question 7
select distinct s.staff_id, s.first_name, s.last_name
from staff s
join payment p
    on s.staff_id = p.staff_id
where p.amount > (
    select avg(amount)
    from payment
);

-- Question 8
with avg_rental_len as (
    select avg(rental_duration) as avg_days
    from film
)
select f.title, f.rental_duration
from film f
join avg_rental_len a
    on f.rental_duration > a.avg_days;

-- Question 9
select c.customer_id, c.first_name, c.last_name, c.address_id
from customer c
where c.address_id = (
    select address_id
    from customer
    where customer_id = 1
)
and c.customer_id <> 1;

-- Question 10
with payment_avg as (
    select avg(amount) as avg_amt
    from payment
)
select p.payment_id, p.customer_id, p.staff_id, p.rental_id, p.amount, p.payment_date
from payment p
join payment_avg pa
    on p.amount > pa.avg_amt;
