*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Create URL For Get Token
    Wait Until Network Is Idle
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_get_token_schema}    _code_    ${CODE}    
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}

Get Code From Authentication
    ${url_authentication_access}    Get Url 
    ${code}    Split String         ${url_authentication_access}    =
    ${code}    Set Variable         ${code}[1]     
    Set Test Variable    ${CODE}    ${code}

Verify Resource Access Token 
    ${message}            Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}       Convert String to JSON    ${message}   
    Log Many     &{json_message}
    Dictionary Should Contain Key    ${json_message}    access_token 
    Dictionary Should Contain Key    ${json_message}    id_token 
    ${token}    Set Variable         ${json_message}[access_token]
    Log      ${token}    
    Set Test Variable    ${TOKEN}    ${token}         
    Take Screenshot Verify Success Scene
# Get Token From Text Access Token
#     ${token}    Split String    ${MESSAGE}      "
#     ${token}    Set Variable    ${token}[3]
#     Set Test Variable    ${TOKEN}    ${token}       

Open Browser And Login 
    Open Browser                  ${url_authentication}    ${default_browser}   
    Fill Username And Password    ${user_provider}         ${pass_provider}  
    Press Login Button

Get Code From Key Refresh Token 
    ${message}            Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}       Convert String to JSON    ${message}   
    ${code_refresh_token}    Set Variable         ${json_message}[refresh_token]
    Set Test Variable    ${CODE_REFRESH_TOKEN}    ${code_refresh_token} 
Create URL For Get Refresh Token
    Wait Until Network Is Idle
    Get Code From Key Refresh Token 
    ${url_get_refresh_token}     Replace String      ${url_get_refresh_token_schema}    _code_    ${CODE_REFRESH_TOKEN}  
    Set Test Variable    ${URL_GET_REFRESH_TOKEN}    ${url_get_refresh_token}





























































































































































































































































































# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Fill Username And Password
    [Documentation]    Owner: Nakarin
    ...    Recieve Arguments Username and Password 
    ...    Then fill it into text username and password text box
    [Arguments]  ${user}    ${pass}
    [Tags]    keyword_communicate
    Fill Text    ${txt_username_ldap}    ${user}
    Fill Text    ${txt_password_ldap}    ${pass}

Press Login Button
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Click     ${btn_login_ldap}

Verify Login Fail
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Value At Locator    ${lbl_error_title}      ${error_title}
    Verify Value At Locator    ${lbl_error_message}    ${error_message}
    Take Screenshot At Verify Point    Fail Login Message
