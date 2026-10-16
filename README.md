# College Major ROI — Deep Dive Data Analysis

## 1. Project Overview

This project analyzes the economic return of different college majors using a 30,000-record graduate-level dataset. The analysis combines **Python EDA**, **business-focused statistical analysis**, **SQL segmentation and ranking**, and **visual analytics**.

The goal is to answer practical questions such as:

- Which majors generate the strongest 10-year net ROI?
- Which major categories are financially attractive?
- How do institution tiers affect ROI?
- Is internship experience associated with better ROI?
- Does graduating on time matter financially?
- How do cost, debt, selectivity and earnings relate to ROI?
- Which segments are high-risk or low-return?

> **Important:** ROI is defined by the supplied data dictionary as `added_earnings_10yr_usd - net_cost_usd`. This is an observational dataset, so relationships should not automatically be interpreted as causal.


## 2. Dataset

- **Rows:** 30,000
- **Original columns:** 18
- **Unique graduate IDs:** 30,000
- **Missing values:** 0
- **Duplicate graduate IDs:** 0
- **Majors:** 19
- **Major categories:** 7
- **Institution tiers:** 5
- **Regions:** 4

### Key fields

| Field | Business meaning |
|---|---|
| `major` | Specific degree major |
| `major_category` | STEM, health, business, social science, education, humanities, arts |
| `institution_tier` | Ivy elite, top public, mid-tier, regional, for-profit |
| `gpa` | Undergraduate GPA |
| `had_internship` | 1 if the graduate completed at least one internship |
| `completed_on_time` | 1 if the degree was completed on schedule |
| `net_cost_usd` | Net degree cost after aid |
| `debt_usd` | Student debt |
| `added_earnings_10yr_usd` | 10-year earnings above the high-school counterfactual |
| `net_roi_usd` | Added 10-year earnings minus net cost |
| `roi_pct` | ROI as a percentage of net cost |
| `positive_roi` | 1 if net ROI > 0 |
| `high_roi` | 1 if ROI is in the top quartile |

The complete supplied data dictionary is retained as `data_dictionary (6).csv`.


## 3. Analytical Approach

### Phase 1 — Python EDA
1. Data shape and schema validation
2. Data type inspection
3. Missing-value analysis
4. Duplicate-key validation
5. Descriptive statistics
6. Categorical distributions
7. ROI distribution and outlier review

### Phase 2 — Business Analysis
1. Executive ROI KPIs
2. Major-level ranking
3. Major-category comparison
4. Institution-tier analysis
5. Internship impact
6. On-time completion impact
7. Regional comparison
8. Selectivity analysis
9. Cost/debt/earnings relationships
10. High-ROI segment profiling

### Phase 3 — SQL
The SQL layer includes:
- KPI aggregation
- `GROUP BY` and `HAVING`
- segment comparison
- ROI ranking
- window functions
- selectivity bands
- internship/completion interaction
- cost-efficiency analysis


## 4. Executive Findings

### Overall economics
- Average 10-year net ROI: **$266,854**
- Median 10-year net ROI: **$198,100**
- Positive ROI rate: **83.5%**
- High ROI rate: **25.0%**
- Average net cost: **$88,621**
- Average debt: **$38,498**
- Average 10-year added earnings: **$355,475**

### Major performance
- Highest average ROI major: **Electrical Engineering** at **$600,365**
- Lowest average ROI major: **Fine Arts** at **$-39,821**

### Major-category performance
- Best category: **Stem** at **$447,000**
- Lowest category: **Arts** at **$-39,821**

### Institution tier
- Highest average ROI: **Ivy Elite** at **$380,610**
- Lowest average ROI: **For Profit** at **$102,770**

### Internship
Graduates with an internship show an average ROI advantage of approximately **$92,090** versus graduates without an internship.

### On-time graduation
Graduates completing on time show an average ROI advantage of approximately **$63,399** versus those who did not complete on time.


## 5. Key Business Insights

### Insight 1 — Major selection is the strongest practical segmentation lever
ROI varies substantially across majors. Engineering, analytics, computer science and related quantitative programs dominate the upper end of the ROI distribution, while several arts/humanities-oriented programs have much lower average financial returns in this dataset.

**Business implication:** Education decision-makers should present expected earnings and total cost together rather than evaluating a degree using tuition alone.

### Insight 2 — STEM has a strong financial advantage in this dataset
STEM has the highest average net ROI among major categories and a very high positive-ROI rate.

**Business implication:** Career-oriented advising can prioritize high-demand quantitative pathways when financial return is an explicit objective.

### Insight 3 — Institution tier matters, but cost matters too
The highest-tier institutions show strong average ROI, but they also carry materially higher average net cost and debt. This means institutional prestige should be evaluated alongside price and financing.

**Business implication:** A lower-cost institution can still be financially attractive if it preserves the earnings premium.

### Insight 4 — Internship experience is associated with higher ROI
The internship group has materially higher average ROI and added earnings.

**Business implication:** Internships should be treated as an employability and ROI lever, not simply an extracurricular activity.

### Insight 5 — Completing on time has a meaningful financial association
On-time graduates have higher average ROI and lower average cost/debt in this dataset.

**Business implication:** Institutions can potentially improve graduate economics through retention, academic support and timely completion initiatives.

### Insight 6 — ROI is highly earnings-driven
The strongest numerical relationships with `net_roi_usd` are the earnings variables because net ROI is mathematically constructed from added earnings and cost.

**Business implication:** When modeling ROI, avoid treating these mechanically derived fields as independent predictors. For predictive modeling, use upstream drivers instead.


## 6. Recommended Business Actions

1. **Build a major-level ROI scorecard** combining expected earnings, cost, debt and positive-ROI probability.
2. **Expand internship access** through employer partnerships and structured placement programs.
3. **Track on-time completion** as a financial outcome, not only an academic KPI.
4. **Compare institution options using net cost and ROI together**, rather than prestige alone.
5. **Flag low-ROI pathways** for additional counseling around debt, expected earnings and alternative career routes.
6. **Segment ROI by major × institution tier** before making student-level recommendations.
7. **Add sensitivity analysis** in a future version to test changes in cost, debt and earnings assumptions.


## 7. Visualizations

The `visualizations/` folder contains:

1. `01_roi_distribution.png` — overall ROI distribution
2. `02_roi_by_major.png` — major ranking
3. `03_roi_by_category.png` — category comparison
4. `04_roi_by_institution_tier.png` — institution tier comparison
5. `05_internship_roi_lift.png` — internship ROI association
6. `06_on_time_roi_lift.png` — completion ROI association
7. `07_cost_vs_roi.png` — cost/ROI relationship
8. `08_selectivity_vs_roi.png` — selectivity/ROI relationship

## 9. Tools Used

- **Python:** pandas, NumPy, Matplotlib
- **SQL:** aggregation, filtering, `HAVING`, window functions, segmentation
- **Visualization:** Matplotlib


## 10. Conclusion

The analysis shows that the financial value of a college degree is highly heterogeneous. **Major choice, earnings potential, internship exposure and timely completion are strongly associated with differences in 10-year net ROI.** STEM and quantitative majors are especially strong in this dataset, while several arts/humanities pathways show materially weaker financial returns.

The most important strategic conclusion is that **college ROI should be evaluated as a combined cost + earnings + completion + career-experience problem**. A high-prestige institution is not automatically the optimal financial choice if its additional cost and debt outweigh the incremental earnings benefit.

For a portfolio-ready analyst project, the next enhancement would be a **Power BI executive dashboard** with slicers for major, category, institution tier and region, plus KPI cards for average ROI, positive ROI rate, cost, debt and 10-year added earnings.
