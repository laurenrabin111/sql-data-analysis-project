/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    Measures and benchmarks performance across products, customers, and regions
    over time to identify top performers and track yearly growth trends.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS( -- CTE
    SELECT 
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY p.product_name, YEAR(f.order_date)
    )
  
SELECT
    order_year,
    product_name,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name)AS avg_sales,
    current_sales - (AVG(current_sales) OVER (PARTITION BY product_name)) AS diff_avg_sales,
    CASE 
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END avg_change, -- flag
    LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS previous_year_sales,
    current_sales - (LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year)) AS diff_py_sales,
    CASE 
        WHEN current_sales - (LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year))  > 0 THEN 'Increase'
        WHEN current_sales - (LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year))  < 0 THEN 'Decrease'
        ELSE 'No Change'
    END py_change -- flag
FROM yearly_product_sales
