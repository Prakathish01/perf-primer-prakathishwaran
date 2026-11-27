# P2.4 - Self-Check Answers

Direct answers to the three self-check questions for Day P2, answered independently without notes.

---

### Question 1 (P2.1 - HTTP & Web)
> *Split `https://localhost:5001/api/catalog-items?pageSize=10` into its parts and say what each one does.*

**Answer**:
- `https`: The scheme / protocol. Tells the client to communicate using secure HTTP encrypted over TLS.
- `localhost`: The host. The domain or IP address of the server (here pointing to the local machine).
- `5001`: The port. The network port number where the backend server process is listening for traffic.
- `/api/catalog-items`: The path. Identifies the specific API endpoint or resource collection on the server.
- `?pageSize=10`: The query string. Passes query parameters (`pageSize` = `10`) to control how many catalog items to return.

---

### Question 2 (P2.2 - Calling APIs with Postman)
> *A request returns 200 OK but the body says `{"error":"not found"}`. Did it pass? What would you check to decide?*

**Answer**:
- At the HTTP transport layer, it technically succeeded because the server received the request and returned a 200 status code.
- At the application / business logic layer, the transaction failed because the requested item wasn't found.
- **What to check to decide**:
  1. Check the API specification contract: Most REST standards dictate returning a `404 Not Found` for missing resources rather than a 200.
  2. Check response body assertions: In automated tests and JMeter load tests, you cannot rely only on HTTP status 200. You must inspect the JSON response body to verify that the payload does not contain an `"error"` field and actually contains the expected data.

---

### Question 3 (P2.3 - Sessions, Cookies, Tokens & DevTools)
> *You log in once and the next request is still recognised. Name two ways the server could know it is you.*

**Answer**:
1. **Via a Session Cookie**: When you log in, the server generates a session ID and sends a `Set-Cookie` header. The browser automatically attaches this cookie (`Cookie: sessionId=...`) to every subsequent request, and the server looks up the user session in its store.
2. **Via a Bearer Token (like JWT)**: When you log in, the server returns a token. The client application stores this token and manually adds it to the `Authorization: Bearer <token>` header on every subsequent request. The server verifies the token signature and reads the user info.
