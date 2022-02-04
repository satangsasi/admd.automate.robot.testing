*** Settings ***
Resource    ./Resource_init.robot

*** Test Cases ***
TST_F10_1_1_001 LDAP all OU Verlify login Ldap Content provider partnerId 30233 
    [Documentation]     Owner : sasipen
    Open Browser                  ${url_authentication}    ${default_browser}   
    Fill Username And Password    ${username}              ${password}    
    Press Login Button
    Create URL For Get Token
    Open Browser                 ${URL_GET_TOKEN}          ${default_browser}                     
    Verify Text Access Token 
    Take Screenshot Verify Success Scene   
    #Decode Token To JWT
TST_F10_1_1_002 Verlify sso Ldap Content provider partnerId 30233
    Open Browser And Login 
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}   
    New Page                 ${url_authentication}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}                   
    Verify Text Access Token     
    Take Screenshot Verify Success Scene  
    #Decode Token To JWT
        
TST_F10_1_1_003 Verify Refresh Token with login Ldap Content provider 
    
    
TST_F10_1_1_004 Verify Refresh Token with SSO Ldap Content provider
    
TST_F10_1_1_005 Verify Refresh Token with login Ldap Content provider
    
TST_F10_1_1_006 Verify Refresh Token with SSO Ldap Content provider
    
TST_F10_1_1_007 Verify Decrypted PID ldap Content provider snake case
    
TST_F10_1_1_008 Verify Decrypted PID ldap Content provider camel case
    
TST_F10_1_1_009 Verify Logout with Ldap Content provider
    
TST_F10_1_1_010 Verify Logout with SSO Ldap Content provider
    
TST_F10_1_1_011 Verlify login Ldap employee partnerId 30233
    
TST_F10_1_1_012 Verlify sso Ldap employee partnerId 30233

TST_F10_1_1_013 Verify Refresh Token with login ldap employee

TST_F10_1_1_014 Verify Refresh Token with SSO ldap employee

TST_F10_1_1_015 Verify Refresh Token with login ldap employee

TST_F10_1_1_016 Verify Refresh Token with SSO ldap employee

TST_F10_1_1_017 Verify Decrypted PID ldap Employee snake case

TST_F10_1_1_018 Verify Decrypted PID ldap Employee camel case

TST_F10_1_1_019 Verify Logout with Ldap Employee

TST_F10_1_1_020 Verify Logout with SSO Ldap Employee




























































































































































































































































# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TST_F10_0_1_001 Verify Ldap Content provider with invalid password
    [Documentation]     Owner : Nakarin
    [Tags]    Content_Provider    On-Hold
    Open Browser        ${authentication_url}    ${default_browser}
    Fill Username And Password    ${username}    password425
    Press Login Button
    Wait Until Network Is Idle
    Verify Login Fail

TST_F10_0_1_002 Verify Ldap Content provider with invalid user
    [Documentation]     Owner : Nakarin
    [Tags]    Content_Provider    On-Hold
    Open Browser    ${authentication_url}    ${default_browser}
    Fill Username And Password        426    ${password}
    Press Login Button
    Wait Until Network Is Idle
    Verify Login Fail

TST_F10_0_1_003 Verify Ldap Content provider with missing parameter
    [Tags]    Content_Provider
    # Open Browser    ${authentication_url}    Firefox
    Open Browser    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/    chromium
    Wait Until Network Is Idle
    Verify Value At Locator    //pre    {"error":"invalid_request"}
    # Sleep    10s
TST_F10_0_1_004 Verlify get token Ldap Content provider with authhcode expire
    [Tags]    Content_Provider

TST_F10_0_1_005 Verlify get token Ldap Content provider with client_id and client_secret no match
    [Tags]    Content_Provider

TST_F10_0_1_006 Verlify get token Ldap Content provider with invalid client_secret 
    [Tags]    Content_Provider

TST_F10_0_1_007 Verify Login ldap employee with invalid password
    [Tags]    Employee

TST_F10_0_1_008 Verify Login ldap employee with invalid user
    [Tags]    Employee

TST_F10_0_1_009 Verify Login ldap employee with missing parameter
    [Tags]    Employee
    
TST_F10_0_1_010 Verlify get token ldap employee with authhcode expire
    [Tags]    Employee

TST_F10_0_1_011 Verlify get token ldap employee with client_id and client_secret no match
    [Tags]    Employee

TST_F10_0_1_012 Verlify get token ldap employee with invalid client_secret 
    [Tags]    Employee
