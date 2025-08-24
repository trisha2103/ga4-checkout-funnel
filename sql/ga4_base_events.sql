-- BigQuery view: base events for GA4 funnel
-- Project: ga4-lab-469920 | Dataset: ga4_lab
CREATE OR REPLACE VIEW `ga4-lab-469920.ga4_lab.ga4_base_events` AS
SELECT
  PARSE_DATE('%Y%m%d', e.event_date) AS dt,
  TIMESTAMP_MICROS(e.event_timestamp) AS event_ts,
  e.event_name,
  e.user_pseudo_id,
  (SELECT ep.value.int_value FROM UNNEST(e.event_params) ep WHERE ep.key = 'ga_session_id') AS session_id,
  e.device.category AS device_category,
  e.traffic_source.source  AS traffic_source_source,
  e.traffic_source.medium  AS traffic_source_medium
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
WHERE e.event_name IN ('view_item','add_to_cart','begin_checkout','add_shipping_info','add_payment_info','purchase');
