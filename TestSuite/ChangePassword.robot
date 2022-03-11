*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Append To Document Teardown


*** Test Cases ***
TST_F8_1_1_001 Verlify change_password with Msisdn password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = msisdn_password 
    ...    \r\nMsisdn password ไม่มี login_subtype
    [Tags]    Change_password    Msisdn    demosprint3
    Create Browser Session    ${url_login_change_password}
    Fill Username And Password Login Page Change Password
    Click Login Button In Login Page Change Password
    Create URL For Get Token     ${url_get_token_change_password_schema}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Msisdn Password
    Send Post Request Change Password
    Verify Response Change Password With Msisdn Password

TST_F8_1_1_002 Verlify change_password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\nค่าที่อยู่ใน idtoken "login_subtype": "ldapCp" 
    [Tags]    Change_password    Ldap Content provider    demosprint3 
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Ldap Content Provider
    Send Post Request Change Password
    Verify Response Change Password With Ldap Content Provider

TST_F8_1_1_003 Verlify change_password with profile have gupimpi more than one object
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\nค่าที่อยู่ใน idtoken "login_subtype": "ldapCp" 
    [Tags]    Change_password    On-Hold    

TST_F8_0_1_001 Verlify change_password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = ldap 
    ...    \r\nwrong old password
    [Tags]    Change_password    Ldap Content provider    demosprint3  
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password Invalid Old Password
    Send Post Request Change Password Invalid    401
    Verify Response Change Password Invalid Old Password

TST_F8_0_1_002 Verlify change_password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = ldap 
    ...    \r\nnew password contains Thai character
    [Tags]    Change_password    Ldap Content provider    demosprint3 
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password Invalid New Password Contains Thai Character
    Send Post Request Change Password Invalid    400
    Verify Response Change Password Invalid New Password Contains Thai Character

TST_F8_0_1_003 Verlify change_password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    type = ldap 
    ...    new password contains "&"
    [Tags]    Change_password    Ldap Content provider    demosprint3     
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password Invalid New Password Contains Special Character
    Send Post Request Change Password Invalid    400
    Verify Response Change Password Invalid New Password Contains Special Character

TST_F8_0_1_004 Verlify change_password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = ldap 
    ...    \r\naccess_token expired
    [Tags]    Change_password    Ldap Content provider    demosprint3     test
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password Invalid Access Token Expired
    Send Post Request Change Password Invalid    400
    Verify Response Change Password Invalid Access Token Expired

TST_F8_0_1_005 Verlify change_password with Msisdn password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    type = msisdn_password or msisdn
    ...    wrong old password
    [Tags]    Change_password    On-Hold

TST_F8_0_1_006 Verlify change_password with Msisdn password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    type = ldap
    ...    new password contains Thai character
    [Tags]    Change_password    On-Hold

TST_F8_0_1_007 Verlify change_password with Msisdn password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    type = ldap
    ...    new password contains "&"
    [Tags]    Change_password    On-Hold

TST_F8_0_1_008 Verlify change_password with Msisdn password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    type = msisdn_password or msisdn
    ...    access_token expired
    [Tags]    Change_password    On-Hold
