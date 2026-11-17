# Data Limitations and Responsible Interpretation

## Dataset structure

The source has one customer-associated record per customer, not a complete transaction history. Purchase frequency is supplied and cannot be independently recalculated. Multiple-product co-purchase and market-basket analysis are not supported by this structure.

## Date chronology and cutoff

The initial date-quality rule incorrectly treated a last-purchase date later than the associated order date as contradictory. The source data dictionary defines `order_date` as the date when the associated order was placed; it can precede a customer's later last-purchase date.

The revised rule checks that all three dates parse, signup is no later than order and last-purchase dates, and order and last-purchase dates do not exceed the fixed **20 August 2025** source snapshot cutoff. All 2,000 rows passed the revised checks. The cutoff is an explicit assumption for this static dataset.

## Monetary measure

The derived measure is `unit_price × quantity`. Currency is unspecified; cost, margin, discounts, tax, refunds and returns are not provided. Do not describe it as profit, net sales, lifetime value or verified revenue.

## Campaign ROI

Campaign spend, exposure, response, conversion, incremental outcome and control-group fields are absent. Actual campaign ROI, uplift and causal campaign effectiveness cannot be calculated. The campaign cohorts and proposed strategies are hypotheses for a measured pilot.

## Demographic interpretation

Age and gender comparisons are descriptive, not causal. The Other gender group is smaller than the Female and Male groups, so its comparisons are less stable. Demographics should not be used alone to determine campaign eligibility or budget.

## Forecasting

The monthly series aggregates the single customer-associated records by order month. Increasing monthly totals may reflect the changing number of records in the dataset rather than growth in a consistently observed business. The source is static, not a live feed. One holdout month is insufficient to establish model superiority, and the displayed naïve and Tableau KPI calculations are not a like-for-like comparison.

A stronger forecast requires complete transaction history, a clearly defined target, multiple rolling-origin backtests, common evaluation windows and business context.
