--find the product pairs purchased together.

create table orders
(
order_id int,
customer_id int,
product_id int,
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');


--select * from orders
--select * from products


with cte as (
select o1.product_id as prod_1, o2.product_id as prod_2
from orders o1
inner join orders o2 on o1.order_id = o2.order_id and o1.product_id < o2.product_id)
, convert_to_letter as (
select p1.name as name_1, p2.name as name_2
from cte c
inner join products p1 on c.prod_1 = p1.id
inner join products p2 on c.prod_2 = p2.id)

select name_1 + '' + name_2 as product_pairs, count(*) as product_frequency
from convert_to_letter
group by name_1, name_2