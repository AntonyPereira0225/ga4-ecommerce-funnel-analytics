-- Daily funnel and revenue trends
-- Source: Google Analytics 4 obfuscated sample e-commerce dataset
-- Period: 2020-11-01 to 2021-01-31

WITH base AS (
  SELECT
    PARSE_DATE('%Y%m%d', event_date) AS event_date,
    user_pseudo_id,

    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = 'ga_session_id'
    ) AS ga_session_id,

    event_name,
    ecommerce.purchase_revenue_in_usd AS purchase_revenue_usd

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
),

session_events AS (
  SELECT
    MIN(event_date) AS session_date,

    CONCAT(
      user_pseudo_id,
      '-',
      CAST(ga_session_id AS STRING)
    ) AS session_id,

    MAX(IF(event_name = 'session_start', 1, 0)) AS session_started,
    MAX(IF(event_name = 'view_item', 1, 0)) AS viewed_item,
    MAX(IF(event_name = 'add_to_cart', 1, 0)) AS added_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS began_checkout,
    MAX(IF(event_name = 'purchase', 1, 0)) AS purchased,

    SUM(
      IF(
        event_name = 'purchase',
        COALESCE(purchase_revenue_usd, 0),
        0
      )
    ) AS revenue_usd

  FROM base

  WHERE ga_session_id IS NOT NULL

  GROUP BY
    user_pseudo_id,
    ga_session_id
)

SELECT
  session_date,

  COUNTIF(session_started = 1) AS sessions,

  COUNTIF(
    session_started = 1
    AND viewed_item = 1
  ) AS product_view_sessions,

  COUNTIF(
    session_started = 1
    AND added_to_cart = 1
  ) AS add_to_cart_sessions,

  COUNTIF(
    session_started = 1
    AND began_checkout = 1
  ) AS checkout_sessions,

  COUNTIF(
    session_started = 1
    AND purchased = 1
  ) AS purchase_sessions,

  ROUND(
    100 * SAFE_DIVIDE(
      COUNTIF(session_started = 1 AND purchased = 1),
      COUNTIF(session_started = 1)
    ),
    2
  ) AS purchase_conversion_rate_pct,

  ROUND(SUM(revenue_usd), 2) AS revenue_usd

FROM session_events

GROUP BY session_date

ORDER BY session_date;
