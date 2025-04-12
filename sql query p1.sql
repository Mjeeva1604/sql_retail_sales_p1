## SQL Retail Sales Analysis - P1

create database sql_project_p1;

## Create Table

Create Table retail_sales 
(
transactions_id	int PRIMARY KEY,
sale_date date,
sale_time time,
customer_id	int,
gender varchar(20),
age int,
category varchar(20),
quantiy	int,
price_per_unit float,
cogs	float,
total_sale float
);

SELECT * FROM  retail_sales;

SELECT count(*)FROM retail_sales;

SELECT * FROM  retail_sales WHERE transactions_id IS null;

SELECT * FROM  retail_sales WHERE sale_date IS null;
SELECT * FROM  retail_sales WHERE sale_time IS null;

SELECT * FROM  retail_sales WHERE transactions_id IS null or sale_date is null or gender is null or category is null or quantiy is null or cogs is null or total_sale is null;

## Data exploration....

## Howmany unique costumer we have sales we have?
SELECT count(distinct customer_id) as total_sale from retail_sales;

SELECT distinct category as total_sale from retail_sales;


## 	Business key problems
## 1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

select * from retail_sales where sale_date = "2022-11-05";

## Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

SELECT *FROM retail_sales WHERE category = 'Clothing'AND quantiy >= 4
AND date_format(sale_date,'%Y-%m')='2022-11';

## Write a SQL query to calculate the total sales (total_sale) for each category.**:

SELECT * FROM  retail_sales;

SELECT 
category,
sum(total_sale) as net_sales ,
count(*) as total_orders
from retail_sales group by category;

### *Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

SELECT round(AVG(age),2) as avg_age
from retail_sales 
where category="Beauty";


## Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

select * from retail_sales where total_sale> 1000;


## Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

SELECT category, gender,
count(*) as total_trans 
from retail_sales
group by category, gender;

## Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as ranking
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;


## Write a SQL query to find the top 5 customers based on the highest total sales

select 
customer_id,
sum(total_sale) as total_sales
 from retail_sales
group by 1
order by 2 desc
LIMIT 5;


## Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT * FROM retail_sales;

SELECT 
category,
count(distinct customer_id) as cnt_unique_c
from retail_sales
group by category;


## Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
## CTE- COMMON TABLE EXPRESSION

WITH hourly_sales
as
(
SELECT *,
CASE 
WHEN extract(HOUR FROM sale_time) < 12 then "MORNING"
WHEN extract(HOUR FROM SALE_TIME ) between 12 AND 17 THEN "AFTERNOON"
ELSE "EVENING"
END AS SHIFT
FROM retail_sales
)
select 
shift,
count(transactions_id) as tota_orders
 from hourly_sales
group by shift;




## THE END ##















