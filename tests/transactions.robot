*** Settings ***
Resource    ${CURDIR}${/}..${/}resources${/}keywords.robot
Test Setup      Setup Test Session
Test Teardown   Teardown Test Session

*** Test Cases ***
Deposit Money Successfully
    [Tags]    smoke    transactions
    ${acc}=    Generate Unique Account
    Initialise Account With Balance    ${acc}    ${0}
    ${response}=    Deposit To Account    ${acc}    ${500}
    Should Be Equal As Integers    ${response.status_code}    200
    ${balance}=    Get From Dictionary    ${response.json()}    balance
    Should Be Equal As Numbers    ${balance}    500

Withdraw Money Successfully
    [Tags]    smoke    transactions
    ${acc}=    Generate Unique Account
    Initialise Account With Balance    ${acc}    ${1000}
    ${response}=    Withdraw From Account    ${acc}    ${200}
    Should Be Equal As Integers    ${response.status_code}    200
    ${balance}=    Get From Dictionary    ${response.json()}    balance
    Should Be Equal As Numbers    ${balance}    800

Cannot Withdraw More Than Balance
    [Tags]    transactions
    ${acc}=    Generate Unique Account
    Initialise Account With Balance    ${acc}    ${100}
    ${body}=    Create Dictionary    account=${acc}    amount=${500}
    ${response}=    POST On Session    banking    /withdraw
    ...    json=${body}    expected_status=400
    Should Be Equal As Integers    ${response.status_code}    400
    ${detail}=    Get From Dictionary    ${response.json()}    detail
    Should Be Equal    ${detail}    Insufficient funds

Deposit Various Amounts
    [Tags]    smoke    transactions    template
    [Template]    Verify Deposit Balance
    ${200}    ${200}
    ${500}    ${500}
    ${1000}    ${1000}

*** Keywords ***
Verify Deposit Balance
    [Arguments]    ${amount}    ${expected}
    ${acc}=    Generate Unique Account
    Initialise Account With Balance    ${acc}    ${0}
    ${response}=    Deposit To Account    ${acc}    ${amount}
    ${balance}=    Get From Dictionary    ${response.json()}    balance
    Should Be Equal As Numbers    ${balance}    ${expected}