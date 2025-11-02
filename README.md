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

### Cohort Heatmap
![Cohort Heatmap](images/cohort%20heatmap%20excel%20image.png)

**Insights**
- Retention drops significantly after the first few months — a typical long-tail trend.  
- Some cohorts maintain better second-month retention, suggesting effective short-term promotions.  
- Overall retention decay indicates opportunity to improve post-onboarding engagement.

**Takeaway:**  
The company achieves strong early engagement but lacks long-term retention. Implementing loyalty programs or follow-up discounts could help sustain repeat purchases.

---

## 🔹 Step 2: RFM Segmentation
Customers were segmented by their **Recency (R)**, **Frequency (F)**, and **Monetary (M)** scores.

**SQL Script**

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

---

## 🔹 Step 3: Customer Distribution by Segment
After creating the SQL view, results were exported to Excel to summarize and visualize customer segment distribution.

![Customer Distribution](images/rfm%20chart%20image%201.png)

**Insights**
- Regular customers (34%) form the largest active base.  
- Churned customers (552) highlight significant potential loss.  
- At Risk customers (448) could still be reactivated before full churn.  
- VIPs (373) and Loyals (249) represent highly engaged, valuable users.  
- New Customers (38) are few, suggesting weak acquisition momentum.

**Recommendations**
- Target Churned and At Risk customers with win-back campaigns.  
- Reward VIPs and Loyals to encourage repeat purchases.  
- Strengthen acquisition strategies to expand new customer inflow.

---

## 🔹 Step 4: Average Spend by Segment
To understand revenue patterns, the average spend per customer was analyzed across segments.

![Average Spend by Segment](images/rfm%20chart%20image%202.png)

**Insights**
- New Customers show the highest spend (£5,192), likely due to larger first-time purchases.  
- Churned customers had high past value — potential reactivation ROI.  
- VIPs spend less than expected, suggesting VIP criteria may emphasize activity over value.

**Recommendation:**  
Adjust VIP scoring to prioritize **Monetary value** to better identify truly high-value customers.

---

## 🔹 Step 5: Supporting Channel and Product Insights

### Top Channels by Lifetime Value (LTV)
![LTV by Channel](images/Screenshot%202025-10-10%20012220.png)

- **Email** and **Display** channels have the highest LTV (£3,400+), suggesting they are strong performers for retention.  
- **Social** and **Affiliate** channels show lower LTVs, indicating potential underperformance.  
- Optimizing ad spend toward high-LTV channels could increase profitability.

### Top Products by Revenue
![Top Products by Revenue](images/Screenshot%202025-10-10%20012227.png)

- High revenue concentration in **Books** and **Toys** categories.  
- Suggests that marketing campaigns could leverage these best-selling categories for cross-selling and bundle offers.

---

## 🔹 Step 6: Monthly Sales Trends
To evaluate growth and engagement over time, monthly revenue and order trends were analyzed.

![Monthly Trends](images/Screenshot%202025-10-10%20012251.png)
![Monthly Trends Continued](images/Screenshot%202025-10-10%20012321.png)

**Insights**
- Strong month-on-month revenue growth from early 2023 through late 2025.  
- Steady increases in average order value and unique buyers.  
- Highlights successful acquisition and retention over time.

---

## 🔹 Step 7: Final Insights & Business Value

**Key Findings**
- High early engagement but declining long-term retention.  
- “Regular” and “At Risk” segments represent major growth opportunities.  
- VIP classification needs refinement for higher value targeting.  

**Strategic Recommendations**
- Automate retention campaigns for **Churned** and **At Risk** segments.  
- Personalize offers using **RFM-based targeting**.  
- Recalculate RFM segmentation quarterly to track evolving behavior.  
- Prioritize high-LTV channels and top product categories for sustained growth.

---

## 📊 Files in Repository
| File | Description |
|------|-------------|
| RFM_analysis.sql | SQL script for RFM segmentation |
| cohort_revenue.xlsx | Cohort analysis tables and visuals |
| rfm_segments.xlsx | Pivot tables and RFM segment breakdown |
| images/ | Contains visuals and charts used in this README |
| README.md | Full documentation (this file) |

---

## 🌟 Reflection
This project demonstrates my ability to:
- Build a complete data-to-insight workflow using SQL and Excel  
- Translate analytics into actionable business recommendations  
- Communicate findings clearly through visual storytelling  

**Key learning:**  
RFM segmentation provides a powerful framework for identifying which customers to retain, nurture, or win back, and where to focus marketing spend for maximum ROI.

---

## ✍️ Author
**Ray [Your Surname]**  
📧 your.email@email.com  
🔗 [LinkedIn Profile]  
💻 [GitHub Profile]
