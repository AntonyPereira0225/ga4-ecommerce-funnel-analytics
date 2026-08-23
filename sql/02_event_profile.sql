-- GA4 event profile
-- Source: Google Analytics 4 obfuscated sample e-commerce dataset
-- Analysis period: 2020-11-01 to 2021-01-31

SELECT
  event_name,
  COUNT(*) AS event_count,
  COUNT(DISTINCT user_pseudo_id) AS users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY event_name
ORDER BY event_count DESC;
