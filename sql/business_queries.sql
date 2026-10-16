
-- 01. Executive KPI summary
SELECT
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(roi_pct), 2) AS avg_roi_pct,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct,
    ROUND(AVG(high_roi) * 100, 2) AS high_roi_rate_pct,
    ROUND(AVG(net_cost_usd), 2) AS avg_net_cost,
    ROUND(AVG(debt_usd), 2) AS avg_debt,
    ROUND(AVG(added_earnings_10yr_usd), 2) AS avg_added_earnings
FROM college_major_roi;

-- 02. Rank majors by average ROI
SELECT
    major,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(roi_pct), 2) AS avg_roi_pct,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY major
ORDER BY avg_net_roi DESC;

-- 03. Find majors with negative average ROI
SELECT
    major,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY major
HAVING AVG(net_roi_usd) < 0
ORDER BY avg_net_roi;

-- 04. ROI by major category
SELECT
    major_category,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY major_category
ORDER BY avg_net_roi DESC;

-- 05. Institution-tier performance
SELECT
    institution_tier,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(net_cost_usd), 2) AS avg_cost,
    ROUND(AVG(debt_usd), 2) AS avg_debt,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY institution_tier
ORDER BY avg_net_roi DESC;

-- 06. Internship impact
SELECT
    had_internship,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(added_earnings_10yr_usd), 2) AS avg_added_earnings,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY had_internship
ORDER BY had_internship DESC;

-- 07. On-time completion impact
SELECT
    completed_on_time,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(net_cost_usd), 2) AS avg_cost,
    ROUND(AVG(debt_usd), 2) AS avg_debt
FROM college_major_roi
GROUP BY completed_on_time
ORDER BY completed_on_time DESC;

-- 08. Region comparison
SELECT
    region,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY region
ORDER BY avg_net_roi DESC;

-- 09. High-ROI graduate profile
SELECT
    major_category,
    institution_tier,
    COUNT(*) AS high_roi_graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(gpa), 2) AS avg_gpa,
    ROUND(AVG(had_internship) * 100, 2) AS internship_rate_pct,
    ROUND(AVG(completed_on_time) * 100, 2) AS on_time_rate_pct
FROM college_major_roi
WHERE high_roi = 1
GROUP BY major_category, institution_tier
ORDER BY high_roi_graduates DESC;

-- 10. Cost-efficiency: ROI per $1 of net cost
SELECT
    major,
    ROUND(AVG(net_roi_usd / NULLIF(net_cost_usd, 0)), 2) AS roi_multiple,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(net_cost_usd), 2) AS avg_cost
FROM college_major_roi
GROUP BY major
ORDER BY roi_multiple DESC;

-- 11. Selectivity bands
SELECT
    CASE
        WHEN institution_selectivity_pctile <= 25 THEN '<=25'
        WHEN institution_selectivity_pctile <= 50 THEN '26-50'
        WHEN institution_selectivity_pctile <= 75 THEN '51-75'
        WHEN institution_selectivity_pctile <= 100 THEN '76-100'
        ELSE '>100'
    END AS selectivity_band,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY selectivity_band
ORDER BY avg_net_roi;

-- 12. Window-function ranking
SELECT
    major,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    RANK() OVER (ORDER BY AVG(net_roi_usd) DESC) AS roi_rank
FROM college_major_roi
GROUP BY major
ORDER BY roi_rank;

-- 13. Internship + completion interaction
SELECT
    had_internship,
    completed_on_time,
    COUNT(*) AS graduates,
    ROUND(AVG(net_roi_usd), 2) AS avg_net_roi,
    ROUND(AVG(positive_roi) * 100, 2) AS positive_roi_rate_pct
FROM college_major_roi
GROUP BY had_internship, completed_on_time
ORDER BY had_internship DESC, completed_on_time DESC;
