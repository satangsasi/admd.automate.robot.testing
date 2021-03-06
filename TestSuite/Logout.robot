*** Settings ***
Resource    ./Resource_init.robot
Suite Setup      Keyword Suite Setup
Test Teardown     Run Keyword And Ignore Error    Keyword Test Teardown
Suite Teardown    Run Keyword And Ignore Error    Keyword Suite Teardown


*** Test Cases ***
TST_F5_1_1_001 Verify Logout with Ldap Employee
    [Documentation]    Owner: Nakarin
    ...    AIS Team remove this test case
    [Tags]    Success    On-Hold

TST_F5_1_1_002 Verify Logout with Ldap Content provider
    [Documentation]    Owner: Nakarin
    ...    AIS Team remove this test case
    [Tags]    Success    On-Hold

TST_F5_1_1_003 Verify Logout with SSO Ldap Employee
    [Documentation]    Owner: Nakarin
    ...    AIS Team remove this test case
    [Tags]    Success    On-Hold

TST_F5_0_1_001 Verify logout feature with client_id
    [Documentation]    Owner:sasipen  
    [Tags]    Success    Logout    Ldap_Employee    action_delay    SmokeTest
    Open Browser Login Employee And Open Page Get Token    ${url_auth_logout}
    Set Response On Webpage To Json 
    Get Value From Key Access Token Log Out
    Set Content Header Ldap Logout    ${url_for_logout_ldap_employee}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout With Client Id
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_employee}

TST_F5_0_1_002 To verify logout feature with incorrect client_id
    [Documentation]    Owner:sasipen  
    ...    *** On-Hold**
    ...    ควรเป็นเทส fail เนื่องจาก incorrect client_id แต่เทสแลว pass  
    [Tags]    Success    Logout    Ldap_Employee    action_delay    On-Hold
    Open Browser Login Employee And Open Page Get Token    ${url_auth_logout}
    Set Response On Webpage To Json 
    Get Value From Key Access Token Log Out
    Set Content Header Ldap Logout    ${url_for_logout_ldap_employee}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout With Invalid Client Id
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_employee}

TST_F5_0_1_001 To verify logout feature with expired access token
    [Documentation]    Owner: Atitaya
    [Tags]      Fail    Logout    action_delay
    Create Browser Session      ${url_auth_logout}       
    Fill Username And Password Login Page 
    Press Login Button In Page
    Create URL For Get Token    ${url_get_token_schema} 
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Logout
    Set API Body Logout Expired Access Token
    Send Post Request Logout        200
    Get Json Error Log Logout From Server
    Verify Json Error Log Logout From Server  
    Verify Response Logout Expired Access Token

TST_F5_0_1_002 To verify logout feature with incorrect access token
    [Documentation]    Owner: Atitaya
    [Tags]      Fail    Logout    action_delay
    Create Browser Session      ${url_auth_logout}       
    Fill Username And Password Login Page 
    Press Login Button In Page
    Create URL For Get Token    ${url_get_token_schema} 
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Logout
    Set API Body Logout Incorrect Access Token
    Send Post Request Logout        400
    Verify Response Logout Incorrect Access Token

TST_F5_0_1_003 To verify logout feature with missing access token    
    [Documentation]    Owner: Atitaya
    [Tags]      Fail    Logout    action_delay
    Create Browser Session      ${url_auth_logout}       
    Fill Username And Password Login Page 
    Press Login Button In Page
    Create URL For Get Token    ${url_get_token_schema} 
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Logout
    Set API Body Logout Missing Access Token
    Send Post Request Logout        400
    Verify Response Logout Missing Access Token

TST_F5_0_1_004 To verify logout feature with Unknow URL    
    [Documentation]    Owner: Atitaya
    [Tags]      Fail    Logout    action_delay
    Create Browser Session      ${url_auth_logout}       
    Fill Username And Password Login Page 
    Press Login Button In Page
    Create URL For Get Token    ${url_get_token_schema} 
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Logout Invalid URL
    Set API Body Logout Invalid URL
    Send Post Request Logout        400
    Verify Response Logout Feature With Unknow URL 
