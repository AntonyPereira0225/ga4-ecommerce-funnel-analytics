-- Power BI export dataset at session grain
-- GA4 sample ecommerce: 2020-11-01 to 2021-01-31
-- One row per GA4 session

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
    device.category AS device_category,
    traffic_source.source AS first_user_source,
    traffic_source.medium AS first_user_medium,
    ecommerce.purchase_revenue_in_usd AS purchase_revenue_usd
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
),

session_level AS (
  SELECT
    MIN(event_date) AS session_date,
    CONCAT(
      user_pseudo_id,
      '-',
      CAST(ga_session_id AS STRING)
    ) AS session_id,

    ANY_VALUE(device_category) AS device_category,
    ANY_VALUE(first_user_source) AS first_user_source,
    ANY_VALUE(first_user_medium) AS first_user_medium,

    MAX(IF(event_name = 'first_visit', 1, 0)) AS is_new_session,
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
  session_id,
  COALESCE(device_category, '(unknown)') AS device_category,
  CASE
    WHEN is_new_session = 1 THEN 'New Visitor'
    ELSE 'Returning Visitor'
  END AS visitor_type,
  COALESCE(first_user_source, '(unknown)') AS first_user_source,
  COALESCE(first_user_medium, '(unknown)') AS first_user_medium,
  session_started,
  viewed_item,
  added_to_cart,
  began_checkout,
  purchased,
  ROUND(revenue_usd, 2) AS revenue_usd
FROM session_level
WHERE session_started = 1
ORDER BY session_date, session_id;
