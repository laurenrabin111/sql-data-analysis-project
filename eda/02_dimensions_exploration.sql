/*
===================================================
Dimensions Exploration
===================================================
Purpose: 
	Explore the structure of dimension tables
===================================================
*/

-- Explore all countries our customers come from

SELECT DISTINCT country
FROM gold.dim_customers;

-- Retrieve a list of unique categories, subcategories, and products

SELECT DISTINCT 
	category,
	subcategory,
	product_name
FROM gold.dim_products
ORDER BY 1,2,3;