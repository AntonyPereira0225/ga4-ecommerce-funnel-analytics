-- GA4 E-commerce Funnel Analytics
-- Product performance: views, carts, purchases, units and recorded item sales value

WITH item_events AS (
  SELECT
    CONCAT(
      user_pseudo_id,
      '-',
      CAST(
        (
          SELECT value.int_value
          FROM UNNEST(event_params)
          WHERE key = 'ga_session_id'
        ) AS STRING
      )
    ) AS session_id,
    event_name,
    item.item_name,
    item.quantity,
    item.price
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  CROSS JOIN UNNEST(items) AS item
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name IN ('view_item', 'add_to_cart', 'purchase')
)

SELECT
  item_name,
  COUNT(DISTINCT IF(event_name = 'view_item', session_id, NULL)) AS product_view_sessions,
  COUNT(DISTINCT IF(event_name = 'add_to_cart', session_id, NULL)) AS add_to_cart_sessions,
  COUNT(DISTINCT IF(event_name = 'purchase', session_id, NULL)) AS purchase_sessions,
  SUM(IF(event_name = 'purchase', COALESCE(quantity, 1), 0)) AS units_purchased,
  ROUND(
    SUM(
      IF(
        event_name = 'purchase',
        COALESCE(price, 0) * COALESCE(quantity, 1),
        0
      )
    ),
    2
  ) AS product_sales_value,
  ROUND(
    100 * SAFE_DIVIDE(
      COUNT(DISTINCT IF(event_name = 'add_to_cart', session_id, NULL)),
      COUNT(DISTINCT IF(event_name = 'view_item', session_id, NULL))
    ),
    2
  ) AS view_to_cart_rate_pct,
  ROUND(
    100 * SAFE_DIVIDE(
      COUNT(DISTINCT IF(event_name = 'purchase', session_id, NULL)),
      COUNT(DISTINCT IF(event_name = 'view_item', session_id, NULL))
    ),
    2
  ) AS view_to_purchase_rate_pct
FROM item_events
WHERE item_name IS NOT NULL
GROUP BY item_name
HAVING product_view_sessions >= 100
ORDER BY purchase_sessions DESC
LIMIT 20;
