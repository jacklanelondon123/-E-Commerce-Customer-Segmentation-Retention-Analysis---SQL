# 🛍️ E-Commerce Customer Segmentation & Retention Analysis

## 📘 Project Overview
This project investigates customer behavior and retention using **SQL Server**, **Excel**, and visualization techniques.  
It focuses on two main analytical frameworks:

- **Cohort Analysis** – tracking customer retention and revenue over time  
- **RFM Segmentation** – grouping customers based on Recency, Frequency, and Monetary value  

The goal was to uncover insights that drive smarter marketing, improved retention, and higher lifetime customer value.

---

## 🎯 Objectives
- Understand customer purchase behavior over time  
- Identify retention and cohort trends  
- Segment customers into actionable RFM categories (**VIP**, **Loyal**, **At Risk**, **Churned**)  
- Deliver practical, data-driven recommendations  

---

## 🧰 Tools & Skills
- **SQL Server** – data preparation, cleaning, and segmentation logic  
- **Excel** – PivotTables, visual analysis, and storytelling  
- **Data storytelling** – translating analytics into business insights  

---

## 📂 Dataset
The dataset includes anonymized transaction-level records containing:  
`customer_id`, `order_date`, `amount`, `recency_days`, `frequency`, `monetary`, and the derived metrics `R_score`, `F_score`, `M_score`, and `segment`.

---

## 🔹 Step 1: Cohort Analysis
Customers were grouped by their first purchase month (**Cohort Month**) and tracked across future purchase months.

### 📊 Cohort Heatmap
*(Insert image if available — e.g., `images/cohort_heatmap.png`)*

### 🔍 Insights
- Retention drops significantly after the first few months — a typical long-tail trend.  
- Some cohorts maintain better second-month retention, suggesting effective short-term promotions.  
- Overall retention decay indicates opportunity to improve post-onboarding engagement.

**Takeaway:**  
The company achieves strong early engagement but lacks long-term retention. Implementing loyalty programs or follow-up discounts could help sustain repeat purchases.

---

## 🔹 Step 2: RFM Segmentation
Customers were segmented by their **Recency (R)**, **Frequency (F)**, and **Monetary (M)** scores.

### 🧾 SQL Script
```sql
CREATE VIEW dbo.v_rfm_segments AS
SELECT
    customer_id,
    R_score,
    F_score,
    M_score,
    CONCAT(R_score, F_score, M_score) AS RFM_code,
    CASE
        WHEN R_score >= 4 AND F_score >= 4 AND M_score >= 4 THEN 'VIP'
        WHEN R_score >= 3 AND F_score >= 4 THEN 'Loyal'
        WHEN R_score <= 2 AND F_score = 3 THEN 'At Risk'
        WHEN R_score = 5 AND F_score = 1 THEN 'New Customer'
        WHEN R_score <= 2 AND F_score <= 2 THEN 'Churned'
        ELSE 'Regular'
    END AS segment
FROM dbo.v_rfm_scores;
🔹 Step 3: Customer Distribution by Segment
After creating the SQL view, results were exported to Excel to summarize and visualize customer segment distribution.

Segment	Count
Regular	840
Churned	552
At Risk	448
VIP	373
Loyal	249
New Customer	38
Total	2,500

🔍 Insights
Regular customers (34%) form the largest active base.

Churned customers (552) highlight significant potential loss.

At Risk customers (448) could still be reactivated before full churn.

VIPs (373) and Loyals (249) represent highly engaged, valuable users.

New Customers (38) are few, suggesting weak acquisition momentum.

💡 Recommendations
Target Churned and At Risk customers with win-back campaigns.

Reward VIPs and Loyals to encourage repeat purchases.

Strengthen acquisition strategies to expand new customer inflow.

🔹 Step 4: Average Spend by Segment
To understand revenue patterns, the average spend per customer was analyzed across segments.

Segment	Average Spend (£)
VIP	£1,401
At Risk	£2,425
Loyal	£2,415
Regular	£3,839
Churned	£4,421
New Customer	£5,192

🔍 Insights
New Customers show the highest spend (£5,192), likely due to larger first-time purchases.

Churned customers had high past value — potential reactivation ROI.

VIPs spend less than expected, suggesting VIP criteria may emphasize activity over value.

Recommendation:
Adjust VIP scoring to prioritize Monetary value to better identify truly high-value customers.

🔹 Step 5: Final Insights & Business Value
📈 Key Findings
High early engagement but declining long-term retention

“Regular” and “At Risk” segments represent major growth opportunities

VIP classification needs refinement

💼 Strategic Recommendations
Automate retention campaigns for Churned and At Risk segments

Personalize offers using RFM-based targeting

Recalculate RFM segmentation quarterly to track evolving behavior

📊 Files in Repository
File	Description
RFM_analysis.sql	SQL script for RFM segmentation
cohort_revenue.xlsx	Cohort analysis tables and visuals
rfm_segments.xlsx	Pivot tables and RFM segment breakdown
images/	Visuals for charts and heatmaps
README.md	Full documentation (this file)

🌟 Reflection
This project demonstrates my ability to:

Create a full data-to-insight workflow using SQL and Excel

Translate analytics into business strategy and segmentation models

Communicate findings through clear, visual storytelling

Key learning:
RFM segmentation provides a simple yet powerful framework for identifying which customers to retain, nurture, or win back, and where to focus marketing spend for maximum ROI.

✍️ Author
Ray [Your Surname]
📧 your.email@email.com
🔗 [LinkedIn Profile]
💻 [GitHub Profile]
