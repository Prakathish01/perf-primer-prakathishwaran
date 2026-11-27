# P2.2 - Calling APIs with Postman

Notes on manual API requests sent to the JSONPlaceholder practice API, including environment variables, recorded response data, and test assertions.

---

## 1. Setup

- Set up an environment variable: `baseUrl = https://jsonplaceholder.typicode.com`.
- Structured all requests in Postman using the pattern: `{{baseUrl}}/posts`.
- Single manual requests only (no loops or load tests against public APIs).

---

## 2. API Call Records (JSONPlaceholder)

### Call 1: `GET {{baseUrl}}/posts`
- **Method & URL**: `GET https://jsonplaceholder.typicode.com/posts`
- **Status Code**: `200 OK`
- **Two Response Headers**:
  - `Content-Type: application/json; charset=utf-8`
  - `X-Powered-By: Express`
- **Response Body**: Array of 100 JSON post objects (from `id: 1` to `id: 100`).
- **Response Time**: `442 ms`

---

### Call 2: `GET {{baseUrl}}/posts/1`
- **Method & URL**: `GET https://jsonplaceholder.typicode.com/posts/1`
- **Status Code**: `200 OK`
- **Two Response Headers**:
  - `Content-Type: application/json; charset=utf-8`
  - `Date: Thu, 26 Nov 2026 09:30:53 GMT`
- **Response Body**: Single JSON post object:
  ```json
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit..."
  }
  ```
- **Response Time**: `599 ms`

---

### Call 3: `GET {{baseUrl}}/posts?userId=1`
- **Method & URL**: `GET https://jsonplaceholder.typicode.com/posts?userId=1`
- **Status Code**: `200 OK`
- **Two Response Headers**:
  - `Content-Type: application/json; charset=utf-8`
  - `X-Powered-By: Express`
- **Response Body**: Array of 10 JSON post objects all belonging to `userId: 1` (`id: 1` to `id: 10`).
- **Response Time**: `633 ms`

---

### Call 4: `POST {{baseUrl}}/posts`
- **Method & URL**: `POST https://jsonplaceholder.typicode.com/posts`
- **Request Body**:
  ```json
  {
    "title": "foo",
    "body": "bar",
    "userId": 1
  }
  ```
- **Status Code**: `201 Created`
- **Two Response Headers**:
  - `Content-Type: application/json; charset=utf-8`
  - `X-Powered-By: Express`
- **Response Body**:
  ```json
  {
    "title": "foo",
    "body": "bar",
    "userId": 1,
    "id": 101
  }
  ```
- **Response Time**: `452 ms`

---

### Call 5: `PUT {{baseUrl}}/posts/1`
- **Method & URL**: `PUT https://jsonplaceholder.typicode.com/posts/1`
- **Request Body**:
  ```json
  {
    "id": 1,
    "title": "updated title",
    "body": "updated body",
    "userId": 1
  }
  ```
- **Status Code**: `200 OK`
- **Two Response Headers**:
  - `Content-Type: application/json; charset=utf-8`
  - `X-Powered-By: Express`
- **Response Body**:
  ```json
  {
    "id": 1,
    "title": "updated title",
    "body": "updated body",
    "userId": 1
  }
  ```
- **Response Time**: `1052 ms`

---

### Call 6: `DELETE {{baseUrl}}/posts/1`
- **Method & URL**: `DELETE https://jsonplaceholder.typicode.com/posts/1`
- **Status Code**: `200 OK`
- **Two Response Headers**:
  - `Content-Type: application/json; charset=utf-8`
  - `X-Powered-By: Express`
- **Response Body**: `{}`
- **Response Time**: `973 ms`

---

## 3. Test Assertion Practice

In the Scripts (Tests) tab of `GET /posts/1`, added the test:
```javascript
pm.test("status is 200", () => pm.response.to.have.status(200));
```

- **Forced Failure Experiment**:
  Changed the assertion to expect `201`:
  ```javascript
  pm.test("status is 200", () => pm.response.to.have.status(201));
  ```
  **Result**: Test failed with `AssertionError: expected response to have status code 201 but got 200`.
- **Fixed**: Restored expected status to `200`. The test passed (green indicator).

**Connection to JMeter**:  
This is the exact concept JMeter calls a **Response Assertion**. In load testing, checking the status code and response payload with assertions is necessary because an endpoint might return an HTTP 200 even while returning an internal error page or empty data.

---

## 4. Collection Export

Saved all 6 requests into collection `Day P2 - JSONPlaceholder Practice` and exported as:
`notes/p2-postman.json`

---

## 5. Self-Check

**Question**: *A request returns 200 OK but the body says `{"error":"not found"}`. Did it pass? What would you check to decide?*

**Answer**:  
At the HTTP network transport level, the request succeeded (the web server received the request and returned a valid HTTP 200). But at the application/business logic level, it failed—the expected item wasn't found.  

To decide whether it passed:
1. Check the API specification / contract: If the API requires returning `404 Not Found` for missing resources, returning 200 with an error object violates the contract.
2. Check the response body content: In test scripts and JMeter assertions, you cannot check status code alone; you must assert on specific JSON fields or ensure the body does not contain an `"error"` key. A test that only checks `status == 200` would log a false positive pass here.

---
