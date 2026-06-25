 /*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    Examines how individual categories contribute to the overall total,
    helping identify which segments drive the most value.
===============================================================================
*/ 

-- Which categories contribute the most to overall sales

WITH sales_by_category AS( -- CTE
SELECT
    p.category,
    SUM(f.sales_amount) as total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
)

SELECT 
    category,
    total_sales,
    SUM(total_sales) OVER() AS overall_sales,
    CONCAT(ROUND((CAST (total_sales AS FLOAT)) / (SUM(total_sales) OVER())* 100, 2), '%') AS percentage_of_total
FROM sales_by_category
ORDER BY percentage_of_total DESC