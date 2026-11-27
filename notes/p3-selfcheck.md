# P3 Self-Check Answers & Week 0 Readiness Review

---

## Part 1: Day P3 Task Self-Checks

### Question 1 (P3.1 SQL Essentials)
> *After a load test that adds items to baskets, how would you prove in SQL how many baskets it created?*

**Answer**:
1. Query the primary basket table filtered to the exact start and end timestamps of the load test run:
   ```sql
   SELECT COUNT(*) AS BasketsCreated 
   FROM Baskets 
   WHERE CreatedAt >= @TestStartTime AND CreatedAt <= @TestEndTime;
   ```
2. Or count unique baskets from the basket items table:
   ```sql
   SELECT COUNT(DISTINCT BasketId) AS UniqueBaskets 
   FROM BasketItems 
   WHERE CreatedAt BETWEEN @TestStartTime AND @TestEndTime;
   ```
3. Reconcile this database count against JMeter results: the number of created baskets in SQL must match the count of successful HTTP 200/201 responses for the "Add to Basket" sampler.

---

### Question 2 (P3.2 Python Essentials)
> *What does `df.groupby('label')['elapsed'].quantile(0.95)` return?*

**Answer**:  
It groups the dataset by the transaction name/sampler label (e.g., `01_Login`, `02_Search`, `03_Checkout`), isolates the `elapsed` response time column for each distinct label, and calculates the **95th percentile (p95)** response time for each transaction. In other words, for every transaction type, 95% of users experienced a response time at or below the returned value.

---

### Question 3 (P3.3 Performance Math)
> *Why do performance reports use p95 rather than the average?*

**Answer**:  
Averages are easily distorted by extreme outliers and long tail latencies. If 95% of users experience a fast 200 ms response time but 5% wait 20 seconds, the mathematical average drags out to several seconds, making healthy traffic look bad while simultaneously masking how severe the 20-second stall was. The **95th percentile (p95)** represents what 95% of real users experienced under actual load, providing an honest, reproducible benchmark for SLAs while ignoring the top 5% transient network anomalies.

---

## Part 2: Week 0 Readiness Self-Check (P3.4)

Completed without notes to verify readiness for Main Course Day 1.

### 1. Functional vs. Non-Functional Testing
- **Functional Testing**: Verifies *what* the system does (features, business rules, inputs/outputs).  
  *Example*: Verifying that submitting valid credentials on `/login` returns HTTP 200 and redirects to the account dashboard.
- **Non-Functional Testing**: Verifies *how well* the system performs (speed, scalability, security, reliability).  
  *Example*: Verifying that the `/catalog` search API responds in under 400 ms when 500 users search at the same time.

### 2. Calling GET & POST JSON and Reading Responses
- **GET**: Sends a request to fetch data (e.g. `GET https://jsonplaceholder.typicode.com/posts/1`). We read the HTTP status (`200 OK`), response headers (`Content-Type: application/json`), response time (`~500 ms`), and the JSON body.
- **POST**: Sends a request with a JSON body (e.g. `POST https://jsonplaceholder.typicode.com/posts` with `Content-Type: application/json` and body `{"title": "test", "userId": 1}`). We inspect status code (`201 Created`), the returned ID (`id: 101`), and server headers.

### 3. Core HTTP Status Codes
- `200 OK`: Standard success response for retrieving or updating resources.
- `201 Created`: Resource was successfully created on the server (typical for POST).
- `400 Bad Request`: Client sent malformed syntax, invalid JSON, or missing required fields.
- `401 Unauthorized`: Authentication is missing or invalid (no valid token/credentials provided).
- `403 Forbidden`: Authenticated client does not have permission to access the resource.
- `404 Not Found`: The requested URL or resource does not exist on the server.
- `500 Internal Server Error`: An unhandled exception or crash occurred in server code.

### 4. Cookies vs. Bearer Tokens
- **Cookie**: Transmitted via the `Set-Cookie` header from server to client. The browser stores it and automatically attaches `Cookie: name=value` to every subsequent request to that domain without manual code.
- **Bearer Token**: Returned in the response body or auth payload upon login. The client must store it (e.g. in memory/storage) and explicitly add it to the `Authorization: Bearer <token>` header on every single outgoing request.

### 5. SQL SELECT with WHERE, GROUP BY, COUNT(*), and 2-Table JOIN
```sql
SELECT c.City, COUNT(*) AS TotalOrders, SUM(o.Amount) AS Revenue
FROM Customers c
JOIN Orders o ON c.CustomerId = o.CustomerId
WHERE o.OrderDate >= '2026-01-01'
GROUP BY c.City
ORDER BY Revenue DESC;
```
- `JOIN`: Links rows from `Customers` and `Orders` on matching `CustomerId`.
- `WHERE`: Filters orders placed on or after Jan 1, 2026.
- `GROUP BY`: Aggregates the results by city.
- `COUNT(*)`: Calculates the number of orders per city.

### 6. Core Git Workflow
- `git clone <url>`: Downloads the remote repository to the local machine.
- `git checkout -b feature/test-branch`: Creates and switches to a new feature branch.
- `git add <files>`: Stages modified files for commit.
- `git commit -m "feat: description"`: Saves a permanent snapshot of staged changes in the local repository history.
- `git push -u origin feature/test-branch`: Uploads local commits over the network to GitHub.

### 7. Terminal Navigation, Environment Variables & Arguments
- Navigation: `pwd` (print working directory), `dir` (list files), `cd folder` (change directory).
- Setting environment variable:
  - PowerShell: `$env:MY_VAR = "training"`
  - cmd: `set MY_VAR=training`
- Running program with arguments/flags:
  `python tools/hello_args.py notes/p3-sql.sql`

### 8. Python Reading CSV and Printing Mean & p90
```python
import pandas as pd

df = pd.read_csv("tools/sample_data.csv")
mean_val = df["amount"].mean()
p90_val = df["amount"].quantile(0.90)

print(f"Mean amount: {mean_val:.2f}")
print(f"90th percentile (p90): {p90_val:.2f}")
```
- Reads the CSV file into a DataFrame.
- Calculates the mathematical average with `.mean()`.
- Calculates the 90th percentile with `.quantile(0.90)`.
