-- One row per session with timestamps for each step
CREATE OR REPLACE VIEW `ga4-lab-469920.ga4_lab.ga4_session_funnel` AS
WITH s AS (
  SELECT
    dt, user_pseudo_id, session_id, device_category,
    ANY_VALUE(traffic_source_medium) AS medium,
    MIN(IF(event_name='view_item',         event_ts, NULL)) AS t_view_item,
    MIN(IF(event_name='add_to_cart',       event_ts, NULL)) AS t_add_to_cart,
    MIN(IF(event_name='begin_checkout',    event_ts, NULL)) AS t_begin_checkout,
    MIN(IF(event_name='add_shipping_info', event_ts, NULL)) AS t_add_shipping_info,
    MIN(IF(event_name='add_payment_info',  event_ts, NULL)) AS t_add_payment_info,
    MIN(IF(event_name='purchase',          event_ts, NULL)) AS t_purchase
  FROM `ga4-lab-469920.ga4_lab.ga4_base_events`
  GROUP BY dt, user_pseudo_id, session_id, device_category
)
SELECT * FROM s;
