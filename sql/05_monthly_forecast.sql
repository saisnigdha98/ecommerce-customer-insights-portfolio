-- Monthly aggregation for exploratory forecasting.
-- Uses all source rows; this is monthly recorded order value, not verified revenue.

CREATE OR REPLACE VIEW ecommerce_monthly_forecast AS
SELECT
    DATE_FORMAT(
        STR_TO_DATE(order_date, '%c/%e/%Y'),
        '%Y-%m-01'
    ) AS order_month,
    COUNT(*) AS order_count,
    ROUND(SUM(unit_price * quantity), 2) AS monthly_recorded_value,
    ROUND(AVG(unit_price * quantity), 2) AS avg_recorded_value
FROM ecommerce_customer_insights
GROUP BY DATE_FORMAT(
    STR_TO_DATE(order_date, '%c/%e/%Y'),
    '%Y-%m-01'
);

-- Review time-series coverage and row count.
SELECT COUNT(*) AS month_count,
       MIN(order_month) AS first_month,
       MAX(order_month) AS last_month
FROM ecommerce_monthly_forecast
;
