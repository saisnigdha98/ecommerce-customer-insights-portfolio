# E-commerce Customer Insights & Churn Analysis

An end-to-end customer analytics portfolio project using **MySQL** and **Tableau Public**, covering data quality, RFM-style customer segmentation, campaign cohort prioritisation, demographic exploration and an exploratory time-series forecasting exercise.

> **Scope note:** The Kaggle dataset contains one customer-associated order record per customer, not a complete transaction history. The calculated measure is *recorded order value*, not lifetime revenue, profit or verified sales. Campaign costs, campaign responses, gross margin and control-group data are unavailable, so actual campaign ROI cannot be calculated.

## Business question

**Which customer groups may offer the strongest opportunity for a retention campaign, and how could a marketing team prioritise a pilot budget for testing?**

## Tools

- MySQL — data checks, date parsing, derived fields, RFM scoring, campaign cohorts and monthly aggregation.
- Tableau Public — customer segmentation, demographic dashboards, monthly trend and exploratory forecast.
- GitHub — versioned SQL, methodology, findings and limitations.

## Dataset

Source: [E-commerce Customer Insights and Churn Dataset — Kaggle](https://www.kaggle.com/datasets/nabihazahid/e-commerce-customer-insights-and-churn-dataset)

The imported source contains 2,000 customer-associated records. RFM analysis is restricted to **1,021 records** whose parsed last-purchase date is on or after the associated order date. The other **979 records** have contradictory date chronology and are excluded from recency-based segmentation; they remain available for carefully labelled non-recency descriptive analysis.

Currency is not specified in the dataset, so monetary values are shown without a currency symbol.

## Repository guide

| Location | Contents |
|---|---|
| `sql/` | MySQL validation, preparation, RFM, cohort and forecasting scripts |
| `analysis/` | Findings and interpretation for segmentation, demographics and forecasting |
| `documentation/` | Data dictionary, methodology and limitations |
| `dashboards/` | Tableau Public dashboard links (to be added when URLs are confirmed) |

## Key findings

### RFM segments

| Segment | Customers | Avg. recency (days) | Avg. frequency | Avg. recorded value |
|---|---:|---:|---:|---:|
| At Risk / Win-back | 307 | 744.11 | 28.88 | 1,137.30 |
| Needs Nurturing | 278 | 334.93 | 15.19 | 982.45 |
| Potential Loyal | 215 | 127.26 | 25.21 | 883.96 |
| Loyal | 80 | 249.14 | 38.03 | 1,257.72 |
| Champions | 74 | 145.93 | 40.26 | 1,613.85 |
| Hibernating / Low Value | 67 | 727.58 | 9.43 | 476.85 |

The figures describe the 1,021 chronology-eligible customers and are not predictions of future value.

### Campaign cohorts

The 1,021 customers were divided into 13 campaign cohorts. The largest is **At Risk Active - Re-engagement** (189 customers; 18.51%). Its average recency is 742.75 days, so an “active subscription” should not be confused with recent purchasing.

A proposed pilot allocation is documented in [analysis/customer-segmentation.md](analysis/customer-segmentation.md). It is a testable planning hypothesis, not measured ROI.

### Demographics

- Female: 521 customers (51.03%).
- Male: 466 customers (45.64%).
- Other: 34 customers (3.33%).

Male customers have the highest average recorded order value (1,067.20); female customers have the largest total recorded value (534,616.06), partly reflecting their larger group size. These descriptive differences do not establish causation.

### Forecasting

The 2,000 source records were aggregated into 60 calendar-month observations from September 2020 to August 2025. Tableau's automatic model selected additive level and trend with no seasonal component and produced a six-month exploratory forecast. This is a forecast of the dataset's monthly recorded-value series, not a validated operational revenue forecast.

## Tableau dashboards

- Customer Segmentation & Campaign Prioritisation — **link pending**
- Customer Demographic Insights — **link pending**
- Forecast Model Evaluation — **link pending**

Published Tableau Public URLs will be added after they are confirmed.

## Reproducibility

1. Download the source dataset from Kaggle.
2. Import it into MySQL as `ecommerce_customer_insights`.
3. Run the SQL scripts in numerical order.
4. Connect Tableau to the resulting views or exported CSVs.
5. Review the methodology and limitations before interpreting the results.

See [documentation/methodology.md](documentation/methodology.md), [documentation/data-dictionary.md](documentation/data-dictionary.md), [documentation/limitations.md](documentation/limitations.md), and the analysis notes.

## Limitations at a glance

- One associated order record per customer; no complete transaction history.
- Supplied `purchase_frequency` cannot be independently recomputed from the available row structure.
- 979 rows have contradictory date chronology and are excluded from RFM recency analysis.
- Recorded order value is `unit_price × quantity`; currency, margin, returns and verified revenue are unavailable.
- No campaign cost, response, uplift or control-group data; actual campaign ROI is not measurable.
- Forecasting is exploratory and based on a static dataset with one associated record per customer.

---
Portfolio project documentation. Findings are descriptive unless explicitly stated otherwise.
