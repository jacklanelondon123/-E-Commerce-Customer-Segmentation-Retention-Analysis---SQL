
SQL Portfolio Project: E-commerce Analytics (SQLite)
====================================================

Files:
- ecom_sql_portfolio.db  — open in DB Browser for SQLite (or DBeaver).
- queries_starter.sql    — run these for KPIs, Cohorts, RFM, LTV, YoY, Campaigns.
- SQL_Project_README.txt — setup & portfolio storyline ideas.

Setup:
1) Open ecom_sql_portfolio.db in DB Browser for SQLite.
2) Go to Execute SQL → Open queries_starter.sql → run queries (one by one at first).
3) Export result grids as CSV for charts in Google Sheets/Excel, or take screenshots for your portfolio.

Data model:
- channels(channel_id, channel_name)
- campaigns(campaign_id, channel_id, campaign_name, start_date, end_date)
- customers(customer_id, signup_date, country, gender, age_band)
- categories(category_id, category_name)
- products(product_id, category_id, product_name, unit_price)
- orders(order_id, customer_id, order_date, channel_id, campaign_id, total_amount)
- order_items(order_item_id, order_id, product_id, quantity, unit_price)
- payments(payment_id, order_id, method, status)

Notes:
- Count revenue only where payments.status = 'paid'.
- Orders cover 2023-01-01 to 2025-09-30 (~14k orders, ~2.5k customers).

Storyline ideas:
- Acquisition channel drives LTV: use LTV query to compare averages and customer counts.
- Cohort retention: pivot cohort_month x order_month revenue into a heatmap.
- Category YoY mix: which categories are gaining share vs declining?
- RFM: identify top customers (score 555–545) and propose a VIP strategy.
