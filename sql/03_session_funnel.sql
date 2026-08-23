-- GA4 E-commerce Funnel Analytics
-- Session-level funnel using Google Analytics 4 public sample data

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
    CONCAT(
      user_pseudo_id,
      '-',
      CAST(ga_session_id AS STRING)
    ) AS session_id,

    MAX(IF(event_name = 'session_start', 1, 0)) AS session_started,
    MAX(IF(event_name = 'view_item', 1, 0)) AS viewed_item,
    MAX(IF(event_name = 'add_to_cart', 1, 0)) AS added_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS began_checkout,
    MAX(IF(event_name = 'purchase', 1, 0)) AS purchased

  FROM base
  WHERE ga_session_id IS NOT NULL
  GROUP BY session_id
)

SELECT
  1 AS stage_order,
  'Session Start' AS funnel_stage,
  COUNTIF(session_started = 1) AS sessions
FROM session_events

UNION ALL

SELECT
  2,
  'View Item',
  COUNTIF(session_started = 1 AND viewed_item = 1)
FROM session_events

UNION ALL

SELECT
  3,
  'Add to Cart',
  COUNTIF(session_started = 1 AND added_to_cart = 1)
FROM session_events

UNION ALL

SELECT
  4,
  'Begin Checkout',
  COUNTIF(session_started = 1 AND began_checkout = 1)
FROM session_events

UNION ALL

SELECT
  5,
  'Purchase',
  COUNTIF(session_started = 1 AND purchased = 1)
FROM session_events

ORDER BY stage_order;
