# Customer Segmentation and Campaign Cohort Analysis

## Population and method

The updated RFM and campaign analysis includes **2,000 customers** (2,000 records and 2,000 distinct customer IDs). The fixed RFM reference date is **20 August 2025**. Recency is days since last purchase; frequency uses the supplied `purchase_frequency`; monetary value is the associated record's `unit_price × quantity`. Each metric is scored using five NTILE buckets; scores range from 1 to 5.

The source has one customer-associated record per customer. Therefore, frequency is a supplied field and monetary value is a single-record measure, not a recomputed transaction count or lifetime spend.

## RFM segment distribution

| Segment | Customers | Customer share |
|---|---:|---:|
| At Risk / Win-back | 615 | 30.75% |
| Needs Nurturing | 538 | 26.90% |
| Potential Loyal | 435 | 21.75% |
| Loyal | 161 | 8.05% |
| Champions | 133 | 6.65% |
| Hibernating / Low Value | 118 | 5.90% |
| **Total** | **2,000** | **100.00%** |

At Risk / Win-back is the largest group, followed by Needs Nurturing and Potential Loyal. These segments identify audiences for differentiated testing; they do not guarantee future value or response.

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

## Suggested campaign testing approach

- **At Risk Active - Preventive Retention:** test low-friction retention messaging and monitor subsequent activity.
- **Needs Nurturing - Engagement:** test educational or category-relevant content.
- **Potential Loyal - Growth:** test relevant cross-sell or upgrade messaging.
- **Cancelled and paused cohorts:** test separate win-back and reactivation journeys.
- **Champions and Loyal cohorts:** test recognition or loyalty benefits while monitoring incremental impact.
- **Hibernating cohorts:** begin with low-cost, selective contact and suppress where engagement is uneconomic.

These are strategic hypotheses based on segment labels, not established causal effects. Use randomised holdouts where feasible. Track delivered contacts, campaign cost, response, conversion, incremental retention, margin and unsubscribe/complaint rates before scaling or allocating budget.

## Important interpretation notes

- Subscription status is not the same as recent purchase activity.
- `recorded_order_value` is one associated record's `unit_price × quantity`; it is not lifetime value, profit or verified revenue.
- The dataset does not contain campaign cost, response, uplift or control-group fields. Actual campaign ROI cannot be calculated.
- The RFM scores are relative quintiles within this dataset; bucket boundaries and ties affect score assignment.
