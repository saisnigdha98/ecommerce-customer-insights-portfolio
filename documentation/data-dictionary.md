# Data Dictionary

Source: [E-commerce Customer Insights and Churn Dataset — Kaggle](https://www.kaggle.com/datasets/nabihazahid/e-commerce-customer-insights-and-churn-dataset)

Imported MySQL table: `ecommerce_customer_insights`.

| Field | Description |
|---|---|
| `order_id` | Source order identifier |
| `customer_id` | Customer identifier |
| `age` | Customer age |
| `product_id` | Associated product identifier |
| `country` | Customer country |
| `signup_date` | Signup date string |
| `last_purchase_date` | Last-purchase date string |
| `cancellations_count` | Source cancellation count |
| `subscription_status` | Active, cancelled or paused |
| `order_date` | Associated order date string |
| `unit_price` | Unit price; currency unspecified |
| `quantity` | Quantity associated with the record |
| `purchase_frequency` | Precomputed source field; cannot be independently validated from one row per customer |
| `preferred_category` | Source preferred category |
| `product_name` | Product name |
| `category` | Product category |
| `gender` | Gender category as supplied |

## Derived fields
- `signup_date_clean`, `order_date_clean`, `last_purchase_date_clean`: parsed dates using `STR_TO_DATE(..., '%c/%e/%Y')`.
- `date_quality_flag`: chronology quality classification.
- `recorded_order_value`: `unit_price × quantity`; single-record value, not lifetime value or profit.
- `recency_days`: days from fixed RFM reference date 2025-08-20 to last purchase date.
- `R_score`, `F_score`, `M_score`: quintile scores 1–5.
- `RFM_score`: concatenated R/F/M scores.
- `RFM_total_score`: sum of R/F/M scores (3–15).
- `customer_segment`: rule-based RFM segment.
- `campaign_cohort`: segment and subscription-status-based grouping.

RFM, cohort and demographic population: 1,021 chronology-eligible customers. Monthly descriptive series: all 2,000 records.
