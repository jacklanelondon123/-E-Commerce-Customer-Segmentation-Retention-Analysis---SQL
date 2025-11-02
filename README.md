# 🛍️ E-Commerce Customer Segmentation & Retention Analysis

## 📖 Project Overview
This project explores **customer behavior and retention patterns** for an e-commerce business using SQL Server, Excel, and data visualization techniques. The analysis focuses on two key frameworks:  
1. **Cohort Analysis** – tracking customer retention and revenue over time.  
2. **RFM Segmentation** – grouping customers based on **Recency, Frequency, and Monetary** metrics.  
The goal was to uncover insights that could drive smarter marketing, improve retention, and increase lifetime customer value.

---

## 🎯 Objectives
- Understand **customer purchase behavior** over time.  
- Identify **retention trends** and **cohort performance**.  
- Segment customers into **meaningful RFM categories** (e.g., VIP, Loyal, At Risk, Churned).  
- Provide **data-driven recommendations** for retention and growth.

---

## 🧩 Tools & Skills Used
- **SQL Server** – Data cleaning, transformation, RFM scoring & cohort creation.  
- **Excel** – PivotTables, conditional formatting, and data visualization.  
- **Data storytelling** – Translating findings into business insights.  

---

## 📂 Dataset
The dataset includes anonymized customer transaction records with:  
- `customer_id`  
- `order_date`  
- `amount`  
- `recency_days`  
- `frequency`  
- `monetary`  
- derived `R_score`, `F_score`, `M_score`, and final RFM segment.  

---

## 🔍 Step 1 – Cohort Analysis
Using SQL, I created a **cohort-based revenue view**, grouping customers by the month of their first purchase (`Cohort_month`) and tracking their subsequent spending across future months (`Order_month`).

### 📊 Cohort Heatmap
Using Excel’s conditional color scales, I visualized the **retention trend**:  
![Cohort Heatmap](images/cohort_heatmap.png)

#### 🧠 Insight:
- Retention drops sharply after the first few months — a classic “long tail” retention curve.  
- Certain months show stronger second-month retention, suggesting successful short-term campaigns.  
- The early cohorts have **consistent but gradual revenue decay**, implying room for retention improvement.  

#### ✅ Key takeaway:
> The business retains a strong initial engagement period, but needs to improve post-onboarding retention through follow-up offers or loyalty programs.

---

## 💎 Step 2 – RFM Segmentation
I built a SQL view to calculate **Recency, Frequency, and Monetary** scores (1–5 scale) for each customer.

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

Then, I aggregated the results to analyze segment sizes and averages.

👥 Step 3 – Customer Distribution by Segment
📊 Pivot Table Summary
Segment	Customers
Regular	840
Churned	552
At Risk	448
VIP	373
Loyal	249
New Customer	38
Total	2,500

🧠 Insight:

Regular customers form the largest group (34%), showing a solid active base.

Churned customers (552) indicate a worrying drop-off rate.

At Risk (448) customers could be reactivated before they churn completely.

VIPs (373) and Loyals (249) form the most valuable and engaged tiers.

New Customers (38) are few, suggesting that acquisition could be improved.

✅ Recommendations:

Re-engage “Churned” & “At Risk” segments with personalized offers or win-back campaigns.

Reward “Loyal” and “VIP” customers with exclusive perks to increase advocacy.

Improve acquisition efforts to grow the “New Customer” base.

💷 Step 4 – Average Spend by Segment

I compared average monetary value across segments to see where the most profitable customers lie.


🧠 Insight:

New Customers have the highest average spend (£5,192) — likely due to initial offers or bulk first-time purchases.

Churned customers once spent significantly (£4,421) but have since dropped off.

Regular and At Risk customers show stable spend levels.

VIP customers surprisingly have lower spend (£1,401), suggesting that “VIP” status may be defined by frequency, not value — an opportunity to refine the scoring logic.

✅ Recommendation:

Review the VIP definition — consider weighting Monetary more heavily or running a revenue-based segmentation to better align rewards with actual spend.

🧭 Step 5 – Final Insights & Business Value
📈 Key Findings:

The business retains strong early engagement but struggles with long-term retention.

“Regular” and “At Risk” customers represent the largest potential for upselling.

The RFM model highlights that not all “VIPs” are necessarily high-value — segmentation logic should evolve over time.

💡 Strategic Recommendations:

Retention Focus: Automate win-back campaigns targeting Churned and At Risk segments.

Personalization: Tailor offers based on RFM scores to increase conversion and lifetime value.

Data Refresh: Re-run RFM scoring quarterly to track changes in customer behavior.

🧰 Files in This Repository
File	Description
RFM_analysis.sql	SQL script for cohort and RFM segmentation
cohort_revenue.xlsx	Cohort revenue pivot tables and heatmap
rfm_segments.xlsx	RFM segment distribution and analysis
images/	Folder containing visual outputs (charts, heatmaps)
README.md	This project documentation
🌟 Project Reflection

This project demonstrates my ability to:

Design end-to-end analytical workflows.

Combine SQL logic with Excel visualization.

Tell a clear story from raw data to actionable insight.

Through this project, I learned how data segmentation can guide marketing strategy, drive customer retention, and reveal hidden behavioral patterns in e-commerce data.

🧾 Author

Ray [Your Surname]
📧 [your.email@email.com
]
🔗 [LinkedIn Profile]
💻 [GitHub Profile]
