*** Settings ***
Resource    ${CURDIR}${/}..${/}resources${/}keywords.robot
Test Setup      Setup Test Session
Test Teardown   Teardown Test Session

*** Test Cases ***
Create Account Successfully
    [Tags]    smoke    accounts
    ${username}=    Generate Unique Username
    Register User    ${username}    pass123
    ${response}=    Create Account    ${username}    Savings
    Should Be Equal As Integers    ${response.status_code}    200
    ${msg}=    Get From Dictionary    ${response.json()}    message
    Should Contain    ${msg}    Savings

Cannot Create Duplicate Account
    [Tags]    accounts
    ${username}=    Generate Unique Username
    Register User    ${username}    pass123
    Create Account    ${username}    Checking
    ${body}=    Create Dictionary    username=${username}    account_name=Checking
    ${response}=    POST On Session    banking    /accounts/create
    ...    json=${body}    expected_status=400
    Should Be Equal As Integers    ${response.status_code}    400
    ${detail}=    Get From Dictionary    ${response.json()}    detail
    Should Be Equal    ${detail}    Account already exists