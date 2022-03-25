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




























































































































































































































































































TST_F5_0_1_001 Verify logout feature with client_id
    [Documentation]    Owner:sasipen  
    [Tags]    Success    Logout    Ldap_Employee    demosprint4
    Open Browser Login Employee And Open Page Get Token    ${url_aut_logout}
    Set Response On Webpage To Json 
    Get Value From Key Access Token Log Out
    Set Content Header Ldap Logout    ${url_for_logout_ldap_employee}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout With Client Id
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_employee}


TST_F5_0_1_006 To verify logout feature with incorrect client_id
    [Documentation]    Owner:sasipen  
    [Tags]    Success    Logout    Ldap_Employee    On-Hold
    Open Browser Login Employee And Open Page Get Token    ${url_aut_logout}
    Set Response On Webpage To Json 
    Get Value From Key Access Token Log Out
    Set Content Header Ldap Logout    ${url_for_logout_ldap_employee}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout With Invalid Client Id
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_employee}

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
