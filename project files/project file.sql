USE EcomPortfolio;
GO

IF OBJECT_ID('dbo.v_rfm_segments','V') IS NOT NULL DROP VIEW dbo.v_rfm_segments;
GO

CREATE VIEW dbo.v_rfm_segments
AS
SELECT
    customer_id,
    R_score,
    F_score,
    M_score,
    CONCAT(R_score, F_score, M_score) AS RFM_code,
    CASE
        WHEN R_score >= 4 AND F_score >= 4 AND M_score >= 4 THEN 'VIP'
        WHEN R_score >= 3 AND F_score >= 4 THEN 'Loyal'
        WHEN R_score <= 2 AND F_score >= 3 THEN 'At Risk'
        WHEN R_score = 5 AND F_score = 1 THEN 'New Customer'
        WHEN R_score <= 2 AND F_score <= 2 THEN 'Churned'
        ELSE 'Regular'
    END AS segment
FROM dbo.v_rfm_scores;
GO

-- preview
SELECT TOP (20) * FROM dbo.v_rfm_segments;
SELECT
    segment,
    COUNT(*) AS num_customers,
    AVG(R_score) AS avg_R,
    AVG(F_score) AS avg_F,
    AVG(M_score) AS avg_M
FROM dbo.v_rfm_segments
GROUP BY segment
ORDER BY num_customers DESC;
