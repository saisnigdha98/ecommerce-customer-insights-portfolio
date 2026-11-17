# Exploratory Forecasting of Monthly Recorded Order Value

## Objective and scope

The target is **monthly recorded order value**, not verified business revenue. The monthly aggregation uses all 2,000 source records; RFM date eligibility is not applied. The source has one customer-associated record per customer, so monthly totals may reflect changes in record counts rather than underlying business growth.

## Monthly aggregation

The source was aggregated into 60 calendar months from September 2020 to August 2025.
- Total recorded order value: **2,051,690.65**.
- Average monthly record count: **33.33**.
- Average monthly recorded value: **34,194.84**.
- Minimum monthly recorded value: **369.55**.
- Maximum monthly recorded value: **72,956.86** (January 2024).

Annual summary:

| Period | Records | Recorded value | Average per record |
|---|---:|---:|---:|
| 2020 (Sep–Dec) | 8 | 8,903.09 | 1,112.89 |
| 2021 | 136 | 146,137.08 | 1,074.54 |
| 2022 | 304 | 315,063.40 | 1,036.39 |
| 2023 | 545 | 559,328.21 | 1,026.29 |
| 2024 | 638 | 644,013.74 | 1,009.43 |
| 2025 (Jan–Aug) | 369 | 378,245.13 | 1,025.05 |

Monthly totals rise alongside the number of records; average value per record is comparatively stable. This should not automatically be interpreted as business growth.

## Naïve baseline

The naïve forecast uses the previous month's actual value as the next month's forecast: `Forecast(t) = Actual(t - 1)`.

August 2025:
- July actual / naïve forecast: 54,181.
- August actual: 38,855.34.
- Absolute error: 15,325.66.
- Percentage error: approximately 39.44%.

The evaluation dashboard displays rolling one-month-ahead worksheet metrics: **MAE 7,122** and **MAPE 30.27%**.

## Tableau automatic forecast

Settings: six months, Automatic model, 95% prediction interval, Ignore last 1 month. Model basis: September 2020–July 2025. Forecast display: August 2025–January 2026.

Selected model: additive level, additive trend, no seasonality.
- RMSE: 7,991
- MAE: 5,440
- MASE: 0.78
- MAPE: 34.7%
- AIC: 1,070
- Smoothing coefficients: Alpha 0.287, Beta 0.000, Gamma 0.000

August 2025 forecast: approximately 53,349; 95% prediction interval approximately 37,687–69,011. Actual August value (38,855.34) falls within the interval.

August holdout errors:
- Tableau absolute error: approximately 14,493.66; percentage error approximately 37.30%.
- Naïve absolute error: approximately 15,325.66; percentage error approximately 39.44%.

The Tableau absolute error is about 832 lower for this single month. One holdout month is not enough to establish general model superiority.

Tableau point forecasts:

| Month | Forecast |
|---|---:|
| Sep 2025 | 54,257 |
| Oct 2025 | 55,165 |
| Nov 2025 | 56,072 |
| Dec 2025 | 56,980 |
| Jan 2026 | 57,887 |

These are model outputs, not observed future results.

## Forecast evaluation dashboard

The published KPI dashboard displays:

| Metric | Value |
|---|---:|
| Naïve Baseline MAE | 7,122 |
| Naïve Baseline MAPE | 30.27% |
| Tableau Forecast MAE | 5,440 |
| Tableau Forecast MAPE | 34.70% |

**Do not interpret these four cards as a like-for-like comparison.** The rolling naïve calculations and Tableau's Describe Forecast quality metrics use different evaluation procedures/periods. The MAE and MAPE results point in different directions, and the metric values should not be used to claim that one method is uniformly better. A fair comparison requires identical forecast origins, holdout months and metric formulas for both methods.

## Limitations and next steps

A stronger operational forecast requires complete transaction history, a clearly defined currency and target, multiple rolling-origin backtests, common evaluation windows and residual analysis.
