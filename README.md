# E-commerce Customer Insights & Churn Analysis

An end-to-end customer and marketing analytics portfolio project using **MySQL, Tableau Public and GitHub**. The project covers data validation, RFM-style customer segmentation, campaign cohort prioritisation, demographic exploration and an exploratory monthly time-series forecast.

> **Important scope note:** The source contains one customer-associated record per customer, not a complete transaction history. `recorded_order_value = unit_price × quantity` is a single-record measure, not lifetime spend, profit or verified revenue. Currency is unspecified. Campaign costs, responses, incremental outcomes and control-group data are unavailable, so actual campaign ROI cannot be calculated.

## Business question

**Which customer groups should a marketing team prioritise for a retention or re-engagement pilot, and how can the team test that prioritisation?**

## Tools

- **MySQL:** validation, date parsing, RFM scoring, campaign cohorts and monthly aggregation.
- **Tableau Public:** segmentation, demographic, trend, forecast and forecast-evaluation dashboards.
- **GitHub:** SQL scripts, methodology, findings, limitations and reproducibility notes.

## Dataset and analysis scope

Source: [E-commerce Customer Insights and Churn Dataset — Kaggle](https://www.kaggle.com/datasets/nabihazahid/e-commerce-customer-insights-and-churn-dataset)

- Source population: **2,000 records and 2,000 distinct customer IDs**.
- Customer segmentation and demographic dashboards: **2,000 customers**.
- Monthly recorded-value series: **60 months**, September 2020–August 2025.
- RFM reference date and source snapshot cutoff: **20 August 2025**.
- Currency is not specified; monetary values are therefore shown without a currency symbol.

Date validation was revised after checking the source data dictionary and chronology. The associated `order_date` is the date an order was placed; a later `last_purchase_date` is not inherently contradictory. The final validation retains records where all three dates parse, signup is no later than the associated order date and last purchase date, and both order and last-purchase dates are no later than 20 August 2025. All 2,000 records passed these checks. See [methodology](documentation/methodology.md).

## Key customer-segmentation findings

| RFM segment | Customers | Share |
|---|---:|---:|
| At Risk / Win-back | 615 | 30.75% |
| Needs Nurturing | 538 | 26.90% |
| Potential Loyal | 435 | 21.75% |
| Loyal | 161 | 8.05% |
| Champions | 133 | 6.65% |
| Hibernating / Low Value | 118 | 5.90% |
| **Total** | **2,000** | **100.00%** |

The largest segment is At Risk / Win-back. This is a behavioural prioritisation hypothesis, not a prediction of response or future value.

## Campaign cohort distribution

| Campaign cohort | Customers |
|---|---:|
| At Risk Active - Preventive Retention | 363 |
| Needs Nurturing - Engagement | 322 |
| Potential Loyal - Growth | 280 |
| Needs Nurturing - Reactivation | 216 |
| At Risk Cancelled - Win-back | 160 |
| Potential Loyal - Reactivation | 155 |
| Loyal Active - Reward | 99 |
| At Risk Paused - Re-engagement | 92 |
| Hibernating - Low Cost Engagement | 71 |
| Champions - Protect | 69 |
| Champions - Reactivation | 64 |
| Loyal - Reactivation | 62 |
| Hibernating - Selective Reactivation | 47 |
| **Total** | **2,000** |

## Marketing recommendations and proposed pilot budget

**Recommendation:** start with a controlled retention and re-engagement pilot rather than spreading the budget evenly across all customers. The largest single behavioural group is At Risk / Win-back (615 customers, 30.75%). Needs Nurturing and Potential Loyal together account for another 973 customers (48.65%), giving the marketing team sizeable audiences to test for engagement and progression.

The following is a **proposed starting allocation of the pilot campaign budget**. These percentages are strategic test assumptions based on segment size and intended treatment—not measured ROI, predicted revenue, or a statistically optimised budget.

| Priority group | Customers | Proposed pilot budget | Recommended action |
|---|---:|---:|---|
| At Risk / Win-back | 615 (30.75%) | **35%** | Separate active preventive-retention messaging (363), paused-customer re-engagement (92), and cancelled-customer win-back (160). Test reminder-only messages against incentives before offering discounts broadly. |
| Needs Nurturing | 538 (26.90%) | **30%** | Use lower-cost personalised content, product discovery, and follow-up messages. Test which touchpoints move customers toward repeat engagement. |
| Potential Loyal | 435 (21.75%) | **20%** | Test relevant product recommendations, bundles, and loyalty milestones to encourage progression without relying on blanket discounts. |
| Champions + Loyal | 294 (14.70%) | **10%** | Focus on retention and recognition, such as early access or modest loyalty benefits. Protect these relationships without assuming expensive rewards are necessary. |
| Hibernating / Low Value | 118 (5.90%) | **5%** | Use automated, low-cost reactivation tests. Avoid high-cost manual outreach or large incentives unless early results justify further spend. |
| **Total** | **2,000 (100%)** | **100%** | |

### How the marketing team should decide what to scale

1. **Create a holdout group within each segment.** Randomly withhold campaign contact for a portion of otherwise eligible customers, so results can be compared with customers who received the campaign.
2. **Measure incremental outcomes, not just clicks.** Track incremental retention/reactivation or conversion against the holdout, cost per incremental retained/reactivated customer, discount cost, and incremental contribution margin after campaign costs.
3. **Compare the three At Risk treatments separately.** Active, paused, and cancelled customers should not be treated as one interchangeable audience; report their results independently.
4. **Reallocate only after evidence.** Increase budget for a segment only when the campaign produces positive incremental contribution after costs. Reduce or stop spend where results do not justify the expense.

**What this analysis can and cannot conclude:** At Risk / Win-back is the largest single segment, while Needs Nurturing and Potential Loyal together represent nearly half the customer population. These findings support prioritising those groups for testing. They do **not** establish which group will deliver the highest ROI. The dataset does not include campaign spend, campaign response, control-group outcomes, or contribution margin, and its recorded order value is not verified lifetime revenue or profit. The proposed budget split should therefore be treated as a pilot hypothesis and revised using measured results.

## Demographic snapshot

The updated Tableau demographic dashboard covers 2,000 customers:
- Age counts: 18–24 **258**; 25–34 **345**; 35–44 **374**; 45–54 **434**; 55+ **589**.
- Gender distribution: Female **50.75%**; Male **45.85%**; Other **3.40%**.
- Average recorded order value by gender: Male **1,040.53**; Female **1,017.17**; Other **957.31**.

These are descriptive differences, not evidence that demographics cause purchasing behaviour or campaign response. The Other group is comparatively small.

## Monthly recorded-value forecasting

All 2,000 source records were aggregated into 60 calendar-month observations from September 2020 to August 2025.

- Total recorded order value: **2,051,690.65**.
- Tableau automatic forecast: six months, August 2025–January 2026, with a 95% prediction interval.
- Forecast model selected by Tableau: additive level and additive trend, no seasonal component.
- Evaluation dashboard KPIs: naïve baseline MAE **7,122** and MAPE **30.27%**; Tableau forecast MAE **5,440** and MAPE **34.70%**.

**Interpretation caution:** the MAE and MAPE cards are not a like-for-like model comparison because the underlying evaluation procedures differ. Tableau's lower displayed MAE does not establish overall superiority, especially with only one August 2025 holdout observation described in the forecast analysis. See [forecasting notes](analysis/sales-forecasting.md).

## Tableau Public dashboards

1. [Customer Segmentation & Campaign Prioritisation](https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/CustomerSegmentation-Overview#1)
2. [Customer Demographic Insights](https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/CustomerDemographicInsights_#1)
3. [Tableau Sales Forecast](https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/TableauSalesForecast_)
4. [Forecast Model Evaluation](https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/ForecastModelEvaluationDashboard)

## Dashboard previews

Select a preview to open its interactive Tableau Public dashboard. The screenshots are included here so the project can be reviewed directly from the repository.

<table>
  <tr>
    <td align="center">
      <a href="https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/CustomerSegmentation-Overview#1">
        <img src="dashboards/images/customer-segmentation.png" width="420" alt="Customer Segmentation and Campaign Prioritisation dashboard" />
      </a>
      <br /><strong>Customer Segmentation & Campaign Prioritisation</strong>
    </td>
    <td align="center">
      <a href="https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/CustomerDemographicInsights_#1">
        <img src="dashboards/images/customer-demographics.png" width="420" alt="Customer Demographic Insights dashboard" />
      </a>
      <br /><strong>Customer Demographic Insights</strong>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="dashboards/images/monthly-value-trend.png" width="420" alt="Monthly Recorded Value Trend dashboard screenshot" />
      <br /><strong>Monthly Recorded Value Trend</strong>
    </td>
    <td align="center">
      <a href="https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/TableauSalesForecast_">
        <img src="dashboards/images/sales-forecast.png" width="420" alt="Tableau Sales Forecast dashboard" />
      </a>
      <br /><strong>Tableau Sales Forecast</strong>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://public.tableau.com/app/profile/snigdha.nandury/viz/Book1_17947202352600/ForecastModelEvaluationDashboard">
        <img src="dashboards/images/forecast-model-evaluation.png" width="420" alt="Forecast Model Evaluation dashboard" />
      </a>
      <br /><strong>Forecast Model Evaluation</strong>
    </td>
    <td></td>
  </tr>
</table>

## Repository guide

| Folder | Contents |
|---|---|
| `sql/` | MySQL preparation, RFM, campaign cohort, Tableau-ready and monthly forecast scripts |
| `analysis/` | Segmentation, demographic and forecasting findings |
| `documentation/` | Methodology, data dictionary and limitations |
| `dashboards/` | Published Tableau Public dashboard links and screenshot previews |

## Reproducibility

1. Download the source dataset from Kaggle.
2. Import it into MySQL as `ecommerce_customer_insights`.
3. Run the SQL scripts in numerical order.
4. Connect Tableau to the resulting views or exported CSVs.
5. Review the methodology and limitations before interpreting results.

The SQL scripts are intended as reproducible project documentation; validate them against your local MySQL schema and source-file column names before running.

---
Portfolio project. Findings are descriptive; campaign recommendations are hypotheses for testing.
