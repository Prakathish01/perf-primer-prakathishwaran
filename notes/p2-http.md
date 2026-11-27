# P2.1 - How the Web Works and HTTP

Personal notes covering the basics of HTTP, URLs, requests, responses, methods, status codes, data formats, and statelessness.

---

## 1. Client and Server

The web runs on a client-server architecture:
- **Client**: The requester (a web browser, mobile application, CLI tool like curl, or Postman/JMeter). The client initiates an action by sending an HTTP request across the network.
- **Server**: The responder (a web server like Nginx, Apache, or a backend application runtime like Kestrel in ASP.NET Core). The server receives the request, processes it (checking authentication, running business logic, querying databases), and returns an HTTP response back to the client.

---

## 2. Anatomy of a URL

A URL (Uniform Resource Locator) specifies where a resource lives on the web and how to access it.

Example: `https://localhost:5001/api/catalog-items?pageSize=10`

- **Scheme (`https`)**: The protocol used to communicate. HTTPS means HTTP over TLS/SSL (encrypted transport).
- **Host (`localhost`)**: The domain name or IP address of the machine running the server.
- **Port (`5001`)**: The specific networking port the server process is listening on (default for HTTP is 80, HTTPS is 443; custom ports like 5001 are explicitly stated).
- **Path (`/api/catalog-items`)**: The resource path on the server pointing to the specific endpoint or data collection.
- **Query String (`?pageSize=10`)**: Key-value pairs starting after `?` that pass extra parameters to filter, sort, or paginate results without changing the path itself.

---

## 3. The HTTP Request and Response

### An HTTP Request
Sent by the client to tell the server what to do:
1. **Request Line / Method**: The verb (`GET`, `POST`, etc.) and the target path (`/api/items`).
2. **Headers**: Metadata sent as key-value pairs (e.g. `Accept: application/json`, `User-Agent: Chrome`, `Authorization: Bearer <token>`).
3. **Body (Payload)**: Optional data sent to the server (common in `POST` and `PUT` for sending JSON or form data; usually empty in `GET` and `DELETE`).

### An HTTP Response
Returned by the server after processing:
1. **Status Line**: HTTP version, numeric status code, and reason phrase (e.g. `HTTP/1.1 200 OK`).
2. **Headers**: Metadata about the response (e.g. `Content-Type: application/json; charset=utf-8`, `Content-Length: 142`, `Set-Cookie: session=xyz`).
3. **Body (Payload)**: The returned content (HTML for web pages, JSON for APIs, images, or empty for `204 No Content`).

---

## 4. HTTP Methods (CRUD Operations)

- **GET (Read)**:  
  Fetches a resource from the server. Safe and idempotent (calling it multiple times doesn't change server state).  
  *Example*: `GET /posts/1` retrieves post with ID 1.
- **POST (Create)**:  
  Submits new data to the server to create a resource or trigger an action. Not idempotent (submitting twice creates two records).  
  *Example*: `POST /posts` with `{ "title": "New Post", "body": "Content" }` creates a new post with a newly generated ID.
- **PUT (Update / Replace)**:  
  Replaces an existing resource entirely with the provided data. Idempotent.  
  *Example*: `PUT /posts/1` with `{ "id": 1, "title": "Updated", "body": "New body" }` updates post 1.
- **DELETE (Remove)**:  
  Deletes the specified resource. Idempotent (deleting post 1 once or twice leaves post 1 gone).  
  *Example*: `DELETE /posts/1` removes post 1 from the system.

---

## 5. The Five HTTP Status Code Classes

HTTP status codes are grouped into five ranges:

- **1xx (Informational)**: Request received, continuing process.
  - `100 Continue`: Initial part of request received; client should continue sending the rest.
  - `101 Switching Protocols`: Server agrees to switch protocols (e.g. upgrading HTTP to WebSocket).

- **2xx (Success)**: Action was successfully received, understood, and accepted.
  - `200 OK`: Standard success response for `GET`, `PUT`, or `DELETE`.
  - `201 Created`: Request succeeded and a new resource was created (standard response for `POST`).

- **3xx (Redirection)**: Further action needs to be taken by the client to complete the request.
  - `301 Moved Permanently`: The resource has moved to a new permanent URL.
  - `304 Not Modified`: Cached version on client is still valid; no body returned (saves bandwidth).

- **4xx (Client Error)**: The request contains bad syntax or cannot be fulfilled due to client issue.
  - `400 Bad Request`: Server cannot process request due to invalid client syntax (e.g. malformed JSON).
  - `404 Not Found`: Server cannot find the requested resource URL.
  - *(Others worth knowing: `401 Unauthorized` for missing/bad credentials, `403 Forbidden` for insufficient permissions).*

- **5xx (Server Error)**: Server failed to fulfill an apparently valid request.
  - `500 Internal Server Error`: Generic unhandled exception on the server.
  - `503 Service Unavailable`: Server is temporarily overloaded, down for maintenance, or gateway timed out.

---

## 6. JSON vs HTML

| Dimension | JSON (JavaScript Object Notation) | HTML (HyperText Markup Language) |
| :--- | :--- | :--- |
| **Purpose** | Data transport and serialization between APIs and clients | Document structure and visual presentation in a browser |
| **Format** | Lightweight key-value pairs, arrays, strings, numbers | Nested tags with attributes (`<div>`, `<p>`, `<h1>`) |
| **Parsing** | Fast and simple for code (`JSON.parse()`) | Rendered visually by browser layout engine (DOM tree) |
| **Overhead** | Very low payload overhead | Larger payload with layout tags, inline CSS, markup |
| **Typical Use** | REST APIs, microservice data exchange | Web pages meant for human eyes in a browser |

---

## 7. Why HTTP is Called Stateless

HTTP is stateless because each request-response cycle is completely independent. The server does not retain memory of past requests by default. When request #2 arrives, the server has no built-in knowledge that it came from the same client as request #1.

To build interactive applications (like shopping carts or login sessions), state must be managed externally:
1. **Cookies**: Server sets a cookie header; client sends it back on every request.
2. **Tokens**: Client stores a token (e.g. JWT) and sends it in the `Authorization` header with every request.
3. **Session ID in database/cache**: Server stores state keyed by a session ID sent by the client.

---

## 8. Self-Check

**Question**: *Split `https://localhost:5001/api/catalog-items?pageSize=10` into its parts and say what each one does.*

- **`https`**: The scheme / protocol. Dictates encrypted HTTP over TLS.
- **`localhost`**: The host / domain. Specifies the target machine (here, the local computer).
- **`5001`**: The port number. Points to the specific port the application server is listening on.
- **`/api/catalog-items`**: The path. Identifies the specific API endpoint or resource on the server.
- **`?pageSize=10`**: The query string. Passes query parameters (`pageSize` = `10`) to tell the server how many items to return per page.
