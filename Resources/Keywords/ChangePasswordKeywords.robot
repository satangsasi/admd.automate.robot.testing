*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Fill Username And Password Login Page Change Password
    [Documentation]    Owner: sasipen
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text    ${txt_username_changepassword}    ${user_login_changepassword}    delay=0.1s
    Type Text    ${txt_password_changepassword}    ${pass_login_changepassword}    delay=0.1s
    Set Test Provisioning Data   Username: ${user_login_changepassword}
    Set Test Provisioning Data   Password: ${pass_login_changepassword}

Click Login Button In Login Page Change Password
    [Documentation]    Owner: sasipen
    [Tags]    Keyword_communicate
    Click    ${btn_login_changepassword} 

Create URL For Get Token Change Password
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Append Token(get from Auth Url) to get Token(API) Url
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_get_token_changepassword_schema}    _code_    ${CODE}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}


