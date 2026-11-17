# Data Limitations and Responsible Interpretation

## Dataset structure
The source has one customer-associated record per customer, not a complete transaction history. Purchase frequency is supplied and cannot be independently recalculated. Multiple-product co-purchase and market-basket analysis are not supported by this structure.

## Date chronology
There are 1,021 rows where last purchase date is on or after associated order date and 979 rows where last purchase date is earlier. Contradictory rows were not repaired by assumption and were excluded from RFM recency analysis. RFM reference date is 20 August 2025.

## Monetary measure
The derived measure is `unit_price × quantity`. Currency is unspecified; cost, margin, discounts, tax, refunds and returns are not provided. Do not describe it as profit, net sales or verified revenue.

## Campaign ROI
Campaign spend, exposure, response, conversion, incremental outcome and control-group fields are absent. Actual campaign ROI, uplift and causal campaign effectiveness cannot be calculated. The proposed budget allocation is a planning hypothesis for a measured pilot.

## Demographic interpretation
Age and gender comparisons are descriptive, not causal. The Other gender group contains 34 eligible customers, so comparisons for this group are especially uncertain. Demographics should not be used alone to determine campaign eligibility or budget.

## Forecasting
The monthly series counts the single customer-associated records by order month. Increasing monthly totals may reflect the increasing number of records in the dataset rather than growth in a consistently observed business. The source is static, not a live feed. One holdout month is insufficient to establish model superiority.

A stronger forecast requires complete transaction history, a clearly defined target, multiple rolling-origin backtests, common evaluation windows and business context.
