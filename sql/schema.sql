
-- College Major ROI Analysis
-- SQLite-compatible schema

DROP TABLE IF EXISTS college_major_roi;

CREATE TABLE college_major_roi (
    grad_id TEXT PRIMARY KEY,
    major TEXT,
    major_category TEXT,
    institution_tier TEXT,
    institution_selectivity_pctile INTEGER,
    gpa REAL,
    had_internship INTEGER,
    completed_on_time INTEGER,
    region TEXT,
    net_cost_usd INTEGER,
    debt_usd INTEGER,
    hs_baseline_10yr_usd INTEGER,
    added_earnings_10yr_usd INTEGER,
    earnings_10yr_usd INTEGER,
    net_roi_usd INTEGER,
    roi_pct REAL,
    positive_roi INTEGER,
    high_roi INTEGER
);

-- Load the CSV using your SQL client/import wizard.
