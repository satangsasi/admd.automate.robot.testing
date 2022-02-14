*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Append To Document Teardown


*** Test Cases ***
TST_F10_1_1_001 LDAP all OU Verlify login Ldap Content provider partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    [Tags]    Content_Provider    demo
    Create Browser Session        ${url_auth_ldap_${test_site}}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button
    Create URL For Get Token
    New Page                      ${URL_GET_TOKEN}
    Set Data Response Ldap For Verify                 
    Verify Response Ldap
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Content Provider
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key ID Token      login    Content Provider
    
TST_F10_1_1_002 Verlify sso Ldap Content provider partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    [Tags]    Content_Provider     demo
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_${test_site}}
    New Page                 ${url_auth_ldap_${test_site}}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso    Content Provider
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key ID Token        sso    Content Provider
        
TST_F10_1_1_003 Verify Refresh Token with login Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider    demo
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_scope_profile}
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Content Provider
    Create URL For Get Refresh Token  
    New Page                                      ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Content Provider    
    Decode Refresh Token To Jwt By Key Id Token
    Verify Response Decode Refresh Token By Key ID Token        Content Provider
    
TST_F10_1_1_004 Verify Refresh Token with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile 
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider    demo
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_scope_profile}
    New Page                                      ${url_auth_ldap_scope_profile}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso    Content Provider
    Create URL For Get Refresh Token  
    New Page                 ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Content Provider    
    Decode Refresh Token To Jwt By Key Id Token
    Verify Response Decode Refresh Token By Key ID Token        Content Provider

TST_F10_1_1_005 Verify Refresh Token with login Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider    demo
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_no_scope_profile}
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Content Provider
    Create URL For Get Refresh Token  
    New Page    ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap No Scope Profile
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Content Provider  
TST_F10_1_1_006 Verify Refresh Token with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider    demo 
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_no_scope_profile}
    New Page                                      ${url_auth_ldap_no_scope_profile}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso    Content Provider
    Create URL For Get Refresh Token
    New Page                 ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap No Scope Profile
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Content Provider  

TST_F10_1_1_007 Verify Decrypted PID ldap Content provider snake case
    [Tags]    On-Hold

TST_F10_1_1_008 Verify Decrypted PID ldap Content provider camel case
    [Tags]    On-Hold

TST_F10_1_1_009 Verify Logout with Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    [Tags]    Content_Provider    demo
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_${test_site}}
    Set Response On Webpage To Json
    Get Value From Key Access Token
    Set Content Header Ldap Logout    ${url_ldap_logout_${test_site}}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp}  
    Send Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp}
    
TST_F10_1_1_010 Verify Logout with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    [Tags]    Content_Provider    demo
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_${test_site}}
    New Page                 ${url_auth_ldap_${test_site}} 
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}
    Set Response On Webpage To Json 
    Get Value From Key Access Token
    Set Content Header Ldap Logout    ${url_ldap_logout_${test_site}}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp_sso}
    Send Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp_sso}
    
TST_F10_1_1_011 Verlify login Ldap employee partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    [Tags]    Content_Provider    demo
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${user_ldap_employee}    ${pass_ldap_employee}
    Press Login Button
    Create URL For Get Token
    New Page                      ${URL_GET_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key ID Token        login    Employee
TST_F10_1_1_012 Verlify sso Ldap employee partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User sso successfully.
    [Tags]    Content_Provider    demo
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    New Page               ${url_auth_ldap_employee_${test_site}} 
    Create URL For Get Token
    New Page               ${URL_GET_TOKEN}                 
    Set Data Response Ldap For Verify              
    Verify Response Ldap    
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso    Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key ID Token        sso    Employee

TST_F10_1_1_013 Verify Refresh Token with login ldap employee
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    [Tags]    Content_Provider    demo
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key ID Token        login    Employee
    Create URL For Get Refresh Token  
    New Page               ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify   
    Verify Response Ldap
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Employee    
    Decode Refresh Token To Jwt By Key Id Token
    Verify Response Decode Refresh Token By Key ID Token        Employee
TST_F10_1_1_014 Verify Refresh Token with SSO ldap employee
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    [Tags]    Content_Provider    demo
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    New Page                 ${url_auth_ldap_employee_${test_site}}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}   
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso   Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key ID Token        sso   Employee
    Create URL For Get Refresh Token  
    New Page                 ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify   
    Verify Response Ldap 
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Employee    
    Decode Refresh Token To Jwt By Key Id Token
    Verify Response Decode Refresh Token By Key ID Token        Employee   

