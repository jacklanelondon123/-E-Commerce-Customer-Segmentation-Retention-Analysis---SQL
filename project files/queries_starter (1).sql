
-- 1) Monthly KPIs
WITH orders_clean AS (
  SELECT o.*
  FROM orders o
  JOIN payments p ON p.order_id = o.order_id
  WHERE p.status = 'paid'
)
SELECT
  strftime('%Y-%m', o.order_date) AS ym,
  COUNT(DISTINCT o.order_id) AS orders,
  ROUND(SUM(o.total_amount), 2) AS revenue,
  ROUND(AVG(o.total_amount), 2) AS avg_order_value,
  COUNT(DISTINCT o.customer_id) AS unique_buyers
FROM orders_clean o
GROUP BY ym
ORDER BY ym;

-- 2) Top 10 products by revenue
SELECT
  p.product_id,
  p.product_name,
  c.category_name,
  ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN payments pay ON pay.order_id = o.order_id AND pay.status = 'paid'
JOIN products p ON p.product_id = oi.product_id
JOIN categories c ON c.category_id = p.category_id
GROUP BY 1,2,3
ORDER BY revenue DESC
LIMIT 10;

-- 3) Revenue by channel and campaign (last 6 months)
SELECT
  strftime('%Y-%m', o.order_date) AS ym,
  ch.channel_name,
  COALESCE(camp.campaign_name, 'No Campaign') AS campaign_name,
  ROUND(SUM(o.total_amount), 2) AS revenue
FROM orders o
JOIN payments pay ON pay.order_id = o.order_id AND pay.status = 'paid'
JOIN channels ch ON ch.channel_id = o.channel_id
LEFT JOIN campaigns camp ON camp.campaign_id = o.campaign_id
WHERE date(o.order_date) >= date('now','-6 months')
GROUP BY 1,2,3
ORDER BY 1, 4 DESC;

-- 4) Cohorts (cohort month x order month revenue)
WITH paid_orders AS (
  SELECT o.*
  FROM orders o
  JOIN payments p ON p.order_id = o.order_id
  WHERE p.status = 'paid'
),
cohorts AS (
  SELECT
    c.customer_id,
    strftime('%Y-%m', c.signup_date) AS cohort_month
  FROM customers c
),
orders_enriched AS (
  SELECT
    o.customer_id,
    strftime('%Y-%m', o.order_date) AS order_month,
    o.total_amount
  FROM paid_orders o
)
SELECT
  co.cohort_month,
  oe.order_month,
  ROUND(SUM(oe.total_amount), 2) AS revenue
FROM cohorts co
JOIN orders_enriched oe
  ON oe.customer_id = co.customer_id
GROUP BY 1,2
ORDER BY 1,2;

-- 5) RFM (SQLite-friendly; no NTILE -> quartile via CASE)
WITH paid_orders AS (
  SELECT o.*
  FROM orders o
  JOIN payments p ON p.order_id = o.order_id
  WHERE p.status = 'paid'
),
agg AS (
  SELECT
    c.customer_id,
    JULIANDAY('now') - JULIANDAY(MAX(o.order_date)) AS recency_days,
    COUNT(DISTINCT o.order_id) AS frequency,
    SUM(o.total_amount) AS monetary
  FROM customers c
  LEFT JOIN paid_orders o ON o.customer_id = c.customer_id
  GROUP BY 1
)
SELECT
  customer_id,
  CASE
    WHEN recency_days <= (SELECT percentile_cont(0.2) WITHIN GROUP (ORDER BY recency_days) FROM agg) THEN 5
    WHEN recency_days <= (SELECT percentile_cont(0.4) WITHIN GROUP (ORDER BY recency_days) FROM agg) THEN 4
    WHEN recency_days <= (SELECT percentile_cont(0.6) WITHIN GROUP (ORDER BY recency_days) FROM agg) THEN 3
    WHEN recency_days <= (SELECT percentile_cont(0.8) WITHIN GROUP (ORDER BY recency_days) FROM agg) THEN 2
    ELSE 1
  END ||
  CASE
    WHEN frequency >= (SELECT percentile_cont(0.8) WITHIN GROUP (ORDER BY frequency) FROM agg) THEN 5
    WHEN frequency >= (SELECT percentile_cont(0.6) WITHIN GROUP (ORDER BY frequency) FROM agg) THEN 4
    WHEN frequency >= (SELECT percentile_cont(0.4) WITHIN GROUP (ORDER BY frequency) FROM agg) THEN 3
    WHEN frequency >= (SELECT percentile_cont(0.2) WITHIN GROUP (ORDER BY frequency) FROM agg) THEN 2
    ELSE 1
  END ||
  CASE
    WHEN monetary >= (SELECT percentile_cont(0.8) WITHIN GROUP (ORDER BY monetary) FROM agg) THEN 5
    WHEN monetary >= (SELECT percentile_cont(0.6) WITHIN GROUP (ORDER BY monetary) FROM agg) THEN 4
    WHEN monetary >= (SELECT percentile_cont(0.4) WITHIN GROUP (ORDER BY monetary) FROM agg) THEN 3
    WHEN monetary >= (SELECT percentile_cont(0.2) WITHIN GROUP (ORDER BY monetary) FROM agg) THEN 2
    ELSE 1
  END AS rfm_score,
  ROUND(recency_days,1) AS recency_days,
  frequency,
  ROUND(monetary,2) AS monetary
FROM agg
ORDER BY rfm_score DESC, monetary DESC
LIMIT 50;

-- 6) Category mix & YoY
WITH paid_orders AS (
  SELECT o.order_id, o.order_date
  FROM orders o
  JOIN payments p ON p.order_id = o.order_id
  WHERE p.status = 'paid'
)
SELECT
  c.category_name,
  strftime('%Y', o.order_date) AS year,
  ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM paid_orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories c ON c.category_id = p.category_id
GROUP BY 1,2
ORDER BY 1,2;

-- 7) LTV by acquisition channel
WITH paid AS (
  SELECT o.*
  FROM orders o
  JOIN payments p ON p.order_id = o.order_id AND p.status = 'paid'
),
first_order AS (
  SELECT customer_id, MIN(order_date) AS first_dt
  FROM paid
  GROUP BY 1
),
acq AS (
  SELECT p.customer_id, p.channel_id
  FROM paid p
  JOIN first_order f ON f.customer_id = p.customer_id AND f.first_dt = p.order_date
),
ltv AS (
  SELECT p.customer_id, SUM(p.total_amount) AS ltv
  FROM paid p
  GROUP BY 1
)
SELECT ch.channel_name, ROUND(AVG(l.ltv),2) AS avg_ltv, COUNT(*) AS customers
FROM acq a
JOIN channels ch ON ch.channel_id = a.channel_id
JOIN ltv l ON l.customer_id = a.customer_id
GROUP BY 1
ORDER BY avg_ltv DESC;

-- 8) Campaign A/B comparison (edit IDs as needed, e.g., 10 and 11)
SELECT
  camp.campaign_name,
  ROUND(AVG(o.total_amount),2) AS avg_order_value,
  COUNT(*) AS orders
FROM orders o
JOIN payments p ON p.order_id = o.order_id AND p.status='paid'
JOIN campaigns camp ON camp.campaign_id = o.campaign_id
WHERE camp.campaign_id IN (10,11)
GROUP BY 1;
