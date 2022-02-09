*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    LDAP Keywords Teardown


*** Test Cases ***
TST_F10_1_1_001 LDAP all OU Verlify login Ldap Content provider partnerId 30233
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    [Tags]    Content_Provider    sasi
    Create Browser Session    ${url_authentication_ldap_${test_site}}         
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}   
    Press Login Button
    Create URL For Get Token
    New Page                      ${URL_GET_TOKEN}                             
    Verify Response Access Token Login LDAP    key_response_1=access_token    key_response_2=id_token  
    #Decode Token To JWT
    
TST_F10_1_1_002 Verlify sso Ldap Content provider partnerId 30233
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    ...
    ...    ***Provisioning data***
    [Tags]    Content_Provider     sasi
    Open Browser Login And Open Page Get Token    ${url_authentication_ldap_${test_site}}   
    New Page                 ${url_authentication_ldap_${test_site}} 
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}                   
    Verify Response Access Token Login LDAP    key_response_1=access_token    key_response_2=id_token 
    #Decode Token To JWT
        
TST_F10_1_1_003 Verify Refresh Token with login Ldap Content provider 
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...    \r\n Scope = Profile 
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    [Tags]    Content_Provider    sasi
    Open Browser Login And Open Page Get Token    ${url_authentication_ldap_scope_profile} 
    Verify Response Access Token Login LDAP       key_response_1=access_token
    Create URL For Get Refresh Token  
    New Page                                      ${URL_GET_REFRESH_TOKEN}
    Verify Response Access Token Refresh LDAP     key_response_1=access_token    key_response_2=id_token
    
TST_F10_1_1_004 Verify Refresh Token with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...    \r\n Scope = Profile 
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    ...
    ...    ***Provisioning data***
    [Tags]    Content_Provider    sasi
    Open Browser Login And Open Page Get Token    ${url_authentication_ldap_scope_profile} 
    New Page                                      ${url_authentication_ldap_scope_profile} 
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}   
    Verify Response Access Token Login LDAP       key_response_1=access_token
    Create URL For Get Refresh Token  
    New Page                 ${URL_GET_REFRESH_TOKEN}
    Verify Response Access Token Refresh LDAP     key_response_1=access_token    key_response_2=id_token
    
TST_F10_1_1_005 Verify Refresh Token with login Ldap Content provider
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    ...
    ...    ***Provisioning data***
    [Tags]    Content_Provider    sasi
    Open Browser Login And Open Page Get Token    ${url_authentication_ldap_scope_profile} 
    Verify Response Access Token Login LDAP       key_response_1=access_token
    Create URL For Get Refresh Token  
    New Page                                      ${URL_GET_REFRESH_TOKEN}
    Verify Response Access Token Refresh LDAP     key_response_1=access_token 

TST_F10_1_1_006 Verify Refresh Token with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    ...
    ...    ***Provisioning data***
    [Tags]    On-Hold    
    Open Browser Login And Open Page Get Token    ${url_authentication_ldap_no_scope_profile}
    New Page                                      ${url_authentication_ldap_no_scope_profile}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}   
    Verify Response Access Token Login LDAP       key_response_1=access_token
    Create URL For Get Refresh Token
    New Page                 ${URL_GET_REFRESH_TOKEN}
    Verify Response Access Token Refresh LDAP     key_response_1=access_token

TST_F10_1_1_007 Verify Decrypted PID ldap Content provider snake case
    [Tags]    On-Hold
    # Open Browser        https://jwt.io/            ${default_browser}
    # Wait Until Network Is Idle
    # Scroll To    0,1500
    # Clear Text        xpath=//*[@class="editor-warning warning js-editor-warnings hidden"]

TST_F10_1_1_008 Verify Decrypted PID ldap Content provider camel case
    [Tags]    On-Hold

