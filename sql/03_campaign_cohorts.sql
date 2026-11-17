-- Build campaign cohorts from RFM segment and subscription status.
-- Cohort names describe proposed audience strategies, not measured campaign outcomes.

CREATE OR REPLACE VIEW ecommerce_campaign_cohorts AS
SELECT
    customer_id,
    customer_segment,
    subscription_status,
    CASE
        WHEN customer_segment = 'Champions' AND subscription_status = 'active'
            THEN 'Champions - Protect'
        WHEN customer_segment = 'Champions'
            THEN 'Champions - Reactivation'
        WHEN customer_segment = 'At Risk / Win-back' AND subscription_status = 'active'
            THEN 'At Risk Active - Re-engagement'
        WHEN customer_segment = 'At Risk / Win-back' AND subscription_status = 'paused'
            THEN 'At Risk Paused - Re-engagement'
        WHEN customer_segment = 'At Risk / Win-back' AND subscription_status = 'cancelled'
            THEN 'At Risk Cancelled - Win-back'
        WHEN customer_segment = 'Loyal' AND subscription_status = 'active'
            THEN 'Loyal Active - Reward'
        WHEN customer_segment = 'Loyal'
            THEN 'Loyal - Reactivation'
        WHEN customer_segment = 'Potential Loyal' AND subscription_status = 'active'
            THEN 'Potential Loyal - Growth'
        WHEN customer_segment = 'Potential Loyal'
            THEN 'Potential Loyal - Reactivation'
        WHEN customer_segment = 'Needs Nurturing' AND subscription_status = 'active'
            THEN 'Needs Nurturing - Engagement'
        WHEN customer_segment = 'Needs Nurturing'
            THEN 'Needs Nurturing - Reactivation'
        WHEN customer_segment = 'Hibernating / Low Value' AND subscription_status = 'active'
            THEN 'Hibernating - Low Cost Engagement'
        ELSE 'Hibernating - Selective Reactivation'
    END AS campaign_cohort,
    recency_days,
    purchase_frequency,
    monetary_value,
    R_score,
    F_score,
    M_score,
    RFM_score,
    RFM_total_score
FROM ecommerce_customer_segments;

-- Cohort summary. Value concentration index is descriptive, not ROI.
WITH cohort_totals AS (
    SELECT campaign_cohort,
           COUNT(*) AS customers,
           SUM(monetary_value) AS cohort_recorded_value
    FROM ecommerce_campaign_cohorts
    GROUP BY campaign_cohort
),
grand_totals AS (
    SELECT SUM(customers) AS all_customers,
           SUM(cohort_recorded_value) AS all_recorded_value
    FROM cohort_totals
)
SELECT
    c.campaign_cohort,
    c.customers,
    ROUND(100 * c.customers / g.all_customers, 2) AS customer_share_pct,
    ROUND(c.cohort_recorded_value, 2) AS recorded_order_value,
    ROUND(100 * c.cohort_recorded_value / g.all_recorded_value, 2) AS value_share_pct,
    ROUND(
        (c.cohort_recorded_value / g.all_recorded_value) /
        (c.customers / g.all_customers), 2
    ) AS value_concentration_index
FROM cohort_totals c
CROSS JOIN grand_totals g
ORDER BY c.customers DESC;
