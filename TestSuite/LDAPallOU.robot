*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Append To Document Teardown


*** Test Cases ***
TST_F10_1_1_001 LDAP all OU Verify login Ldap Content provider partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    [Tags]    Content_Provider
    Create Browser Session        ${url_auth_ldap_${test_site}}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    LDAPallOUKeywords.Press Login Button
    Create URL For Get Token
    New Page                      ${URL_GET_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Content Provider
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key Id Token      login    Content Provider
    
TST_F10_1_1_002 Verify sso Ldap Content provider partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    [Tags]    Content_Provider 
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_${test_site}}
    New Page                 ${url_auth_ldap_${test_site}}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso    Content Provider
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key Id Token        sso    Content Provider
        
TST_F10_1_1_003 Verify Refresh Token with login Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider
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
    Verify Response Decode Refresh Token By Key Id Token        Content Provider
    
TST_F10_1_1_004 Verify Refresh Token with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile 
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider
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
    Verify Response Decode Refresh Token By Key Id Token        Content Provider

TST_F10_1_1_005 Verify Refresh Token with login Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Content_Provider
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
    [Tags]    Content_Provider 
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
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider    VPN    Sprint2
    Send Get Request LDAP    ${url_decrypted_ldap_content_provider_snake_case}
    Verify Response Decrypted Pid Ldap Content Provider Snake Case

TST_F10_1_1_008 Verify Decrypted PID ldap Content provider camel case
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider    VPN    Sprint2
    Send Get Request LDAP    ${url_decrypted_ldap_content_provider_camel_case}
    Verify Response Decrypted Pid Ldap Content Provider Camel Case

TST_F10_1_1_009 Verify Logout with Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    [Tags]    Content_Provider
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_${test_site}}
    Set Response On Webpage To Json
    Get Value From Key Access Token
    Set Content Header Ldap Logout    ${url_ldap_logout_${test_site}}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp}  
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp}
    
TST_F10_1_1_010 Verify Logout with SSO Ldap Content provider
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    [Tags]    Content_Provider
    Open Browser Login And Open Page Get Token    ${url_auth_ldap_${test_site}}
    New Page                 ${url_auth_ldap_${test_site}} 
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}
    Set Response On Webpage To Json 
    Get Value From Key Access Token
    Set Content Header Ldap Logout    ${url_ldap_logout_${test_site}}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp_sso}
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp_sso}
    
TST_F10_1_1_011 Verify login Ldap employee partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User logins successfully.
    [Tags]    Employee
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${user_ldap_employee}    ${pass_ldap_employee}
    LDAPallOUKeywords.Press Login Button
    Create URL For Get Token
    New Page                      ${URL_GET_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key Id Token        login    Employee

TST_F10_1_1_012 Verify sso Ldap employee partnerId 30233
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n User sso successfully.
    [Tags]    Employee
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    New Page               ${url_auth_ldap_employee_${test_site}} 
    Create URL For Get Token
    New Page               ${URL_GET_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso    Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key Id Token        sso    Employee

TST_F10_1_1_013 Verify Refresh Token with login ldap employee
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    [Tags]    Employee
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    login    Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key Id Token        login    Employee
    Create URL For Get Refresh Token  
    New Page               ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify
    Verify Response Ldap
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Employee
    Decode Refresh Token To Jwt By Key Id Token
    Verify Response Decode Refresh Token By Key Id Token        Employee

TST_F10_1_1_014 Verify Refresh Token with SSO ldap employee
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token. 
    [Tags]    Employee
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    New Page                 ${url_auth_ldap_employee_${test_site}}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}   
    Set Response On Webpage To Json 
    Decode Login Token Jwt By Key Access Token
    Verify Response Decode Login Token By Key Access Token    sso   Employee
    Decode Login Token To Jwt By Key Id Token
    Verify Response Decode Login Token By Key Id Token        sso   Employee
    Create URL For Get Refresh Token  
    New Page                 ${URL_GET_REFRESH_TOKEN}
    Set Data Response Ldap For Verify   
    Verify Response Ldap 
    Decode Refresh Token To Jwt By Key Access Token
    Verify Response Decode Refresh Token By Key Access Token    Employee
    Decode Refresh Token To Jwt By Key Id Token
    Verify Response Decode Refresh Token By Key Id Token        Employee

TST_F10_1_1_015 Verify Refresh Token with login ldap employee
    [Documentation]     Owner : sasipen
    ...    ***Condition***
    ...    \r\n don't have Scope = Profile
    ...
    ...    ***Expected Result***
    ...    \r\n Successfully login and got access_token.
    [Tags]    Employee
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
    [Tags]    Employee
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
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Decrypted success return correct PartnerSpecificPrivateId 
    [Tags]    Employee    test1
    Send Get Request LDAP    ${url_decrypted_ldap_employee_snake_case}
    Verify Response Decrypted Pid Ldap Employee Snake Case

TST_F10_1_1_018 Verify Decrypted PID ldap Employee camel case
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Decrypted success return correct PartnerSpecificPrivateId 
    [Tags]    Employee    test1
    Send Get Request LDAP    ${url_decrypted_ldap_employee_camel_case}
    Verify Response Decrypted Pid Ldap Employee Camel Case

TST_F10_1_1_019 Verify Logout with Ldap Employee
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    [Tags]    Employee    test1
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    Set Response On Webpage To Json 
    Get Value From Key Access Token
    Set Content Header Ldap Logout    ${url_for_logout_ldap_employee}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp} 
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp}

