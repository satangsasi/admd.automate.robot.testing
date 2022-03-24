*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Keyword Test Teardown

*** Test Cases ***
TST_F5_1_1_001 Verify Logout with Ldap Employee
    [Documentation]    Owner: Nakarin
    [Tags]    Success    On-Hold

TST_F5_1_1_002 Verify Logout with Ldap Content provider
    [Documentation]    Owner: Nakarin
    [Tags]    Success    On-Hold

TST_F5_1_1_003 Verify Logout with SSO Ldap Employee
    [Documentation]    Owner: Nakarin
    [Tags]    Success    On-Hold

TST_F5_1_1_004 Verify Logout with SSO Ldap Content provider
    [Documentation]    Owner:
    [Tags]    Success    On-Hold

TST_F5_0_1_005 Verify logout feature with client_id
    [Documentation]    Owner:
    [Tags]    Success    On-Hold

TST_F5_0_1_006 To verify logout feature with incorrect client_id
    [Documentation]    Owner:
    [Tags]    Success    On-Hold

TST_F5_0_1_001 To verify logout feature with expired access token
    [Documentation]    Owner:
    [Tags]    Fail    On-Hold

TST_F5_0_1_002 To verify logout feature with incorrect access token
    [Documentation]    Owner:
    [Tags]    Fail    On-Hold

TST_F5_0_1_003 To verify logout feature with missing access token
    [Documentation]    Owner:
    [Tags]    Fail    On-Hold

TST_F5_0_1_004 To verify logout feature with Unknow URL
    [Documentation]    Owner:
    [Tags]    Fail    On-Hold
