# Customer Segmentation and Campaign Cohort Analysis

## Population and method
RFM analysis uses 1,021 of the 2,000 source records because 979 have contradictory order/last-purchase chronology. Reference date: **20 August 2025**. Recency is days since last purchase; frequency is the supplied `purchase_frequency`; monetary is the single-record `unit_price × quantity`. Quintile scores range from 1 (lowest) to 5 (highest).

## RFM segment profile

| Segment | Customers | Avg. recency (days) | Avg. frequency | Avg. recorded value |
|---|---:|---:|---:|---:|
| At Risk / Win-back | 307 | 744.11 | 28.88 | 1,137.30 |
| Needs Nurturing | 278 | 334.93 | 15.19 | 982.45 |
| Potential Loyal | 215 | 127.26 | 25.21 | 883.96 |
| Loyal | 80 | 249.14 | 38.03 | 1,257.72 |
| Champions | 74 | 145.93 | 40.26 | 1,613.85 |
| Hibernating / Low Value | 67 | 727.58 | 9.43 | 476.85 |

Champions have the highest average frequency and recorded value. At Risk / Win-back is the largest segment, with high average recorded value but also high average recency. These profiles support hypotheses for testing, not guaranteed future value.

## Campaign cohort summary

| Cohort | Customers | Customer share | Recorded value | Value share | Concentration index |
|---|---:|---:|---:|---:|---:|
| At Risk Active - Re-engagement | 189 | 18.51% | 220,957.25 | 20.76% | 1.12 |
| Needs Nurturing - Engagement | 177 | 17.34% | 174,379.63 | 16.38% | 0.95 |
| Potential Loyal - Growth | 136 | 13.32% | 118,019.93 | 11.09% | 0.83 |
| Needs Nurturing - Reactivation | 101 | 9.89% | 98,741.44 | 9.28% | 0.94 |
| At Risk Cancelled - Win-back | 64 | 6.27% | 74,822.43 | 7.03% | 1.12 |
| Potential Loyal - Reactivation | 79 | 7.74% | 72,031.85 | 6.77% | 0.87 |
| Champions - Protect | 39 | 3.82% | 62,776.71 | 5.90% | 1.54 |
| Loyal Active - Reward | 51 | 5.00% | 62,166.49 | 5.84% | 1.17 |
| Champions - Reactivation | 35 | 3.43% | 56,647.95 | 5.32% | 1.55 |
| At Risk Paused - Re-engagement | 54 | 5.29% | 53,372.54 | 5.01% | 0.95 |
| Loyal - Reactivation | 29 | 2.84% | 38,451.30 | 3.61% | 1.27 |
| Hibernating - Selective Reactivation | 33 | 3.23% | 16,221.97 | 1.52% | 0.47 |
| Hibernating - Low Cost Engagement | 34 | 3.33% | 15,726.80 | 1.48% | 0.44 |

Totals: 1,021 customers and 1,064,316.29 recorded order value. Concentration index = recorded-value share ÷ customer share; it is not ROI or profit.

## Proposed pilot budget hypothesis

| Cohort | Proposed pilot share |
|---|---:|
| At Risk Active - Re-engagement | 20% |
| Needs Nurturing - Engagement | 15% |
| Champions - Protect | 8% |
| Champions - Reactivation | 7% |
| Potential Loyal - Growth | 10% |
| Needs Nurturing - Reactivation | 8% |
| At Risk Cancelled - Win-back | 8% |
| Potential Loyal - Reactivation | 6% |
| Loyal Active - Reward | 6% |
| At Risk Paused - Re-engagement | 5% |
| Loyal - Reactivation | 4% |
| Hibernating - Selective Reactivation | 1.5% |
| Hibernating - Low Cost Engagement | 1.5% |
| **Total** | **100%** |

This is a starting hypothesis, not a validated ROI allocation. Test with a holdout group and track campaign cost, incremental outcomes, margin and retention before scaling. The “At Risk Active” cohort is labelled re-engagement because its average recency is 742.75 days; active subscription does not mean recent purchase.
