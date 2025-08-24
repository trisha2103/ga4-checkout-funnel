-- Daily orders & revenue from purchase events
CREATE OR REPLACE VIEW `ga4-lab-469920.ga4_lab.ga4_daily_revenue` AS
WITH purchases AS (
  SELECT
    PARSE_DATE('%Y%m%d', e.event_date) AS dt,
    (SELECT ep.value.string_value FROM UNNEST(e.event_params) ep WHERE ep.key='transaction_id') AS txn_id,
    SUM(i.price * i.quantity) AS revenue
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e,
       UNNEST(e.items) AS i
  WHERE e.event_name='purchase'
  GROUP BY dt, txn_id
)
SELECT dt, COUNT(*) AS orders, SUM(revenue) AS revenue
FROM purchases
GROUP BY dt;
