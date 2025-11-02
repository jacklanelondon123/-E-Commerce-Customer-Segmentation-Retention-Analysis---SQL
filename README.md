# 🛍️ E-Commerce Customer Segmentation & Retention Analysis

## 📘 Project Overview
This project investigates **customer behavior and retention** using SQL Server, Excel, and data visualization.  
It focuses on two key analytical approaches:

1. **Cohort Analysis** – tracking customer retention and revenue over time  
2. **RFM Segmentation** – grouping customers based on **Recency, Frequency, and Monetary value**

The objective is to uncover actionable insights that help drive smarter marketing, stronger retention, and higher customer lifetime value.

---

## 🎯 Objectives
- Understand customer purchase behavior over time  
- Identify retention trends and cohort performance  
- Segment customers into meaningful RFM categories (VIP, Loyal, At Risk, Churned, etc.)  
- Deliver insights and data-driven recommendations for marketing optimization  

---

## 🧰 Tools & Skills
- **SQL Server** – for data preparation, transformation, and scoring  
- **Excel** – for PivotTables, visualization, and storytelling  
- **Data Analysis & Storytelling** – communicating insights effectively  

---

## 📂 Dataset
The dataset contains anonymized transaction data including:
- `customer_id`
- `order_date`
- `amount`
- `recency_days`
- `frequency`
- `monetary`
- derived metrics: `R_score`, `F_score`, `M_score`, and `segment`

---

## 🔹 Step 1: Cohort Analysis
Cohort analysis groups customers by the month of their first purchase (`Cohort_month`) and tracks spending across future months (`Order_month`).

### Cohort Heatmap
Using Excel’s color scales, I visualized retention and revenue behavior.

![Cohort Heatmap](images/cohort_heatmap.png)

### Key Insights
- Retention drops sharply after the first few months – a classic “long tail” trend  
- Some cohorts maintain higher second-month revenue, indicating successful short-term campaigns  
- Revenue gradually declines over time, showing room for retention improvement  

**Takeaway:**  
> The company shows strong early engagement but weak long-term retention. Implementing loyalty programs and personalized follow-ups could help extend customer lifespan.

---

## 🔹 Step 2: RFM Segmentation
RFM segmentation categorizes customers based on:
- **Recency (R):** How recently they purchased  
- **Frequency (F):** How often they purchase  
- **Monetary (M):** How much they spend  

### SQL Script
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

The SQL results were visualized in Excel to show how customers distribute across RFM categories.

Segment	Count
Regular	840
Churned	552
At Risk	448
VIP	373
Loyal	249
New Customer	38
Total	2,500

Insights

Regular customers (34%) form the largest active base

Churned customers (552) represent significant loss potential

At Risk (448) customers can still be reactivated

VIP (373) and Loyal (249) are high-engagement groups

New Customers (38) are few, highlighting weak acquisition

Recommendations

Target Churned and At Risk customers with win-back campaigns

Reward VIPs and Loyals with loyalty perks

Enhance acquisition to grow the new customer pipeline

🔹 Step 4: Average Spend by Segment

This visualization compares average spend per customer for each RFM segment.

Segment	Avg. Spend (£)
VIP	£1,401
At Risk	£2,425
Loyal	£2,415
Regular	£3,839
Churned	£4,421
New Customer	£5,192

Insights

New Customers have the highest average spend (£5,192), likely due to initial purchases

Churned customers previously had high value and could be reactivated profitably

VIPs show low average spend — VIP status seems frequency-driven rather than value-based

Recommendation:

Refine the RFM scoring to weight Monetary value more heavily for a more accurate VIP definition.

🔹 Step 5: Final Insights & Business Value
Key Findings

High early engagement, low long-term retention

“Regular” and “At Risk” segments offer the greatest upsell opportunity

VIP definition could be optimized to better reflect true spenders

Strategic Recommendations

Automate retention campaigns targeting Churned and At Risk customers

Personalize offers based on RFM segments

Refresh segmentation quarterly to monitor behavioral change

📊 Files in Repository
File	Description
RFM_analysis.sql	SQL code for cohort and RFM segmentation
cohort_revenue.xlsx	Cohort analysis and heatmap
rfm_segments.xlsx	RFM segmentation pivot tables and visuals
images/	Folder containing all charts and screenshots
README.md	Full project documentation
🌟 Reflection

This project demonstrates:

End-to-end analytical workflow from SQL to visualization

Ability to turn data into actionable marketing strategy

Strong use of storytelling and insight-driven presentation

Through this project, I learned how RFM and cohort frameworks help businesses measure loyalty, retention, and customer value to guide smarter marketing decisions.

✍️ Author

Ray [Your Surname]
📧 your.email@email.com

🔗 [LinkedIn Profile]
💻 [GitHub Profile]
