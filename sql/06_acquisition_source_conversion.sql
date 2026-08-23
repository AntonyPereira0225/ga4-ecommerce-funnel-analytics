-- GA4 E-Commerce Funnel Analytics
-- Acquisition source / medium performance at session level
-- Note: traffic_source.* represents first-user acquisition attribution,
-- not necessarily the traffic source for every individual session.

WITH base AS (
  SELECT
    user_pseudo_id,
    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = 'ga_session_id'
    ) AS ga_session_id,
    event_name,
    traffic_source.source AS source,
    traffic_source.medium AS medium
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
),

session_events AS (
  SELECT
    user_pseudo_id,
    ga_session_id,
    ANY_VALUE(source) AS source,
    ANY_VALUE(medium) AS medium,
    MAX(IF(event_name = 'session_start', 1, 0)) AS session_started,
    MAX(IF(event_name = 'view_item', 1, 0)) AS viewed_item,
    MAX(IF(event_name = 'add_to_cart', 1, 0)) AS added_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS began_checkout,
    MAX(IF(event_name = 'purchase', 1, 0)) AS purchased
  FROM base
  WHERE ga_session_id IS NOT NULL
  GROUP BY user_pseudo_id, ga_session_id
)

SELECT
  COALESCE(source, '(unknown)') AS first_user_source,
  COALESCE(medium, '(unknown)') AS first_user_medium,
  COUNTIF(session_started = 1) AS sessions,
  COUNTIF(session_started = 1 AND purchased = 1) AS purchase_sessions,
  ROUND(
    100 * SAFE_DIVIDE(
      COUNTIF(session_started = 1 AND purchased = 1),
      COUNTIF(session_started = 1)
    ),
    2
  ) AS purchase_conversion_rate_pct
FROM session_events
GROUP BY first_user_source, first_user_medium
HAVING sessions >= 100
ORDER BY sessions DESC
LIMIT 20;
