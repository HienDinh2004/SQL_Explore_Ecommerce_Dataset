**I. Introduction**
_________________________________
This project contains an eCommerce dataset that I will explore using SQL on Google BigQuery. The dataset is based on the Google Analytics public dataset and contains data from an eCommerce website.

**II. Project Objectives**
___________________________________
- Calculate monthly total visits, pageviews, transactions, and revenue for early 2017.

- Analyze bounce rates and revenue performance by traffic source.

- Compare product pageviews between purchasers and non-purchasers.

- Measure average number of transactions per purchasing user.

- Compute session-level revenue for purchasers to evaluate session value.

- Identify frequently co-purchased products with “YouTube Men’s Vintage Henley.”

- Build a 3-month funnel from product view → add to cart → purchase.

- Provide insights into user behavior to support marketing and conversion strategy.

**III. Requirements**

- Google Cloud Platform account
- Project on Google Cloud Platform
- Google BigQuery API enabled
- SQL query editor or IDE

**IV. Dataset Access**

The eCommerce dataset is stored in a public Google BigQuery dataset. To access the dataset, follow these steps:

- Log in to your Google Cloud Platform account and create a new project.
  
- Navigate to the BigQuery console and select your newly created project.
  
- In the navigation panel, select "Add Data" and then "Search a project".
  
- Enter the project ID "bigquery-public-data.google_analytics_sample.ga_sessions" and click "Enter".
  
- Click on the "ga_sessions_" table to open it.

**V. Exploring the Dataset**

In this project, I will write 08 query in Bigquery base on Google Analytics dataset

**Query 01: Calculate total visit, pageview and transaction for January, February and March 2017 order by month**

- SQL code
<img width="679" height="187" alt="image" src="https://github.com/user-attachments/assets/25840627-47fd-477b-b833-d7e03cfc2585" />

- Result
<img width="1117" height="136" alt="image" src="https://github.com/user-attachments/assets/cce52ecd-0d36-49a9-8bac-3377ec3f818e" />

**Query 02: Bounce rate per traffic source in July 2017**

- SQL code
<img width="798" height="208" alt="image" src="https://github.com/user-attachments/assets/98b31752-38ff-44f2-b877-5f701a4a4075" />

- Result
<img width="1382" height="288" alt="image" src="https://github.com/user-attachments/assets/5bb61969-8558-4938-8d1a-3798fd04af55" />

**Query 03: Revenue by traffic source by week, by month in June 2017**

- SQL code
<img width="1090" height="483" alt="image" src="https://github.com/user-attachments/assets/fdaae056-7c56-4aca-bb49-4de1ca8a8f17" />
<img width="788" height="256" alt="image" src="https://github.com/user-attachments/assets/4b451825-de7c-4a18-9ce7-4a1074b3eab6" />

- Result
<img width="1262" height="295" alt="image" src="https://github.com/user-attachments/assets/dd57dd93-5bb2-43b9-ae36-fd39da2a3d4e" />

**Query 04: Average number of product pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017**

- SQL code
<img width="965" height="483" alt="image" src="https://github.com/user-attachments/assets/dcb82cb3-585a-424f-9380-aa77e1f09e30" />
<img width="819" height="310" alt="image" src="https://github.com/user-attachments/assets/6472652f-1fe1-4ae3-a459-741c23c1172b" />

- Result
<img width="992" height="128" alt="image" src="https://github.com/user-attachments/assets/2594368c-41f7-4bb9-8e01-95b1a13b4f31" />

**Query 05: Average number of transactions per user that made a purchase in July 2017**

- SQL code
<img width="1032" height="335" alt="image" src="https://github.com/user-attachments/assets/2945fd30-2dda-44d1-8ddc-c625ef56ecce" />

- Result
<img width="893" height="210" alt="image" src="https://github.com/user-attachments/assets/85d309e6-ca66-476c-8585-3703b6f0e2c4" />

**Query 06: Average amount of money spent per session. Only include purchaser data in July 2017**

- SQL code
<img width="923" height="233" alt="image" src="https://github.com/user-attachments/assets/8de7a563-bb9c-4bb9-b0e7-7c543eef08c8" />

- Result
<img width="1351" height="89" alt="image" src="https://github.com/user-attachments/assets/d23f432c-637c-4f90-b2e6-457ddec487ff" />

**Query 07: Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. Output should show product name and the quantity was ordered**

- SQL code
<img width="1031" height="426" alt="image" src="https://github.com/user-attachments/assets/fb03e6df-00bc-4939-ba52-a491f19576ae" />
<img width="814" height="104" alt="image" src="https://github.com/user-attachments/assets/7004acfe-c2b7-408a-b93f-f280e2b1b5b5" />

- Result
<img width="994" height="272" alt="image" src="https://github.com/user-attachments/assets/e1c21dca-ca88-4c82-9297-72e8da24d621" />

**Query 08: Calculate cohort map from pageview to addtocart to purchase in last 3 month**

- SQL code
<img width="1035" height="483" alt="image" src="https://github.com/user-attachments/assets/7f3495fc-6361-4378-bd9c-b688cf479c82" />
<img width="756" height="485" alt="image" src="https://github.com/user-attachments/assets/d1b25b67-c5b4-4f34-b381-16bd55a43ac1" />
<img width="902" height="296" alt="image" src="https://github.com/user-attachments/assets/ae551297-1417-4551-bae9-001a992f1cfb" />

- Result
<img width="1410" height="241" alt="image" src="https://github.com/user-attachments/assets/affc6c67-2481-4ff4-8249-cbff8c51cebc" />


















