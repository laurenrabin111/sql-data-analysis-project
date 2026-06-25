/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    Calculate running totals or moving averages for key metrics.
    To track performance over time cumulatively and identify long term trends.
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time

SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date) AS running_total_sales
FROM (
    SELECT
        DATETRUNC(month, order_date) AS order_date,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
)t



