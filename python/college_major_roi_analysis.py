
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

DATA = "college_major_roi.csv"
df = pd.read_csv(DATA)

# 1) EDA
print("Shape:", df.shape)
print("\nData types:\n", df.dtypes)
print("\nMissing values:\n", df.isna().sum())
print("\nDuplicate IDs:", df["grad_id"].duplicated().sum())
print("\nNumeric summary:\n", df.describe().T)

for col in ["major", "major_category", "institution_tier", "region"]:
    print(f"\n{col}:\n", df[col].value_counts())

# 2) Business KPIs
kpis = {
    "Average Net ROI": df["net_roi_usd"].mean(),
    "Median Net ROI": df["net_roi_usd"].median(),
    "Positive ROI Rate": df["positive_roi"].mean(),
    "High ROI Rate": df["high_roi"].mean(),
    "Average Net Cost": df["net_cost_usd"].mean(),
    "Average Debt": df["debt_usd"].mean(),
    "Average 10-Year Added Earnings": df["added_earnings_10yr_usd"].mean()
}
print("\nKPIs:")
for k, v in kpis.items():
    print(k, "=", v)

# 3) Segment analysis
major_perf = df.groupby("major").agg(
    graduates=("grad_id","size"),
    avg_net_roi=("net_roi_usd","mean"),
    median_net_roi=("net_roi_usd","median"),
    positive_roi_rate=("positive_roi","mean"),
    high_roi_rate=("high_roi","mean")
).sort_values("avg_net_roi", ascending=False)
print("\nMajor performance:\n", major_perf)

# 4) Internship and completion
print("\nInternship impact:\n",
      df.groupby("had_internship")["net_roi_usd"].mean())

print("\nOn-time completion impact:\n",
      df.groupby("completed_on_time")["net_roi_usd"].mean())

# 5) Correlation
print("\nCorrelations with net ROI:\n",
      df.select_dtypes("number").corr()["net_roi_usd"].sort_values(ascending=False))

# 6) Visualizations
fig, ax = plt.subplots()
ax.hist(df["net_roi_usd"], bins=50)
ax.axvline(0, linestyle="--")
ax.set_title("Distribution of 10-Year Net ROI")
ax.set_xlabel("Net ROI (USD)")
ax.set_ylabel("Graduates")
plt.tight_layout()
plt.show()
