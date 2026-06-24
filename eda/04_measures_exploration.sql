/*
======================================================================================================
Measures exploration
======================================================================================================
Purpose: 
	Calculate aggregated metrics (Big Numbers) for business to gain
	quick insights and to identify overall trends/spot anomalies
======================================================================================================
*/

-- Find the total sales
SELECT SUM(sales_amount) AS total_sales 
FROM gold.fact_sales 

-- Find how many items are sold
SELECT 
	SUM(quantity) AS total_quantity 
FROM gold.fact_sales 

-- Find the average selling price
SELECT AVG(cost) AS avg_cost
FROM gold.dim_products 
-- Find the total number of orders
-- Find the total number of products
-- FInd the total number of customers
-- Find the total number of customers that has placed an order 
