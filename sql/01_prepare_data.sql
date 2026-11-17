-- MySQL: prepare parsed dates, chronology flag and recorded order value.
-- Source table: ecommerce_customer_insights
-- Snapshot cutoff / RFM reference date: 2025-08-20.
-- Currency is unspecified; recorded_order_value is not lifetime value or profit.
-- order_date is the date of the associated order. last_purchase_date may be later.

CREATE OR REPLACE VIEW ecommerce_customer_insights_prepared AS
SELECT
    e.*,
    STR_TO_DATE(e.signup_date, '%c/%e/%Y') AS signup_date_clean,
    STR_TO_DATE(e.order_date, '%c/%e/%Y') AS order_date_clean,
    STR_TO_DATE(e.last_purchase_date, '%c/%e/%Y') AS last_purchase_date_clean,
    CASE
        WHEN STR_TO_DATE(e.signup_date, '%c/%e/%Y') IS NULL
          OR STR_TO_DATE(e.order_date, '%c/%e/%Y') IS NULL
          OR STR_TO_DATE(e.last_purchase_date, '%c/%e/%Y') IS NULL
            THEN 'INVALID_OR_MISSING_DATE'
        WHEN STR_TO_DATE(e.signup_date, '%c/%e/%Y') >
             STR_TO_DATE(e.order_date, '%c/%e/%Y')
            THEN 'INCONSISTENT'
        WHEN STR_TO_DATE(e.signup_date, '%c/%e/%Y') >
             STR_TO_DATE(e.last_purchase_date, '%c/%e/%Y')
            THEN 'INCONSISTENT'
        WHEN STR_TO_DATE(e.order_date, '%c/%e/%Y') > '2025-08-20'
            THEN 'INCONSISTENT'
        WHEN STR_TO_DATE(e.last_purchase_date, '%c/%e/%Y') > '2025-08-20'
            THEN 'INCONSISTENT'
        ELSE 'PLAUSIBLE'
    END AS date_quality_flag,
    (e.unit_price * e.quantity) AS recorded_order_value
FROM ecommerce_customer_insights e;

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
