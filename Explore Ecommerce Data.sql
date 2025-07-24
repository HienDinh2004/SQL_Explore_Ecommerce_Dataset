-- Query 01
SELECT
 FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d',date)) AS month,
 SUM(totals.visits) AS visits,
 SUM(totals.pageviews) AS pageviews,
 SUM(totals.transactions) AS day_transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`
WHERE _TABLE_SUFFIX BETWEEN '0101' AND '0331'
GROUP BY month
ORDER BY month; 

-- Query 02
SELECT
    trafficSource.source as source,
    sum(totals.visits) as total_visits,
    sum(totals.Bounces) as total_no_of_bounces,
    (sum(totals.Bounces)/sum(totals.visits))* 100.00 as bounce_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
GROUP BY source
ORDER BY total_visits DESC;

-- Query 03
WITH month_revenue AS (
  SELECT
    'Month' AS time_type,
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS time,
    trafficSource.source AS source,
    ROUND(SUM(product.productRevenue)/1000000, 4) AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.product) AS product
  WHERE product.productRevenue IS NOT NULL
  GROUP BY time, source
),
week_revenue AS (
  SELECT
    'Week' AS time_type,
    FORMAT_DATE('%G%V', PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS time,
    trafficSource.source AS source,
    ROUND(SUM(product.productRevenue)/1000000, 4) AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.product) AS product
  WHERE product.productRevenue IS NOT NULL
  GROUP BY time, source
),
combined_table AS (
  SELECT * FROM month_revenue
  UNION ALL
  SELECT * FROM week_revenue
)

SELECT *
FROM combined_table
ORDER BY source, 
         CASE WHEN time_type = 'Month' THEN 0 ELSE 1 END,
         time;

-- Query 04
WITH pageviews_purchase AS(
    SELECT 
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS month,
      ROUND(SUM(totals.pageviews)/COUNT(DISTINCT fullVisitorId),8) AS avg_pageviews_purchase
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
      UNNEST(hits) hits,
      UNNEST(hits.product) product
    WHERE 
    _TABLE_SUFFIX BETWEEN '0601' AND '0731'
      AND totals.transactions >=1
      AND product.productRevenue IS NOT NULL
    GROUP BY month
    ORDER BY month
),
pageviews_non_purchase AS(
    SELECT 
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS month,
      ROUND(SUM(totals.pageviews)/COUNT(DISTINCT fullVisitorId),8) AS avg_pageviews_non_purchase
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
      UNNEST(hits) hits,
      UNNEST(hits.product) product
    WHERE 
    _TABLE_SUFFIX BETWEEN '0601' AND '0731'
      AND totals.transactions IS NULL
      AND product.productRevenue IS NULL
    GROUP BY month
    ORDER BY month
)

SELECT 
  pageviews.month,
  pageviews.avg_pageviews_purchase,
  non_pageviews.avg_pageviews_non_purchase
FROM pageviews_purchase AS pageviews
LEFT JOIN pageviews_non_purchase AS non_pageviews
USING (month)
ORDER BY pageviews.month;

-- Query 05
SELECT 
  FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS month,
  ROUND(SUM(totals.transactions)/COUNT(DISTINCT fullVisitorId),9) AS Avg_total_transactions_per_user
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST(hits) hits,
  UNNEST(hits.product) product
WHERE totals.transactions >=1
  AND product.productRevenue IS NOT NULL
GROUP BY month;

-- Query 06
SELECT 
  FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS month,
  SUM((productRevenue)/1000000) /SUM(totals.visits) AS avg_spend_per_session
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST(hits) hits,
  UNNEST(hits.product) product
WHERE totals.transactions IS NOT NULL
  AND product.productRevenue IS NOT NULL
GROUP BY month;

-- Query 07
WITH youtube_product AS (
  SELECT 
    DISTINCT fullVisitorId
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
    UNNEST (hits) AS hits,
    UNNEST (hits.product) AS product
  WHERE product.productRevenue IS NOT NULL
    AND totals.transactions >=1
    AND product.v2ProductName = "YouTube Men's Vintage Henley"
)

SELECT 
  product.v2ProductName AS other_purchased_products, 
  SUM(product.productQuantity) AS quantity
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
 UNNEST (hits) AS hits,
 UNNEST (product) AS product

INNER JOIN youtube_product
USING(fullVisitorId)
WHERE product.productRevenue IS NOT NULL
  AND totals.transactions >=1
  AND product.v2ProductName <> "YouTube Men's Vintage Henley"
GROUP BY product.v2ProductName
ORDER BY quantity DESC;

-- Query 08
WITH purchase_table AS (
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', CAST(date AS STRING))) AS month,
    COUNT(product.v2ProductName) AS num_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.product) AS product
  WHERE _table_suffix BETWEEN '0101' AND '0331'
    AND eCommerceAction.action_type = '6'
    AND product.productRevenue IS NOT NULL
    AND totals.transactions >=1
  GROUP BY month
  ORDER BY month),

product_table AS (
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    COUNT(product.v2ProductName) AS num_product_view
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.product) AS product
  WHERE _table_suffix BETWEEN '0101' AND '0331'
    AND eCommerceAction.action_type = '2'
    AND product.v2ProductName IS NOT NULL
  GROUP BY month
  ORDER BY month),

cart_table AS (
  SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    COUNT(product.v2ProductName) AS num_add_to_cart
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
    UNNEST(hits) AS hits,
    UNNEST(hits.product) AS product
  WHERE _table_suffix BETWEEN '0101' AND '0331'
    AND eCommerceAction.action_type = '3'
    AND product.v2ProductName IS NOT NULL
  GROUP BY month
  ORDER BY month),

combined_table AS (
  SELECT
    month,
    num_product_view,
    num_add_to_cart,
    num_purchase
  FROM product_table
  LEFT JOIN purchase_table USING (month)
  LEFT JOIN cart_table     USING (month)
)

SELECT
  month,
  num_product_view,
  num_add_to_cart,
  num_purchase,
  ROUND(SUM(num_add_to_cart/num_product_view)* 100.0, 2) AS add_to_cart_rate,
  ROUND(SUM(num_purchase/num_product_view)* 100.0, 2) AS purchase_rate
FROM combined_table
GROUP BY month, num_product_view, num_add_to_cart, num_purchase
ORDER BY month;
