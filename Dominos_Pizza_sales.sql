select * from dom_customers;
select * from dom_orders;
select * from dom_order_details;
select * from dom_pizzas;
select * from dom_pizza_types;

--1. Total Customers ?
SELECT count(*)as total_customers from dom_customers;

--2. Total Orders ?
select distinct count(order_id)total_orders from dom_orders;

--3. Total quantity sold ?
select sum(quantity)quantity_sold from dom_order_details;

--4. Total Revenue
select  
    sum(p.price*o.quantity)as Revenue
from dom_pizzas p
join dom_order_details o
on p.pizza_id = o.pizza_id;


--5. Top 5 selling Pizzas ?     add - size(M,L,XL),name,category
    
select * from(
select pizza_id,
    sum(quantity)qty
from dom_order_details
group by pizza_id
order by sum(quantity) desc)
where rownum<=5;
    
--6. Bottom 5 Selling pizzas ?    add - size(M,L,XL),name

select * from (
    select pizza_id,
    sum(quantity)
from dom_order_details
group by pizza_id
order by sum(quantity) asc)
where rownum<=5;

--7. Highest-Priced Pizza
select pizza_id,price as highest_price_pizza  
    from dom_pizzas where price=(
select max(price)
     from dom_pizzas);

--8. Most Common Pizza Size Ordered?

select * from
(select
    p.pizza_size,
    sum(o.quantity)qty_ordered
from dom_pizzas p join dom_order_details o
on p.pizza_id = o.pizza_id
group by p.pizza_size
order by sum(o.quantity) desc)
where rownum=1;

--9. Total Quantity by Pizza Category ?

select
    pt.category,
    sum(o.quantity)as total_qty
from dom_pizza_types pt
join dom_pizzas p
on pt.pizza_type_id = p.pizza_type_id
join dom_order_details o
on p.pizza_id = o.pizza_id
group by pt.category;


--10. Orders by weekDay ?

select distinct
    to_char(order_date,'Day')as weekday,
    count(distinct order_id)total_orders
    from dom_orders 
    group by to_char(order_date,'Day')
    order by total_orders desc;


--11. Avg orders per customer

select
    round(count(distinct order_id)/
    count(distinct custid),2)as avg_order_per_person 
    from dom_orders;
    

--12. Average Pizzas Ordered per Day

SELECT 
    ROUND(SUM(o.quantity) / COUNT(DISTINCT round(od.order_date)), 2) AS avg_pizzas_per_day
FROM dom_orders od
JOIN dom_order_details o
    ON od.order_id = o.order_id;


--13. Category-Wise Pizza Distribution ?

select 
    pt.category,
    count(p.PIZZA_ID)distribution
    from dom_pizza_types pt
join dom_pizzas p
on pt.PIZZA_TYPE_ID = p.PIZZA_TYPE_ID
group by pt.category;


--14. Top 5 Pizzas by Revenue

select * from (
    select p.pizza_id,
    round(sum(o.quantity * p.price))as total_revenue
from dom_order_details o
join dom_pizzas p
on p.pizza_id = o.pizza_id
group by p.pizza_id
order by total_revenue desc)
where rownum<=5;


--15. Revenue by Pizza Size ?

select p.pizza_size,
    round(sum(o.quantity * p.price))as total_revenue
from dom_pizzas p
join dom_order_details o 
on p.pizza_id = o.pizza_id
group by p.pizza_size;


--16. Cumulative Revenue Over Time ?

SELECT 
    TRUNC(od.order_date) AS order_day,
    ROUND(SUM(p.price * o.quantity), 2) AS daily_revenue,
    ROUND(SUM(SUM(p.price * o.quantity)) 
          OVER (ORDER BY TRUNC(od.order_date)), 2) AS cumulative_revenue
FROM dom_orders od
JOIN dom_order_details o
    ON od.order_id = o.order_id
JOIN dom_pizzas p
    ON o.pizza_id = p.pizza_id
GROUP BY TRUNC(od.order_date)
ORDER BY order_day;



--17. MOM Growth pct

With monthly_orders as(
select 
    extract(month from order_date)as months,
    count(distinct order_id)as total_orders
    from dom_orders
    group by  extract(month from order_date)
    order by months asc)
    
select months,total_orders,
lag(total_orders)over(order by months)as prev_month,
round(100*(total_orders-lag(total_orders)over(order by months))/nullif(lag(total_orders)over(order by months),0),2) as mom_growth_pct
from monthly_orders
order by months; 


--18. Orders by Hour of the Day ? 

SELECT 
    TO_CHAR(order_time, 'HH') AS hour_of_day,
    COUNT(order_id) AS total_orders
FROM dom_orders
GROUP BY TO_CHAR(order_time, 'HH')
ORDER BY hour_of_day;


--19. Top 10 Customers by Spending ?

select * from (select
    o.custid,
    round(sum(od.quantity*p.price))total_spend
from dom_orders o
join dom_order_details od
on o.order_id = od.order_id
join dom_pizzas p on
od.pizza_id = p.pizza_id
group by o.custid
order by total_spend desc)
where rownum<=10;
    

--20.Seasonal Trends ?

select 
    to_char(o.order_date,'Month')as Month,
    round(sum(od.quantity*p.price))revenue
from dom_orders o
    join dom_order_details od
on o.order_id = od.order_id
    join dom_pizzas p 
on od.pizza_id = p.pizza_id
group by to_char(o.order_date,'Month')
order by revenue desc;


--21. Average Order Size ?

select
    p.pizza_size,
    round(avg(od.quantity),2)avg_qty_per_size
from dom_pizzas p
join dom_order_details od
on p.pizza_id = od.pizza_id
group by  p.pizza_size
order by avg_qty_per_size desc;


--22. order status distribution
SELECT status,
       COUNT(order_id) AS total_orders
FROM dom_orders
GROUP BY status;

--23. which category uses the most unique or diverse ingredients. ?

SELECT category, COUNT(DISTINCT ingredients) AS unique_ingredient_combos
FROM dom_pizza_types
GROUP BY category
ORDER BY unique_ingredient_combos DESC;

-- 24.Repeat Customer Rate

SELECT 
    custid,
    ROUND(
        (COUNT(DISTINCT  order_id)))as order_count
    from dom_orders
    group by custid
    order by  order_count desc;
    
--25. Cumulative Order Trends
 select
    order_Date,
    count(order_id)as daily_orders,
    sum(count(order_id))over(order by order_date) as cumulative_orders
    from dom_orders
    group by order_Date
    order by order_Date;