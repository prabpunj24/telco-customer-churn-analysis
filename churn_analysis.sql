--Preview the dataset
select * from Telco_Customer_Churn limit 5;

--Check table structure
PRAGMA table_info(telco_customer_churn);

--Count rows
SELECT COUNT(*) FROM telco_customer_churn;

--Check Data Distribution
SELECT Churn, COUNT(*) 
FROM telco_customer_churn
GROUP BY Churn; 
--Check Summary Statistics
SELECT 
MIN(MonthlyCharges) AS min_charge,
MAX(MonthlyCharges) AS max_charge,
AVG(MonthlyCharges) AS avg_charge
FROM telco_customer_churn;

--Churn by Tenure Groups
SELECT 
CASE 
WHEN tenure < 12 THEN 'New Customers'
WHEN tenure < 36 THEN 'Mid-term Customers'
ELSE 'Long-term Customers'
END AS tenure_group,
COUNT(*) AS customers,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_customer_churn
GROUP BY tenure_group;

--Overall Churn Rate
SELECT 
  COUNT(*) as total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate_pct
FROM telco_customer_churn;

--Contract Churn
SELECT 
  Contract,
  COUNT(*) as customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_pct
FROM telco_customer_churn 
GROUP BY Contract 
ORDER BY churn_pct DESC;

--Internet Churn
SELECT 
  InternetService,
  COUNT(*) as customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_pct
FROM telco_customer_churn 
GROUP BY InternetService 
ORDER BY churn_pct DESC;

--Value Churn
SELECT 
  CASE 
    WHEN MonthlyCharges >= 80 THEN 'Premium ($80+)'
    WHEN MonthlyCharges >= 50 THEN 'Mid ($50-79)'
    ELSE 'Basic (<$50)'
  END as value_segment,
  COUNT(*) as customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_pct
FROM telco_customer_churn 
GROUP BY value_segment 
ORDER BY churn_pct DESC;

--Risk Combo
SELECT 
  Contract,
  TechSupport,
  COUNT(*) as customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_pct
FROM telco_customer_churn 
GROUP BY Contract, TechSupport 
ORDER BY churn_pct DESC 
LIMIT 5;
