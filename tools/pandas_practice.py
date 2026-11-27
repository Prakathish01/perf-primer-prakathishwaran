import sys
import pandas as pd

csv_file = sys.argv[1] if len(sys.argv) > 1 else "tools/sample_data.csv"
df = pd.read_csv(csv_file)

print("Data:")
print(df)

print("\nMean amount per city:")
print(df.groupby("city")["amount"].mean())
