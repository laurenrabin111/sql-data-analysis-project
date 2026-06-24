/*
===================================================
Date Exploration
===================================================
Purpose: 
	Identify the boundaries of the dates. 
	Understand the scope of the data and timespan.
===================================================
*/

-- Find the date of the first and last order 
-- How many years of sales are avalable
SELECT 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(year, MIN(order_date), MAX(order_date)) order_range_years
FROM gold.fact_sales

-- Find the age and birthday of the youngest and oldest customer
SELECT 
	MIN(birthdate) AS oldest_birthdate,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS  youngest_birthdate,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers
