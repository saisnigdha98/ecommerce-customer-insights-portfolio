-- Tableau-ready customer-level view.
-- Requires ecommerce_campaign_cohorts and ecommerce_customer_insights_prepared.

CREATE OR REPLACE VIEW ecommerce_tableau_ready AS
SELECT
    c.customer_id,
    c.customer_segment,
    c.campaign_cohort,
    c.subscription_status,
    p.country,
    p.category,
    p.gender,
    p.age,
    c.recency_days,
    c.purchase_frequency,
    c.monetary_value,
    c.R_score,
    c.F_score,
    c.M_score,
    c.RFM_score,
    c.RFM_total_score,
    p.cancellations_count
FROM ecommerce_campaign_cohorts c
LEFT JOIN ecommerce_customer_insights_prepared p
    ON c.customer_id = p.customer_id;

-- Validate row and demographic coverage.
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(age) AS populated_age,
    COUNT(gender) AS populated_gender,
    MIN(age) AS min_age,
    MAX(age) AS max_age
FROM ecommerce_tableau_ready;
