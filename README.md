# Retail Sale Analysis SQL Project 

## Project Overview

### Project Title: Retail Sales Analysis

## Level: Beginner

## Database: sql_sale/postgres@sales

This project is designed to de monstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL

## Objectives

1. Set up a retail sales database: Create and populate a retail sales database with the provided sales data.

2. Data Cleaning: Identify and remove any records with missing or null values.

3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.

4. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

5. Project Structure

## 1. Database Setup

## Database Creation: The project starts by creating a database named sql_sale/postgres@sales.

Table Creation: A table named retail_sale is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_sale;

CREATE TABLE retail sale

(
transactions id INT PRIMARY KEY,

sale date DATE,

sale tine TIME,

customer_id INT,

gender VARCHAR(10),

age INT,

category VARCHAR(35),

quantity INT

price_per_unit FLOAT,

cogs FLOAT

total sale FLOAT):
```
## 2. Data Exploration & Cleaning
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
```

SELECT COUNT(*) AS TOTAL_RECORDS FROM RETAIL_SALE;

SELECT
  count(DISTINCT customer_id) as total_customer
from retail_sale;
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
```

### 3. Data Analysis & Findings

 The Following  SQL queries were developed to answer specific business questions:
1. **retrieve sales made on a specific date**
 ``` 
select * from retail_sale WHERE sale_date = '2022-11-25' ;
 ```
 2. **retrieve all transcations where the category is Clothing and the quantity sold sold is more than 10 in the month of Nov-2022**
```
select *from retail_sale
where category = 'Clothing'	
	and to_char(sale_date,'YYYY-MM')= '2022-11'
 	and quantiy >=4;
```
3. **Write a SQL query to calculate total sale for  each category**
 ```
select
 category ,
 sum(quantiy * price_per_unit ) as total_sale
from retail_sale
group by category ;
```
4. **Write a SQL query to find the average of customer who purchase item from 'Beauty ' category**
 ```
select
  round( avg(age ),1) as avg_age,
  category 
from retail_sale 
group by category ;
```
5. **Write a SQL query to find the all transactions where total sale is more then 1000**
```
select * from
retail_sale 
where total_sale >1000;
```
6.**Write a SQL query to find the total number transactions {transcations_id } made by each gender in each category**
```
select
  count(transactions_id) as total_transactions_id ,
	gender ,
  category
from retail_sale
group by gender , category;
```
7.**write a SQL query to calculate the average sale for each month.Find out best month in each year**
```
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
```
** write a SQL query to find the top 5 customer based on the highest total sales**
```
select customer_id , 
   sum(total_sale)as  total_
 from retail_sale
	group by customer_id , total_sale
	order by 2 desc limit 5;
```
**find the number of unqiue customers who purchased item from each category**
```
select category,
	count(distinct customer_id) as unqiue_customers
	from retail_sale
  group by category 
  order by 2;
```
**write a SQL query to create each shift and number of order {Example morning  <=12, Afternoon between  12 & 17  Evening >`17`}**
```
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
```















