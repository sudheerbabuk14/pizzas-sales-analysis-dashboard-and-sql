create database pizzaDB;

use pizzaDB;

select * from pizza_sales

--total revenue

select sum(total_price) as total_sales from pizza_sales;

--average orders value

select sum(total_price)/count(distinct order_id) as avg_order_value from pizza_sales;

--total pizzas sold

select sum(quantity)as total_pizza_sold from pizza_sales;


--total orders

select count(distinct order_id) from pizza_sales;

--average pizza per orders

select cast(cast(sum(quantity) as decimal(10,2)) /
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) avg_pizza_per_orders from pizza_sales;

--daily trend per orders
select datename(dw,order_date) as order_day,count(distinct order_id) as total_orders
from pizza_sales group by datename(dw,order_date);

--monthly trend of order date

select DATENAME(month, order_date) as months,count(distinct order_id) as total_orders
from pizza_sales group by datename(month, order_date);


--percentage of sales by pizza category

select pizza_category, sum(total_price) as total_sales,sum(total_price)*100/
(select sum(total_price) from pizza_sales where month(order_date)=1) as perct_sales
from pizza_sales
where month(order_date)=1 --filter month jan
group by pizza_category;

select pizza_category, sum(total_price) as total_sales,sum(total_price)*100/
(select sum(total_price) from pizza_sales) as perct_sales
from pizza_sales
group by pizza_category;

-- top 5 pizzas revenue

select top 5 pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name order by total_revenue desc;


--bottom top 5 pizzas revenue

select top 5 pizza_name,round(sum(total_price),1) as total_revenue from pizza_sales
group by pizza_name order by total_revenue asc ;

--top 5 pizzas quantity

select top 5 pizza_name,sum(quantity) as total_quantity from pizza_sales
group by pizza_name order by total_quantity desc;

--bottom 5 pizzas quantity

select top 5 pizza_name,sum(quantity) as total_quantity from pizza_sales
group by pizza_name order by total_quantity asc;