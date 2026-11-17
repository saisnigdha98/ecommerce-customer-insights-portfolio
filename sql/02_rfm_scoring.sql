-- MySQL RFM scoring for date-quality-passing customer records.
-- Reference date: 2025-08-20 (fixed source snapshot cutoff).
-- Frequency is supplied purchase_frequency; monetary is one associated record's
-- unit_price * quantity, not lifetime value.

CREATE OR REPLACE VIEW ecommerce_rfm_scored AS
WITH eligible_customers AS (
    SELECT
        customer_id,
        last_purchase_date_clean,
        purchase_frequency,
        recorded_order_value,
        subscription_status,
        cancellations_count,
        country,
        category
    FROM ecommerce_customer_insights_prepared
    WHERE date_quality_flag = 'PLAUSIBLE'
),
recency_scored AS (
    SELECT
        customer_id,
        TO_DAYS('2025-08-20') - TO_DAYS(last_purchase_date_clean) AS recency_days,
        NTILE(5) OVER (
            ORDER BY TO_DAYS('2025-08-20') - TO_DAYS(last_purchase_date_clean), customer_id
        ) AS r_quintile
    FROM eligible_customers
),
frequency_scored AS (
    SELECT
        customer_id,
        purchase_frequency,
        NTILE(5) OVER (ORDER BY purchase_frequency DESC, customer_id) AS f_quintile
    FROM eligible_customers
),
monetary_scored AS (
    SELECT
        customer_id,
        ROUND(recorded_order_value, 2) AS monetary_value,
        NTILE(5) OVER (ORDER BY recorded_order_value DESC, customer_id) AS m_quintile
    FROM eligible_customers
)
SELECT
    e.customer_id,
    r.recency_days,
    f.purchase_frequency,
    m.monetary_value,
    (6-r.r_quintile) AS R_score,
    (6-f.f_quintile) AS F_score,
    (6-m.m_quintile) AS M_score,
    CONCAT((6-r.r_quintile),(6-f.f_quintile),(6-m.m_quintile)) AS RFM_score,
    (6-r.r_quintile)+(6-f.f_quintile)+(6-m.m_quintile) AS RFM_total_score,
    e.subscription_status,
    e.cancellations_count,
    e.country,
    e.category
FROM eligible_customers e
JOIN recency_scored r ON e.customer_id = r.customer_id
JOIN frequency_scored f ON e.customer_id = f.customer_id
JOIN monetary_scored m ON e.customer_id = m.customer_id;

-- Segment customers using explicit business rules.
CREATE OR REPLACE VIEW ecommerce_customer_segments AS
SELECT
    *,
    CASE
        WHEN R_score >= 4 AND F_score >= 4 AND M_score >= 4 THEN 'Champions'
        WHEN R_score >= 3 AND F_score >= 4 AND M_score >= 3 THEN 'Loyal'
        WHEN R_score >= 4 AND F_score >= 2 THEN 'Potential Loyal'
        WHEN R_score <= 2 AND (F_score >= 3 OR M_score >= 4) THEN 'At Risk / Win-back'
        WHEN R_score <= 2 AND F_score <= 2 AND M_score <= 2 THEN 'Hibernating / Low Value'
        ELSE 'Needs Nurturing'
    END AS customer_segment
FROM ecommerce_rfm_scored;

-- Validate scored population and score range.
SELECT COUNT(*) AS records,
       COUNT(DISTINCT customer_id) AS unique_customers,
       MIN(RFM_total_score) AS min_rfm_total,
       MAX(RFM_total_score) AS max_rfm_total
FROM ecommerce_customer_segments;
