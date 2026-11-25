# P1.4 - Self-Check Questions

Answers to the three self-check questions for Module 1, answered independently without notes.

---

### Question 1 (Testing Essentials)
> *A login page works for one user but takes 20 seconds when 500 users log in at 09:00. Which kind of testing finds that, and why would functional testing miss it?*

**Answer**:  
Performance testing (specifically Load testing or Concurrency testing) finds this.  
Functional testing would miss it because functional tests check whether the login logic works for a single user in isolation—verifying that valid credentials return a 200 OK and redirect to the dashboard. Because functional tests do not simulate concurrent traffic or load on server resources, they cannot uncover bottlenecks like database connection pool exhaustion, CPU saturation, or thread locking that only occur when 500 requests hit the server at the exact same time.

---

### Question 2 (Command Line Essentials)
> *You type jmeter and get 'not recognized'. What two things do you check?*

**Answer**:  
1. Check if Apache JMeter is actually installed on the computer and that the `jmeter.bat` or executable file exists in its folder on disk.
2. Check if the path to JMeter's `bin` directory is included in the system or user `PATH` environment variable, and verify that the terminal session was restarted after updating the PATH.

---

### Question 3 (Git & GitHub Essentials)
> *What is the difference between a commit and a push, and why does this course say work that is not pushed does not count?*

**Answer**:  
A **commit** saves a snapshot of your staged changes locally in your own computer's Git repository. It creates a savepoint in your local history, but it remains completely on your machine.  
A **push** uploads those committed changes over the network to the remote repository on GitHub, updating the remote branch so others can see and use them.  

The course says "work that is not pushed does not count" because local commits only live on your private machine. Until work is pushed to GitHub, teammates cannot review it, automated CI/CD test pipelines cannot run against it, and the code cannot be built into a release candidate.
