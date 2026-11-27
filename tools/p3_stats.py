import random
import pandas as pd
import matplotlib.pyplot as plt

random.seed(7)

# 1. 10 outliers
times_10 = [random.gauss(300, 40) for _ in range(990)] + [random.uniform(1500, 3000) for _ in range(10)]
s_10 = pd.Series(times_10)

print("--- 10 Outliers ---")
for name, val in [("avg", s_10.mean()), ("median", s_10.median()), ("p90", s_10.quantile(0.90)), 
                  ("p95", s_10.quantile(0.95)), ("p99", s_10.quantile(0.99)), ("max", s_10.max())]:
    print(f"{name:>6}: {val:8.1f} ms")

# 2. 60 outliers
random.seed(7)
times_60 = [random.gauss(300, 40) for _ in range(940)] + [random.uniform(1500, 3000) for _ in range(60)]
s_60 = pd.Series(times_60)

print("\n--- 60 Outliers ---")
for name, val in [("avg", s_60.mean()), ("median", s_60.median()), ("p90", s_60.quantile(0.90)), 
                  ("p95", s_60.quantile(0.95)), ("p99", s_60.quantile(0.99)), ("max", s_60.max())]:
    print(f"{name:>6}: {val:8.1f} ms")

# 3. Save histogram plot
plt.figure(figsize=(9, 5))
plt.hist(s_10, bins=50, edgecolor="black", alpha=0.7)
plt.axvline(s_10.mean(), color="red", linestyle="--", label=f"Average ({s_10.mean():.1f} ms)")
plt.axvline(s_10.median(), color="green", linestyle="-", label=f"Median ({s_10.median():.1f} ms)")
plt.axvline(s_10.quantile(0.95), color="orange", linestyle="-.", label=f"p95 ({s_10.quantile(0.95):.1f} ms)")

plt.title("Response Time Distribution (1,000 requests, 10 outliers)")
plt.xlabel("Response Time (ms)")
plt.ylabel("Count")
plt.legend()
plt.tight_layout()
plt.savefig("notes/p3-histogram.png", dpi=150)
print("\nHistogram saved to notes/p3-histogram.png")
