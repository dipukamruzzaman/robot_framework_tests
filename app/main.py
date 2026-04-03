from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(title="Banking API")

fake_users = {}
fake_accounts = {}
fake_balances = {}

class LoginRequest(BaseModel):
    username: str
    password: str

class AccountRequest(BaseModel):
    username: str
    account_name: str

class TransactionRequest(BaseModel):
    account: str
    amount: float

@app.post("/register")
def register(data: LoginRequest):
    fake_users[data.username] = data.password
    return {"message": f"User {data.username} registered"}

@app.post("/login")
def login(data: LoginRequest):
    if fake_users.get(data.username) != data.password:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return {"token": f"fake-token-{data.username}"}

@app.post("/accounts/create")
def create_account(data: AccountRequest):
    user_accounts = fake_accounts.setdefault(data.username, [])
    if data.account_name in user_accounts:
        raise HTTPException(status_code=400, detail="Account already exists")
    user_accounts.append(data.account_name)
    return {"message": f"Account {data.account_name} created"}

@app.post("/accounts/init")
def init_account(data: TransactionRequest):
    fake_balances[data.account] = data.amount
    return {"balance": fake_balances[data.account]}

@app.post("/deposit")
def deposit(data: TransactionRequest):
    fake_balances.setdefault(data.account, 0)
    fake_balances[data.account] += data.amount
    return {"balance": fake_balances[data.account]}

@app.post("/withdraw")
def withdraw(data: TransactionRequest):
    balance = fake_balances.get(data.account, 0)
    if data.amount > balance:
        raise HTTPException(status_code=400, detail="Insufficient funds")
    fake_balances[data.account] -= data.amount
    return {"balance": fake_balances[data.account]}