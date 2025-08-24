# Checkout Funnel – GA4 (BigQuery) + Looker Studio

Analyze the checkout funnel using the **GA4 public sample ecommerce** dataset in **BigQuery** and visualize KPIs in **Looker Studio**.

## Dataset
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

## Views (BigQuery)
- `ga4-lab-469920.ga4_lab.ga4_base_events`
- `ga4-lab-469920.ga4_lab.ga4_session_funnel`
- `ga4-lab-469920.ga4_lab.ga4_daily_revenue`

## Highlights
- End-to-end conversion: _fill with your %_
- Mobile vs Desktop gap: _pp difference_
- Revenue: _$R_ · Orders: _N_ · AOV: _$Z_
- Biggest drop-off: _step_ → experiments proposed

## Reproduce
1. Run the SQL files in `/sql` to create the views.
2. In Looker Studio, connect to `ga4_session_funnel` & `ga4_daily_revenue`.
3. Add fields:
   - `Sessions = 1` (SUM)
   - `CartReached = CASE WHEN t_add_to_cart IS NULL THEN 0 ELSE 1 END` (SUM)
   - `CheckoutReached = CASE WHEN t_begin_checkout IS NULL THEN 0 ELSE 1 END` (SUM)
   - `Purchased = CASE WHEN t_purchase IS NULL THEN 0 ELSE 1 END` (SUM)
   - Optional `MediumFilled = IFNULL(medium, "(none)")` (Text)
4. Build charts (funnel, device/medium bars, revenue, orders, AOV).

## Screens
![Checkout Funnel – Daily Trends](dashboard/page1.png)
![Revenue & AOV Overview](dashboard/page2.png)

## License
MIT
