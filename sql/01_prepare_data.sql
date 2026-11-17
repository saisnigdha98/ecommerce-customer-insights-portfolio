-- MySQL: prepare parsed dates, chronology flag and recorded order value.
-- Source table: ecommerce_customer_insights
-- Currency is unspecified; recorded_order_value is not lifetime value or profit.

CREATE OR REPLACE VIEW ecommerce_customer_insights_prepared AS
SELECT
    *,
    STR_TO_DATE(signup_date, '%c/%e/%Y') AS signup_date_clean,
    STR_TO_DATE(order_date, '%c/%e/%Y') AS order_date_clean,
    STR_TO_DATE(last_purchase_date, '%c/%e/%Y') AS last_purchase_date_clean,
    CASE
        WHEN STR_TO_DATE(order_date, '%c/%e/%Y') IS NULL
          OR STR_TO_DATE(last_purchase_date, '%c/%e/%Y') IS NULL
            THEN 'INVALID_OR_MISSING_DATE'
        WHEN STR_TO_DATE(last_purchase_date, '%c/%e/%Y')
             >= STR_TO_DATE(order_date, '%c/%e/%Y')
            THEN 'PLAUSIBLE'
        ELSE 'INCONSISTENT'
    END AS date_quality_flag,
    (unit_price * quantity) AS recorded_order_value
FROM ecommerce_customer_insights;

-- Review chronology counts.
SELECT date_quality_flag, COUNT(*) AS record_count
FROM ecommerce_customer_insights_prepared
GROUP BY date_quality_flag
ORDER BY date_quality_flag;

-- Review duplicate customer IDs before relying on one-row-per-customer assumptions.
SELECT customer_id, COUNT(*) AS row_count
FROM ecommerce_customer_insights
GROUP BY customer_id
HAVING COUNT(*) > 1;
