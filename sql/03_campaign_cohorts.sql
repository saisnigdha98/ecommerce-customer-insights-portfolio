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
            THEN 'At Risk Active - Preventive Retention'
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

-- Cohort count validation.
SELECT campaign_cohort, COUNT(*) AS customers
FROM ecommerce_campaign_cohorts
GROUP BY campaign_cohort
ORDER BY customers DESC;

-- Validate full population.
SELECT COUNT(*) AS records,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM ecommerce_campaign_cohorts;