TST_F10_1_1_020 Verify Logout with SSO Ldap Employee
    [Documentation]     Owner : sasipen
    ...    ***Expected Result***
    ...    \r\n Successfully logout
    [Tags]    Employee    test1
    Open Browser Login Employee And Open Page Get Token    ${url_auth_ldap_employee_${test_site}}
    New Page                 ${url_auth_ldap_employee_${test_site}}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}
    Set Response On Webpage To Json 
    Get Value From Key Access Token
    Set Content Header Ldap Logout    ${url_for_logout_ldap_employee}
    ...                               ${content_type_x_www}
    Set Body Ldap Logout              ${state_logout_ldap_cp_sso}
    Send Post Request Ldap Logout
    Verify Response State Ldap Logout    ${state_logout_ldap_cp_sso}
    
TST_F10_0_1_001 Verify Ldap Content provider with invalid password
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider    rerun
    Create Browser Session        ${url_auth_LDAP_${test_site}}
    Fill Username And Password    ${user_ldap_provider}    ${invalid_pass_ldap_provider}
    LDAPallOUKeywords.Press Login Button
    Verify Login Fail
    Get Json Log Ldap From Server 
    Verify Value Log Error From Server    ${error_message_invalid_user_or_password}

TST_F10_0_1_002 Verify Ldap Content provider with invalid user
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session        ${url_auth_LDAP_${test_site}}
    Fill Username And Password    ${invalid_user_ldap_provider}    ${pass_ldap_provider}
    LDAPallOUKeywords.Press Login Button
    Verify Login Fail
    Get Json Log Ldap From Server 
    Verify Value Log Error From Server    ${error_message_invalid_user_or_password}

TST_F10_0_1_003 Verify Ldap Content provider with missing parameter
    [Documentation]     Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session    ${url_auth_miss_parameter_ldap_${test_site}}
    Verify Invalid Request On Webpage

TST_F10_0_1_004 Verify get token Ldap Content provider with authhcode expire
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session        ${url_auth_ldap_${test_site}}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    LDAPallOUKeywords.Press Login Button
    Create URL For Get Token
    Wait For Authentication Code Expire
    New Page                      ${URL_GET_TOKEN}
    Verify Invalid Grant On Webpage

TST_F10_0_1_005 Verify get token Ldap Content provider with client_id and client_secret no match
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session    ${url_client_secret_no_match_ldap_${test_site}}
    Verify Invalid Grant On Webpage

TST_F10_0_1_006 Verify get token Ldap Content provider with invalid client_secret
    [Documentation]    Owner: Nakarin
    [Tags]    Content_Provider
    Create Browser Session    ${url_invalid_client_secret_ldap_${test_site}}
    Verify Invalid Grant On Webpage

TST_F10_0_1_007 Verify Login ldap employee with invalid password
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${user_ldap_employee}    ${invalid_user_ldap_employee}
    LDAPallOUKeywords.Press Login Button
    Verify Login Fail
    Get Json Log Ldap From Server 
    Verify Value Log Error From Server    ${error_message_invalid_user_or_password}

TST_F10_0_1_008 Verify Login ldap employee with invalid user
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${invalid_pass_ldap_employee}    ${pass_ldap_employee}
    LDAPallOUKeywords.Press Login Button
    Verify Login Fail
    Get Json Log Ldap From Server 
    Verify Value Log Error From Server    ${error_message_invalid_user_or_password}

TST_F10_0_1_009 Verify Login ldap employee with missing parameter
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_miss_parameter_ldap_${test_site}}
    Verify Invalid Request On Webpage

TST_F10_0_1_010 Verify get token ldap employee with authhcode expire
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_auth_ldap_employee_${test_site}}
    Fill Username And Password    ${user_ldap_employee}    ${pass_ldap_employee}
    LDAPallOUKeywords.Press Login Button
    Create URL For Get Token
    Wait For Authentication Code Expire
    New Page                      ${URL_GET_TOKEN}
    Verify Invalid Grant On Webpage

TST_F10_0_1_011 Verify get token ldap employee with client_id and client_secret no match
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_client_secret_no_match_ldap_${test_site}}
    Verify Invalid Grant On Webpage

TST_F10_0_1_012 Verify get token ldap employee with invalid client_secret
    [Documentation]    Owner: Nakarin
    [Tags]    Employee
    Create Browser Session        ${url_invalid_client_secret_ldap_${test_site}}
    Verify Invalid Grant On Webpage
