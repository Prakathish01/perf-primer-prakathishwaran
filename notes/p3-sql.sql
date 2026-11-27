-- Day P3: SQL practice on temporary tables

CREATE TABLE #Customers (
    CustomerId INT PRIMARY KEY,
    Name NVARCHAR(50),
    City NVARCHAR(50)
);

CREATE TABLE #Orders (
    OrderId INT PRIMARY KEY,
    CustomerId INT,
    Amount DECIMAL(10,2),
    OrderDate DATE
);

INSERT INTO #Customers VALUES 
(1, 'Asha', 'Chennai'),
(2, 'Ben', 'Pune'),
(3, 'Chen', 'Chennai'),
(4, 'Divya', 'Bengaluru');

INSERT INTO #Orders VALUES 
(101, 1, 1200, '2026-10-01'),
(102, 1, 450,  '2026-10-03'),
(103, 2, 980,  '2026-10-03'),
(104, 3, 300,  '2026-10-04'),
(105, 3, 2200, '2026-10-06'),
(106, 3, 150,  '2026-10-07');


-- 1. Orders above 500, largest first
SELECT OrderId, CustomerId, Amount, OrderDate
FROM #Orders
WHERE Amount > 500
ORDER BY Amount DESC;

-- Result:
-- 105 | 3 | 2200.00 | 2026-10-06
-- 101 | 1 | 1200.00 | 2026-10-01
-- 103 | 2 | 980.00  | 2026-10-03


-- 2. Number of orders per customer (GROUP BY, COUNT(*))
SELECT CustomerId, COUNT(*) AS OrderCount
FROM #Orders
GROUP BY CustomerId;

-- Result:
-- Customer 1: 2 orders
-- Customer 2: 1 order
-- Customer 3: 3 orders


-- 3. Total amount per city (JOIN + GROUP BY)
SELECT c.City, SUM(o.Amount) AS TotalAmount
FROM #Customers c
JOIN #Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.City;

-- Result:
-- Chennai: 4300.00
-- Pune: 980.00


-- 4. Customers with no orders (LEFT JOIN ... WHERE o.OrderId IS NULL)
SELECT c.CustomerId, c.Name, c.City
FROM #Customers c
LEFT JOIN #Orders o ON c.CustomerId = o.CustomerId
WHERE o.OrderId IS NULL;

-- Result:
-- 4 | Divya | Bengaluru


-- 5. The top 3 orders (TOP 3 ... ORDER BY)
SELECT TOP 3 OrderId, CustomerId, Amount, OrderDate
FROM #Orders
ORDER BY Amount DESC;

-- Result:
-- 105 | 3 | 2200.00 | 2026-10-06
-- 101 | 1 | 1200.00 | 2026-10-01
-- 103 | 2 | 980.00  | 2026-10-03


-- Self-check: After a load test that adds items to baskets, how would you prove in SQL how many baskets it created?
-- Run: SELECT COUNT(*) FROM Baskets WHERE CreatedAt BETWEEN @TestStartTime AND @TestEndTime;
-- Or: SELECT COUNT(DISTINCT BasketId) FROM BasketItems WHERE CreatedAt BETWEEN @TestStartTime AND @TestEndTime;
-- Then verify this number matches the successful "Add to Basket" request count in JMeter.