TST_F10_1_1_015 Verify Refresh Token with login ldap employee
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider    demo
    Open Browser Login Employee And Open Page Get Token   ${url_auth_ldap_employee_no_scope_profile}
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login   Employee
    Create URL For Get Refresh Token  
    New Page    ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap No Scope Profile
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Employee    

TST_F10_1_1_016 Verify Refresh Token with SSO ldap employee
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    [Tags]    Content_Provider    demo
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_no_scope_profile}
    New Page    ${url_auth_ldap_employee_no_scope_profile}
    Create URL For Get Token
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso   Employee
    Create URL For Get Refresh Token
    New Page    ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap No Scope Profile
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Employee   

TST_F10_1_1_017 Verify Decrypted PID ldap Employee snake case
    [Tags]    On-Hold

TST_F10_1_1_018 Verify Decrypted PID ldap Employee camel case
    [Tags]    On-Hold

TST_F10_1_1_019 Verify Logout with Ldap Employee
    [Tags]    On-Hold

TST_F10_1_1_020 Verify Logout with SSO Ldap Employee
    [Tags]    On-Hold



























































































































































































































































# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TST_F10_0_1_001 Verify Ldap Content provider with invalid password
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session        ${url_auth_LDAP_${test_site}}
    Fill Username And Password    ${user_ldap_provider}    ${invalid_pass_ldap_provider}
    Press Login Button
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_002 Verify Ldap Content provider with invalid user
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session        ${url_auth_LDAP_${test_site}}
    Fill Username And Password    ${invalid_user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_003 Verify Ldap Content provider with missing parameter
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session    ${url_auth_miss_parameter_ldap_${test_site}}
    Verify Invalid Request On Webpage

TST_F10_0_1_004 Verlify get token Ldap Content provider with authhcode expire
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session        ${url_auth_ldap_${test_site}}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button
    Create URL For Get Token
    Wait For Authentication Code Expire
    New Page                      ${URL_GET_TOKEN}
    Verify Invalid Grant On Webpage

TST_F10_0_1_005 Verlify get token Ldap Content provider with client_id and client_secret no match
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session    ${url_client_secret_no_match_ldap_${test_site}}
    Verify Invalid Grant On Webpage

TST_F10_0_1_006 Verlify get token Ldap Content provider with invalid client_secret
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session    ${url_invalid_client_secret_ldap_${test_site}}
    Verify Invalid Grant On Webpage

TST_F10_0_1_007 Verify Login ldap employee with invalid password
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${user_ldap_employee}    ${invalid_user_ldap_employee}
    Press Login Button
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_008 Verify Login ldap employee with invalid user
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${invalid_pass_ldap_employee}    ${pass_ldap_employee}
    Press Login Button
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_009 Verify Login ldap employee with missing parameter
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_miss_parameter_ldap_${test_site}}
    Verify Invalid Request On Webpage

TST_F10_0_1_010 Verlify get token ldap employee with authhcode expire
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${user_ldap_employee}    ${pass_ldap_employee}
    Press Login Button
    Create URL For Get Token
    Wait For Authentication Code Expire
    New Page                      ${URL_GET_TOKEN}
    Verify Invalid Grant On Webpage

TST_F10_0_1_011 Verlify get token ldap employee with client_id and client_secret no match
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_client_secret_no_match_ldap_${test_site}}
    Verify Invalid Grant On Webpage

TST_F10_0_1_012 Verlify get token ldap employee with invalid client_secret
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_invalid_client_secret_ldap_${test_site}}
    Verify Invalid Grant On Webpage
