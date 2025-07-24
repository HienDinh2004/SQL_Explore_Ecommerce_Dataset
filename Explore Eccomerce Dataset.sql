Fraud Detection Project

-- Query 01: Create Clean Table

CREATE OR REPLACE TABLE
  `fraud-project-466707.fraud_projects.fraud_clean` AS
SELECT
  CAST(Time AS INT64) AS step,
  SAFE_CAST(Amount AS NUMERIC) AS amount,
  SAFE_CAST(Class AS BOOL) AS is_fraud,
  IF(Amount>10000,'Large','Small') AS size_flag,
  TIMESTAMP_SECONDS(CAST(Time AS INT64)) AS txn_time
FROM `bigquery-public-data.ml_datasets.ulb_fraud_detection`
WHERE Amount IS NOT NULL;

-- Query 02: Calculate Overall Fraud Rate

SELECT
  COUNT(*) AS total_txns
 ,SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) AS total_frauds
 ,ROUND(100 * SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS fraud_rate_pct
FROM `fraud-project-466707.fraud_projects.fraud_clean`;

--Query 03: Analyze Fraud by Transaction Size

SELECT
  size_flag
 ,COUNT(*) AS cnt
 ,SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) AS frauds
 ,ROUND(100 * SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct
 FROM `fraud-project-466707.fraud_projects.fraud_clean`
 GROUP BY size_flag
 ORDER BY size_flag;

-- Query 04: Fraud Distribution Over Time

SELECT
  step,
  txn_time,
  SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) AS total_frauds,
  CONCAT(
    ROUND(
      SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) * 100.0 /
      (
        SELECT COUNT(*)
        FROM `fraud-project-466707.fraud_projects.fraud_clean`
        WHERE is_fraud = TRUE
      ),
      2
    ),
    '%'
  ) AS fraud_rate
FROM `fraud-project-466707.fraud_projects.fraud_clean`
GROUP BY step, txn_time
ORDER BY total_frauds DESC
LIMIT 5;
