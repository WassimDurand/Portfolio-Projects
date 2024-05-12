select * from pizza_sales;

-- 1. kpi's requirements

-- 1.1 Total Revenue : The sum of the total price of all pizza orders

select SUM(total_price) as Total_Revenue from pizza_sales;

-- 1.2 Average Order Value : The average amount spent per order, calculated by dividing the total revenue by the total number of orders

select (SUM(total_price) / count(distinct(order_id))) as Average_Order_Value from pizza_sales;

-- 1.3 Total Pizzas sold : The sum of the quantitites of all pizza sold

-- The following query shows the sum of pizzas sold for each pizza name
select pizza_name_id, SUM(quantity) as Quantity_per_Pizza
from pizza_sales
group by pizza_name_id
order by Quantity_per_Pizza desc;

-- Total pizzas sold
select SUM(quantity) as Total_Pizzas_Sold
from pizza_sales;

-- 1.4 Total Orders : The total numbers of orders placed

select COUNT(distinct(order_id)) as Total_Orders from pizza_sales;

-- 1.5 Average Pizzas Per order : The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders

select CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(distinct order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS avg_pizzas_per_order from pizza_sales;


-- 2. Charts Requirements

-- 2.1 Daily Trend for Total Orders
-- Bar chart that displays the daily trend of total orders over a specific time period. This chart will help identify any pattern or fluctuation in order volumes on a daily basis

select DATENAME(dw, order_date) as Day_Of_Week, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME(dw, order_date);

-- 2.2 Monthly Trend for Total Orders

select DATENAME(MONTH, order_date) as Month_of_Year, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME(MONTH, order_date)
order by Total_Orders desc;

-- 2.3 Percentage of Sales by Pizza Category

select pizza_category, concat(round(SUM(total_price) / (select SUM(total_price) from pizza_sales) * 100, 2), '%') as PCT_Total_Sales
from pizza_sales
group by pizza_category
order by PCT_Total_Sales desc;

-- 2.4 Percentage of Sales by Pizza Size

select pizza_size, concat(round(SUM(total_price) / (select SUM(total_price) from pizza_sales) * 100, 2), '%') as PCT_Total_Sales
from pizza_sales
group by pizza_size
order by PCT_Total_Sales desc;

-- 2.5 Top 5 Best sellers by Revenue, Total Quantity, and Total Orders

-- 2.5.1 Top 5 Revenue

select TOP 5 pizza_name, cast(sum(total_price) AS DECIMAL(10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc;

-- 2.5.2 Top 5 Quantity

select TOP 5 pizza_name, sum(quantity)as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity desc;

-- 2.5.3 Top 5 Total_Orders

select TOP 5 pizza_name, count(distinct (order_id)) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders desc;

-- 2.6 BOTTOM 5 Best sellers by Revenue, Total Quantity, and Total Orders

-- 2.6.1 Bottom 5 Revenue

select TOP 5 pizza_name, cast(sum(total_price) AS DECIMAL(10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue;

-- 2.6.2 Bottom 5 Quantity

select TOP 5 pizza_name, sum(quantity)as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity;

-- 2.6.3 Bottom 5 Total Orders

select TOP 5 pizza_name, count(distinct (order_id)) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders;


