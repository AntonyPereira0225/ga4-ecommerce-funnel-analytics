-- GA4 E-commerce Funnel Analytics
-- New vs returning visitor session conversion
-- Dataset: bigquery-public-data.ga4_obfuscated_sample_ecommerce
-- Analysis period: 2020-11-01 to 2021-01-31

WITH base AS (
  SELECT
    user_pseudo_id,
    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = 'ga_session_id'
    ) AS ga_session_id,
    event_name
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
),

session_events AS (
  SELECT
    user_pseudo_id,
    ga_session_id,
    MAX(IF(event_name = 'session_start', 1, 0)) AS session_started,
    MAX(IF(event_name = 'first_visit', 1, 0)) AS is_new_session,
    MAX(IF(event_name = 'view_item', 1, 0)) AS viewed_item,
    MAX(IF(event_name = 'add_to_cart', 1, 0)) AS added_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS began_checkout,
    MAX(IF(event_name = 'purchase', 1, 0)) AS purchased
  FROM base
  WHERE ga_session_id IS NOT NULL
  GROUP BY user_pseudo_id, ga_session_id
)

SELECT
  CASE
    WHEN is_new_session = 1 THEN 'New Visitor'
    ELSE 'Returning Visitor'
  END AS visitor_type,
  COUNTIF(session_started = 1) AS sessions,
  COUNTIF(session_started = 1 AND viewed_item = 1) AS product_view_sessions,
  COUNTIF(session_started = 1 AND added_to_cart = 1) AS add_to_cart_sessions,
  COUNTIF(session_started = 1 AND began_checkout = 1) AS checkout_sessions,
  COUNTIF(session_started = 1 AND purchased = 1) AS purchase_sessions,
  ROUND(
    100 * SAFE_DIVIDE(
      COUNTIF(session_started = 1 AND purchased = 1),
      COUNTIF(session_started = 1)
    ),
    2
  ) AS purchase_conversion_rate_pct
FROM session_events
GROUP BY visitor_type
ORDER BY sessions DESC;
