import argparse

parser = argparse.ArgumentParser(description="Count lines in a file")
parser.add_argument("filename", help="Path to file")
args = parser.parse_args()

with open(args.filename, "r", encoding="utf-8", errors="ignore") as f:
    count = sum(1 for _ in f)

print(f"{args.filename} has {count} lines")
