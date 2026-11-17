# Analytical Methodology

## Data and quality review
The Kaggle source was imported into MySQL as `ecommerce_customer_insights`. It contains 2,000 customer-associated records. Validation covered row and identifier counts, missing values, exact duplicate rows, duplicate identifiers, blanks, positive unit prices and quantities, and non-negative supplied purchase frequency. The checks returned 2,000 records for the identifier counts and no missing values, exact duplicate rows, duplicate identifiers, blanks, non-positive prices/quantities or negative frequency values.

The supplied `purchase_frequency` cannot be independently recomputed because the dataset has one row per customer rather than a complete purchase-event history.

## Date parsing and chronology
Source dates use month/day/year strings and were parsed with `STR_TO_DATE(date_column, '%c/%e/%Y')`. The comparison of last-purchase date to associated order date found 1,021 plausible rows and 979 chronology-inconsistent rows. Source dates were not silently corrected.

## Recorded order value
`recorded_order_value = unit_price × quantity`. This is a single-record measure, not customer lifetime value, profit or verified revenue. Currency is unspecified.

## RFM population and reference date
RFM analysis uses the 1,021 rows where last purchase date is on or after order date. The fixed reference date is **20 August 2025**, the latest plausible last-purchase date in the dataset.
- Recency: days between 20 August 2025 and last-purchase date.
- Frequency: supplied `purchase_frequency`.
- Monetary: single-record `recorded_order_value`.

## Quintile scoring
Each metric is split into five groups using MySQL `NTILE(5)`. Recency is ordered ascending; frequency and monetary value descending. Scores are reversed so 5 is strongest and 1 lowest. `customer_id` is used as a deterministic tie-breaker. Ties may be split across buckets, so adjacent scores do not necessarily imply a material difference. RFM total ranges from 3 to 15.

## Cohorts and concentration
Customer segments are combined with subscription status to form 13 campaign cohorts. The value concentration index is recorded-value share divided by customer share. It is descriptive, not ROI or profitability.

## Forecasting
Monthly recorded order value was aggregated from all 2,000 source rows into 60 calendar-month observations from September 2020 to August 2025. Tableau was set to an automatic six-month forecast, 95% prediction interval and ignore-last-one-month. Its model basis was September 2020–July 2025; forecast display covers August 2025–January 2026. The one-month August 2025 holdout is too small to establish robust model superiority.

## Interpretation
Separate observed facts from hypotheses. Do not call recorded order value revenue/profit, cohort allocation proven ROI optimisation, or demographic differences causal.
