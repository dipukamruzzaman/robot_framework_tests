*** Settings ***
Resource    ${CURDIR}${/}..${/}resources${/}keywords.robot
Test Setup      Setup Test Session
Test Teardown   Teardown Test Session

*** Test Cases ***
Register And Login Successfully
    [Tags]    smoke    auth
    ${username}=    Generate Unique Username
    Register User    ${username}    secret123
    ${response}=    Login User    ${username}    secret123
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token

Login With Wrong Password Should Fail
    [Tags]    smoke    auth
    ${username}=    Generate Unique Username
    Register User    ${username}    secret123
    ${body}=    Create Dictionary    username=${username}    password=wrongpass
    ${response}=    POST On Session    banking    /login
    ...    json=${body}    expected_status=401
    Should Be Equal As Integers    ${response.status_code}    401