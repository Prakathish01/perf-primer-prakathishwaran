# P1.1 - Software Testing Essentials

## 1. The SDLC and Where Testing Sits

In traditional sequential models like Waterfall, testing was treated as an isolated phase right at the end of the project. Developers wrote code for months, handed it off to QA, and any major architecture flaw or misunderstood requirement discovered at that point was painful and expensive to fix.

In modern agile and DevOps workflows, testing isn't saved for the end. It happens continuously across the entire software development lifecycle:
- Requirements & Planning: QA reviews user stories and specs early to catch ambiguous requirements, missing edge cases, and untestable logic before anyone writes a line of code.
- Development: Testing drives code quality through unit tests, component tests, and test-first approaches like TDD.
- Integration & Build: Automated checks run on every commit or pull request in CI/CD pipelines (unit tests, linting, smoke tests).
- System & Staging: Testers run end-to-end user journeys, regression suites, and non-functional tests (performance, security, usability) in realistic staging environments.
- Production: Quality checks continue through synthetic monitoring, health endpoints, and log alerts to catch live regressions early.

Testing is not a phase you enter at the end; it is a continuous quality feedback loop that runs alongside development from start to finish.

---

## 2. Test Levels

Different test levels target different layers of the application so issues are caught at the right stage without duplicate effort.

- **Unit / Component Testing**:  
  Testing individual units or functions in complete isolation from the rest of the app. Written and executed by developers on their local machines.  
  *Example*: Testing that a discount calculation function correctly calculates 15% off a subtotal and handles zero or negative numbers without throwing an unhandled exception.

- **Component Integration Testing**:  
  Testing the interactions and data exchange between two or more connected modules.  
  *Example*: Verifying that the user authentication service passes a valid token to the profile service and that JSON payloads are serialized and parsed without data loss.

- **System Testing**:  
  Testing the complete, fully integrated application against functional and business requirements in an environment that mirrors production.  
  *Example*: Going through a complete checkout flow on an e-commerce site—logging in, adding items to cart, entering shipping details, completing payment via a gateway sandbox, and confirming the order appears in the database and a confirmation email triggers.

- **Acceptance Testing**:  
  Testing done to demonstrate that the system fulfills the business needs of the users and is safe to release into production. Typically run by product owners, business analysts, or actual end users (UAT, Alpha/Beta testing).  
  *Example*: Finance team members running a full monthly billing cycle in a UAT environment to verify that calculated invoice numbers match the expected legacy accounting records before signing off on deployment.

---

## 3. Functional vs Non-Functional Testing

- **Functional Testing**:  
  Focuses on what the software does—its features, user workflows, business rules, and outputs.  
  - *Example 1*: Verifying that entering a valid username and password logs the user in and redirects them to the user dashboard.  
  - *Example 2*: Verifying that submitting an order form without filling out the required 'Phone Number' field prevents submission and displays an inline error message.

- **Non-Functional Testing**:  
  Focuses on how well the software behaves—its speed, scalability, reliability, security, and usability.  
  - *Example 1 (Performance / Concurrency)*: Testing that the product catalog API returns responses within 300 milliseconds when 800 users browse products at the same time.  
  - *Example 2 (Security)*: Verifying that user passwords stored in the database are properly hashed with salt (not stored in plain text) and that protected API endpoints return HTTP 401 when called without a valid auth token.

---

## 4. Key Testing Terminology

- **Test Case**:  
  A defined set of preconditions, input data, step-by-step actions, and expected results written to verify a specific requirement or feature.
- **Test Data**:  
  The actual data values, database seed records, or mock payloads used to execute a test case (such as valid test accounts, expired credit card numbers, or boundary dates).
- **Test Environment**:  
  The dedicated hardware, software, network setup, and database instances where testing is carried out under controlled, repeatable conditions (e.g. local Docker setups, QA servers, staging environments).
- **Build**:  
  A compiled, packaged, runnable version of the software created from source code at a specific point in time (e.g. a `.jar` package, a `.war` file, or a Docker container image).
- **Release**:  
  A tested build that has been approved and deployed to production or delivered to end users.
- **Version**:  
  The unique identifier or label assigned to a build or release (e.g. `v1.2.0` or a git commit hash) so teams can track changes, monitor deployments, and perform rollbacks if needed.

---

## 5. Defects and Good Defect Reports

A **defect** (commonly referred to as a bug or fault) is a mistake or flaw in a software work product (requirements, code, or configuration) that causes the system to produce an incorrect result or fail in operation.

A good defect report gives developers all the context they need to understand, reproduce, and fix the issue without guessing:
1. **Title**: Short, specific summary of the failure (e.g. "Checkout: Clicking 'Apply Coupon' with lowercase characters returns 500 Internal Server Error").
2. **Environment**: OS, browser and version, application build/version number, device type.
3. **Severity and Priority**: How broken the system is (Critical/Major/Minor) vs how urgently it must be fixed for the release (High/Medium/Low).
4. **Preconditions**: State the system or user account must be in before starting the test (e.g. "User logged in with an empty cart").
5. **Steps to Reproduce**: Clear, numbered steps from start to the point of failure.
6. **Expected Result**: What the application should do based on requirements.
7. **Actual Result**: What the application actually did during execution.
8. **Evidence**: Screenshots, video recordings, network payload details, console logs, or server stack traces.

---

## 6. How a QA Works in a Scrum Team

In a Scrum team, QA is an active participant throughout the entire two-week sprint rather than someone who tests in a silo at the end. During sprint planning and backlog refinement, QA reviews each user story alongside developers and the Product Owner, asking questions about edge cases and helping write clear, testable acceptance criteria. While developers write code, QA creates test cases, sets up test data, and writes automation scripts. When a story is deployed to the test environment, QA tests it against the acceptance criteria, runs exploratory tests, and logs bugs if anything fails. A user story is only considered complete when it satisfies the team's shared Definition of Done—meaning code is reviewed, unit and integration tests pass, acceptance criteria are verified, no critical defects remain, and documentation is updated. Once all committed stories meet the Definition of Done, the sprint build is ready for a stable release.

---

## 7. Where Performance Testing Fits

Functional testing tells you if an application works correctly for a single user under normal conditions. It verifies that inputs produce the right outputs and buttons do what they are supposed to do. But functional testing cannot tell you what happens when real-world traffic hits the server.

Performance testing fits right where functional testing leaves off by answering questions like:
- How does page response time behave when traffic increases from 1 user to 500 concurrent users?
- At what user load does the database connection pool run out or the server CPU hit 100%?
- Does the application leak memory over an 8-hour period, eventually causing the server to crash?
- Can the server recover automatically after a sudden burst of traffic, or does it stay unresponsive?
- Which specific API call or database query is the primary bottleneck slowing down the whole system?

Performance testing ensures that an application is not only functionally correct, but also fast, reliable, and scalable under production load.