TST_F10_1_1_009 Verify Logout with Ldap Content provider
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...    \r\n 
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    ...
    ...    ***Provisioning data***
    [Tags]    Content_Provider    sasi
    Open Browser Login And Open Page Get Token    ${url_authentication_ldap_${test_site}}
    Get Value From Access Token
    Set Content Header Ldap Logout    ${url_ldap_logout_${test_site}}    
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp}  
    Send Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp}  

TST_F10_1_1_010 Verify Logout with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...    \r\n 
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    ...
    ...    ***Provisioning data***
    [Tags]    Content_Provider    sasi
    Open Browser Login And Open Page Get Token    ${url_authentication_ldap_${test_site}}   
    New Page                 ${url_authentication_ldap_${test_site}} 
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN} 
    Get Value From Access Token 
    Set Content Header Ldap Logout    ${url_ldap_logout_${test_site}}    
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp_sso}  
    Send Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp_sso}
TST_F10_1_1_011 Verlify login Ldap employee partnerId 30233
    [Tags]    On-Hold

TST_F10_1_1_012 Verlify sso Ldap employee partnerId 30233
    [Tags]    On-Hold

TST_F10_1_1_013 Verify Refresh Token with login ldap employee
    [Tags]    On-Hold

TST_F10_1_1_014 Verify Refresh Token with SSO ldap employee
    [Tags]    On-Hold

TST_F10_1_1_015 Verify Refresh Token with login ldap employee
    [Tags]    On-Hold

TST_F10_1_1_016 Verify Refresh Token with SSO ldap employee
    [Tags]    On-Hold

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
    [Tags]    Content_Provider    Test
    Create Browser Session    ${url_authentication_LDAP_${test_site}}
    Fill Username And Password    ${user_ldap_provider}    password425
    Press Login Button
    Wait Until Network Is Idle
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_002 Verify Ldap Content provider with invalid user
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider    Test
    Create Browser Session    ${url_authentication_LDAP_${test_site}}
    Fill Username And Password        426    ${pass_ldap_provider}
    Press Login Button
    Wait Until Network Is Idle
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_003 Verify Ldap Content provider with missing parameter
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider    On-Hold
    Create Browser Session
    Wait Until Network Is Idle
    Verify Value At Locator    ${lbl_json_response_on_webpage}    {"error":"invalid_request"}

TST_F10_0_1_004 Verlify get token Ldap Content provider with authhcode expire
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider    On-Hold
    Open Browser    ${url_authentication}    ${default_browser}

TST_F10_0_1_005 Verlify get token Ldap Content provider with client_id and client_secret no match
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider    On-Hold

TST_F10_0_1_006 Verlify get token Ldap Content provider with invalid client_secret 
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider    On-Hold

TST_F10_0_1_007 Verify Login ldap employee with invalid password
    [Documentation]    Owner: Nakarin
    [Tags]    Employee    Test
    Create Browser Session    ${url_authentication_LDAP_${test_site}}
    Fill Username And Password    ${user_ldap_employee}    Nop#3246@Stg!sss
    Press Login Button
    Wait Until Network Is Idle
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_008 Verify Login ldap employee with invalid user
    [Documentation]    Owner: Nakarin
    [Tags]    Employee    Test
    Create Browser Session    ${url_authentication_LDAP_${test_site}}
    Fill Username And Password    noppararhhh    ${pass_ldap_employee}
    Press Login Button
    Wait Until Network Is Idle
    Verify Login Fail
    # Verify Log From Server

TST_F10_0_1_009 Verify Login ldap employee with missing parameter
    [Tags]    Employee    On-Hold
    
TST_F10_0_1_010 Verlify get token ldap employee with authhcode expire
    [Tags]    Employee    On-Hold

TST_F10_0_1_011 Verlify get token ldap employee with client_id and client_secret no match
    [Tags]    Employee    On-Hold

TST_F10_0_1_012 Verlify get token ldap employee with invalid client_secret 
    [Tags]    Employee    On-Hold
