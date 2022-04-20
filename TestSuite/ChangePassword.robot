*** Settings ***
Resource    ./Resource_init.robot
Suite Setup      Keyword Suite Setup
Test Teardown    Run Keyword And Ignore Error    Keyword Test Teardown


*** Test Cases ***
TST_F8_1_1_001 Verlify Change Password with Msisdn Password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = msisdn_password 
    ...    \r\nMsisdn password ไม่มี login_subtype
    [Tags]    Success    Change_password    Msisdn    
    [Setup]
    Create Browser Session    ${url_login_change_password}
    Fill Username And Password Login Page Change Password
    Press Login Button In Login Page Change Password
    Create URL For Get Token     ${url_get_token_change_password_schema}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Msisdn Password
    Send Post Request Change Password
    Verify Response Change Password With Msisdn Password

TST_F8_1_1_002 Verlify Change Password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\nค่าที่อยู่ใน idtoken "login_subtype": "ldapCp" 
    [Tags]    Success    Change_password    Ldap_Content_provider    
    [Setup]    Sleep    20s
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Verify Value Login Subtype By Key
    Set API Header Change Password
    Set API Body Change Password With Ldap Content Provider
    Send Post Request Change Password
    Verify Response Change Password With Ldap Content Provider

TST_F8_1_1_003 Verlify Change Password with profile have gupimpi more than one object
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\nค่าที่อยู่ใน idtoken "login_subtype": "ldapCp" 
    [Tags]    Change_password    On-Hold    

TST_F8_0_1_001 Verlify Change Password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = ldap 
    ...    \r\nwrong old password
    [Tags]    Fail    Change_password    Ldap_Content_provider    
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Ldap Invalid Old Password
    Send Post Request Change Password Invalid    401
    Verify Response Change Password With Ldap Invalid Old Password

TST_F8_0_1_002 Verlify Change Password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = ldap 
    ...    \r\nnew password contains Thai character
    [Tags]    Fail    Change_password    Ldap_Content_provider    
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Ldap Invalid New Password Contains Thai Character
    Send Post Request Change Password Invalid    400
    Verify Response Change Password With Ldap Invalid New Password Contains Thai Character

TST_F8_0_1_003 Verlify Change Password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    type = ldap 
    ...    new password contains "&"
    [Tags]    Fail    Change_password    Ldap_Content_provider    demosprint4     
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Ldap Invalid New Password Contains Special Character
    Send Post Request Change Password Invalid    400
    Verify Response Change Password With Ldap Invalid New Password Contains Special Character

TST_F8_0_1_004 Verlify Change Password with Ldap Content provider
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = ldap 
    ...    \r\naccess_token expired
    [Tags]    Fail    Change_password    Ldap_Content_provider    demosprint4    
    Create Browser Session        ${url_auth_ldap}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}
    Press Login Button In LDAP
    Create URL For Get Token      ${url_get_token_schema}
    New Page                      ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Ldap Invalid Access Token Expired
    Send Post Request Change Password Invalid    400
    Verify Response Change Password With Ldap Invalid Access Token Expired

TST_F8_0_1_005 Verlify Change Password with Msisdn password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = msisdn_password or msisdn
    ...    \r\nwrong old password
    [Tags]    Fail    Change_password    Msisdn    demosprint4    
    Create Browser Session    ${url_login_change_password}
    Fill Username And Password Login Page Change Password
    Press Login Button In Login Page Change Password
    Create URL For Get Token     ${url_get_token_change_password_schema}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Msisdn Invalid Old Password
    Send Post Request Change Password Invalid    401
    Verify Response Change Password With Msisdn Invalid Old Password

TST_F8_0_1_006 Verlify Change Ppassword with Msisdn password
    [Documentation]    Owner: sasipen
    ...    \r\n***Condition***
    ...    \r\ntype = ldap
    ...    \r\nnew password contains Thai character
    [Tags]    Fail    Change_password    Msisdn    demosprint4     
    Create Browser Session    ${url_login_change_password}
    Fill Username And Password Login Page Change Password
    Press Login Button In Login Page Change Password
    Create URL For Get Token     ${url_get_token_change_password_schema}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Msisdn Invalid New Password Contains Thai Character
    Send Post Request Change Password Invalid    400
    Verify Response Change Password With Msisdn Invalid New Password Contains Thai Character

TST_F8_0_1_007 Verlify Change Password with Msisdn password
    [Documentation]    Owner: Atitaya
    ...    \r\n***Condition***
    ...    \r\ntype = ldap
    ...    \r\nnew password contains "&"
    [Tags]    Fail    Change_password    Msisdn     Atitaya
    Create Browser Session          ${url_login_change_password}
    Fill Username And Password Login Page Change Password
    Press Login Button In Login Page Change Password
    Create URL For Get Token     ${url_get_token_change_password_schema}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header Change Password
    Set API Body Change Password With Msisdn New Password Contains Special Character
    Send Post Request Change Password Invalid    400
    Verify Response Change Password With Msisdn Invalid New Password Contains Special Character

TST_F8_0_1_008 Verlify Change Password with Msisdn password
    [Documentation]    Owner: Atitaya
    ...    \r\n***Condition***
    ...    \r\ntype = msisdn_password or msisdn
    ...    \r\naccess_token expired
    [Tags]    Fail    Change_password    Msisdn     Atitaya
    Create Browser Session          ${url_login_change_password}
    Fill Username And Password Login Page Change Password
    Press Login Button In Login Page Change Password
    Create URL For Get Token     ${url_get_token_change_password_schema}
    New Page    ${URL_GET_TOKEN}
    Set API Header Change Password
    Set API Body Change Password With Msisdn Invalid Access Token Expired    
    Send Post Request Change Password Invalid    400
    Verify Response Change Password With Msisdn Invalid Access Token Expired 
