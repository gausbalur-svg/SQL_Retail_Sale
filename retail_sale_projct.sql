-- create the table 
CREATE TABLE 
	retail_sale(transactions_id	INT,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(20),
age	INT,
category	VARCHAR(20),
quantiy	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale	FLOAT
);

select * from retail_sale;

-- count
select count(*) from retail_sale;
-- the date cleaning 
-- check the NULL values 
select * from retail_sale
where
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null 
	or
	category  is null
	or 
	quantiy is null 
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;

-- 	DELETE THE NULL VALUE
DELETE  from retail_sale
where
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null 
	or
	category  is null
	or 
	quantiy is null 
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;

--  DATA Exploration -
--HOW many sale records we  have 
SELECT COUNT(*) AS TOTAL_RECORDS FROM RETAIL_SALE;

--How many customer we have ?
select
	count(DISTINCT customer_id) as total_customer
	from retail_sale;

--category 
select
	DISTINCT category as category
	from retail_sale;

-- Date Analysis & Business & Answers
-- Q1 retrieve all the colunms for sale made on 2022-11-25
select * from retail_sale
where sale_date = '2022-11-25' ;

--Q2 retrieve all transcations where the category is Clothing and the quantity sold sold 
-- is more than 10 in the month of Nov-2022
select *from retail_sale
where category = 'Clothing'	
	and to_char(sale_date,'YYYY-MM')= '2022-11'
 	and quantiy >=4;

--Q3 calculate total sale for  each category
select category ,sum(quantiy * price_per_unit ) as total_sale
	from retail_sale
group by category ;

-- Q4 find the average of customer who purchase item from 'Beauty ' category 
select round( avg(age ),1) as avg_age,
  category 
  from retail_sale 
group by category ;  

-- Q5 find the all transactions where total sale is more then 1000
select * from
retail_sale 
where total_sale >1000;

--Q6 find the total number transactions {transcations_id } made by each gender in each category
select count(transactions_id) as total_transactions_id ,
	gender ,
	category
	from retail_sale
	group by
	gender , category;
--Q7 write a SQL query to calculate the average sale for each month .
--Find out best month in each year
select * from 
(
select
	extract (year from sale_date) as year,
	extract (month from sale_date)as month,
	avg(total_sale) as avg_sales,
	rank() over(partition by extract (year from sale_date)
		order by avg(total_sale) desc ) as rank
from retail_sale
group by 1,2
) as T1;

--Q8 write a SQL query to find the top 5 customer based on the highest total sales
 select customer_id , 
 sum(total_sale)as  total_
	 from retail_sale
	group by customer_id , total_sale
	order by 2 desc limit 5;


-- Q9 find the number of unqiue customers who purchased item from each category 
select category,
	count(distinct customer_id) as unqiue_customers
	from retail_sale
group by category 
order by 2;

-- write a SQL query to create each shift and number of order {Example morning  <=12, Afternoon between 
-- 12 & 17  Evening >`17`}
with hourly_sale
 AS(
select * ,
	case 
		WHEN  extract(hour from sale_time )< 12 THEN 'Morning'
		WHEN extract (hour from sale_time ) BETWEEN 12 AND 17  THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sale
) 
select shift,
	count(*) as total_order
	from hourly_sale
group by shift;
