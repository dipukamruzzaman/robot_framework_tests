*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Keywords ***
Create Banking Session
    Create Session    banking    http://127.0.0.1:8000

Register User
    [Arguments]    ${username}    ${password}
    ${body}=    Create Dictionary    username=${username}    password=${password}
    POST On Session    banking    /register    json=${body}

Login User
    [Arguments]    ${username}    ${password}
    ${body}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    POST On Session    banking    /login    json=${body}
    RETURN    ${response}

Create Account
    [Arguments]    ${username}    ${account_name}
    ${body}=    Create Dictionary    username=${username}    account_name=${account_name}
    ${response}=    POST On Session    banking    /accounts/create    json=${body}
    RETURN    ${response}

Initialise Account With Balance
    [Arguments]    ${account}    ${amount}
    ${body}=    Create Dictionary    account=${account}    amount=${amount}
    POST On Session    banking    /accounts/init    json=${body}

Deposit To Account
    [Arguments]    ${account}    ${amount}
    ${body}=    Create Dictionary    account=${account}    amount=${amount}
    ${response}=    POST On Session    banking    /deposit    json=${body}
    RETURN    ${response}

Withdraw From Account
    [Arguments]    ${account}    ${amount}
    ${body}=    Create Dictionary    account=${account}    amount=${amount}
    ${response}=    POST On Session    banking    /withdraw    json=${body}
    RETURN    ${response}

Generate Unique Username
    ${uid}=    Generate Random String    6    [LOWER]
    RETURN    ${uid}

Generate Unique Account
    ${acc}=    Generate Random String    6    [LOWER]
    RETURN    ${acc}

Setup Test Session
    Create Session    banking    http://127.0.0.1:8000

Teardown Test Session
    Delete All Sessions