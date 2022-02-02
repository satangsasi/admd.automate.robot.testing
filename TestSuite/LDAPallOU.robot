*** Settings ***
Library    Collections
Library    RequestsLibrary
Resource    ../../arcadia.automate.buffet/APIBuffet/RequestLibrary_APIKeywords.robot
*** Test Cases ***
TST_F10_1_1_001 LDAP all OU Verlify login Ldap Content provider partnerId 30233 
    [Documentation]     Owner : sasipen
TST_F10_1_1_002 Verlify sso Ldap Content provider partnerId 30233
    
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
































































































































































































































































TST_F10_0_1_001 Verify Ldap Content provider with invalid password
    [Documentation]     Owner : Nakarin
TST_F10_0_1_002 Verify Ldap Content provider with invalid user

TST_F10_0_1_003 Verify Ldap Content provider with missing parameter

TST_F10_0_1_004 Verlify get token Ldap Content provider with authhcode expire

TST_F10_0_1_005 Verlify get token Ldap Content provider with client_id and client_secret no match

TST_F10_0_1_006 Verlify get token Ldap Content provider with invalid client_secret 

TST_F10_0_1_007 Verify Login ldap employee with invalid password

TST_F10_0_1_008 Verify Login ldap employee with invalid user

TST_F10_0_1_009 Verify Login ldap employee with missing parameter

TST_F10_0_1_010 Verlify get token ldap employee with authhcode expire

TST_F10_0_1_011 Verlify get token ldap employee with client_id and client_secret no match

TST_F10_0_1_012 Verlify get token ldap employee with invalid client_secret 


