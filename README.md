![Robot Framework Tests](https://github.com/dipukamruzzaman/robot_framework_tests/actions/workflows/tests.yml/badge.svg)
# Banking API Test Automation — Robot Framework

A test automation project for a Banking REST API built with **Robot Framework** and **FastAPI**. 
Demonstrates keyword-driven testing, test isolation, data-driven testing, and CI/CD integration.

## Tech Stack

| Tool | Purpose |
|---|---|
| Robot Framework 7.x | Test automation framework |
| RequestsLibrary | HTTP API testing |
| FastAPI | Banking API backend |
| Uvicorn | ASGI web server |
| GitHub Actions | CI/CD pipeline |

## Project Structure
```
robot_framework_tests/
│
├── app/
│   └── main.py              # FastAPI banking API
│
├── tests/
│   ├── auth.robot           # Authentication test suite
│   ├── accounts.robot       # Account management test suite
│   └── transactions.robot   # Deposit & withdrawal test suite
│
├── resources/
│   └── keywords.robot       # Shared reusable keywords
│
├── results/                 # Test reports (auto-generated)
├── .github/workflows/       # GitHub Actions CI pipeline
└── requirements.txt         # Project dependencies
```

## Test Suites

| Suite | Tests | Tags |
|---|---|---|
| Authentication | Register & login, invalid credentials | smoke, auth |
| Accounts | Create account, duplicate account error | smoke, accounts |
| Transactions | Deposit, withdrawal, insufficient funds, data-driven deposits | smoke, transactions |

## How To Run

### 1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/robot_framework_tests.git
cd robot_framework_tests
```

### 2. Create and activate virtual environment
```bash
python -m venv venv
venv\Scripts\activate        # Windows
source venv/bin/activate     # Mac/Linux
```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Start the banking API
```bash
uvicorn app.main:app --reload
```

### 5. Run all tests
```bash
python -m robot --outputdir results tests\
```

### 6. Run smoke tests only
```bash
python -m robot --outputdir results --include smoke tests\
```

### 7. View the report
```bash
start results\report.html    # Windows
open results/report.html     # Mac
```

## Key Concepts Demonstrated

- **Keyword-driven testing** — reusable keywords in resources/keywords.robot
- **Test isolation** — unique usernames/accounts per test using random strings
- **Test Setup & Teardown** — clean session management per test
- **Data-driven testing** — Template keyword with multiple data rows
- **Tag-based execution** — run subsets with --include smoke
- **CI/CD** — GitHub Actions runs tests automatically on every push

## Author

Md Kamruzzaman — [LinkedIn](www.linkedin.com/in/md-kamruzzaman-54507149) | [GitHub](https://github.com/dipukamruzzaman)