# Analytical Methodology

## Source and validation

The Kaggle source was imported into MySQL as `ecommerce_customer_insights`. The validated source population contains **2,000 records and 2,000 distinct customer IDs**. Checks covered row and identifier counts, missing values, exact duplicate rows, duplicate identifiers, blanks, positive unit prices and quantities, and non-negative supplied purchase frequency. The user's validation queries returned 2,000 records for identifier counts and no missing values, exact duplicate rows, duplicate identifiers, blanks, non-positive prices/quantities or negative frequency values.

The supplied `purchase_frequency` cannot be independently recomputed because the source structure has one associated record per customer rather than a complete purchase-event history.

## Date parsing and chronology

Source dates are month/day/year strings and are parsed with `STR_TO_DATE(date_column, '%c/%e/%Y')`.

The initial rule treated `last_purchase_date < order_date` as inconsistent. This was revised after consulting the source data dictionary, which defines `order_date` as the date when the associated order was placed. A customer's last purchase date can be later than that particular order date; that ordering alone is not evidence of an invalid record.

The final date-quality rule marks a row as plausible when:
1. Signup, associated order and last-purchase dates all parse successfully.
2. Signup date is no later than the associated order date.
3. Signup date is no later than the last-purchase date.
4. Associated order date is no later than the fixed source snapshot cutoff, **20 August 2025**.
5. Last-purchase date is no later than **20 August 2025**.

The final validation returned **2,000 plausible records and zero invalid/inconsistent records**. The 20 August 2025 cutoff is an explicit analysis assumption based on the latest date in the supplied snapshot; it is not a live reporting date.

## Recorded order value

`recorded_order_value = unit_price × quantity`. This is a single-record measure, not customer lifetime value, profit or verified revenue. Currency is unspecified.

## RFM population and reference date

RFM analysis uses all **2,000** date-quality-passing customer records. The fixed reference date is **20 August 2025**.
- Recency: days between 20 August 2025 and last-purchase date.
- Frequency: supplied `purchase_frequency`.
- Monetary: single-record `recorded_order_value`.

## Quintile scoring and segments

Each RFM metric is split into five groups using MySQL `NTILE(5)`. Recency is ordered ascending; frequency and monetary value descending. Scores are reversed so 5 is strongest and 1 lowest. `customer_id` is used as a deterministic tie-breaker. Ties may be split across buckets, so adjacent scores do not necessarily imply a material difference. RFM total ranges from 3 to 15.

Customer segments are assigned using explicit R/F/M score rules. Campaign cohorts combine segment and subscription status. Cohort names describe proposed audience strategies, not measured campaign outcomes.

## Forecasting

Monthly recorded order value is aggregated from all 2,000 source rows into 60 calendar-month observations from September 2020 to August 2025. Tableau was set to an automatic six-month forecast, 95% prediction interval and ignore-last-one-month. Its model basis was September 2020–July 2025; forecast display covers August 2025–January 2026. One holdout month is too small to establish robust model superiority.

## Interpretation

Separate observed facts from hypotheses. Do not call recorded order value revenue/profit, cohort allocation proven ROI optimisation, or demographic differences causal. Actual campaign ROI cannot be calculated without cost, response, incremental outcome and control-group data.
