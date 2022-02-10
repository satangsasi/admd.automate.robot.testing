*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Create URL For Get Token
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    ***Editor Note***
    ...    - Add Set Test Provisioning Data
    # Wait Until Network Is Idle
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_get_token_schema}    _code_    ${CODE}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}

Get Code From Authentication
    [Documentation]     Owner : sasipen
    Wait Until Network Is Idle
    ${url_auth_access}    Get Url 
    ${code}    Split String         ${url_auth_access}    =
    ${code}    Set Variable         ${code}[1]
    Set Test Variable    ${CODE}    ${code}

Set Response On Webpage To Json
    [Documentation]     Owner : sasipen
    ${message}         Get Text    ${lbl_json_response_on_webpage}
    &{json_message}    Evaluate    json.loads('''${message}''')    json
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE}

Get Value Response Ldap By Key
    [Documentation]     Owner : sasipen
    [Arguments]        ${response_key}
    ${value}           Set Variable    ${RESPONSE_JSON_MESSAGE.${response_key}}
    [Return]     ${value}

Get Value Response Ldap 
    [Documentation]     Owner : sasipen
    ${value_token_type}    Get Value Response Ldap By Key    token_type
    Set Test Variable    ${ACTUAL_VALUE_TOKEN_TYPE}    ${value_token_type} 
    ${value_expires_in}    Get Value Response Ldap By Key    expires_in
    Set Test Variable    ${ACTUAL_VALUE_EXPIRES_IN}    ${value_expires_in}
    ${value_refresh_token_expires_in}    Get Value Response Ldap By Key    refresh_token_expires_in
    Set Test Variable    ${ACTUAL_VALUE_REFRESH_TOKEN_EXPIRES_IN}    ${value_refresh_token_expires_in}

Set Data Response Ldap For Verify
    Set Response On Webpage To Json
    Get Value Response Ldap 
    
Verify Response Ldap
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    ***Editor Note***
    ...    - Add Set Test Actual Result
    Verify Value Response Ldap By Key   access_token 
    Verify Value Response Ldap By Key   refresh_token 
    Verify Value Response Ldap By Key   id_token 
    Verify Value Should Be Equal    ${ACTUAL_VALUE_TOKEN_TYPE}     ${expected_token_type}
    Verify Value Should Be Equal    ${ACTUAL_VALUE_EXPIRES_IN}     ${expected_expires_in_ldap}    
    Verify Value Should Be Equal    ${ACTUAL_VALUE_REFRESH_TOKEN_EXPIRES_IN}        ${expected_refresh_token_expires_in_ldap}
    Take Screenshot Verify Success Scene 
    Set Test Actual Result    Token : ${RESPONSE_JSON_MESSAGE}

Decode Token To Jwt
    [Arguments]     ${response_key} 
    ${value}     Get Value Response Ldap By Key    ${response_key}  
    IF    '${response_key}' == 'access_token'  
        ${value}     Get Value Response Ldap By Key    ${response_key}   
        ${jwt_decode}           Jwt Decode      ${value}
        Set Test Actual Result    Jwt decode : ${jwt_decode}  
    END  
    IF    '${response_key}' == 'id_token'  
        ${value}     Get Value Response Ldap By Key    ${response_key}   
        ${jwt_decode}           Jwt Decode      ${value}
        Set Test Actual Result    Jwt decode : ${jwt_decode}  
    END

Verify Response Ldap No Scope Profile
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    ***Editor Note***
    ...    - Add Set Test Actual Result
    Verify Value Response Ldap By Key   access_token 
    Verify Value Response Ldap By Key   refresh_token 
    Verify Value Should Be Equal    ${ACTUAL_VALUE_TOKEN_TYPE}     ${expected_token_type} 
    Verify Value Should Be Equal    ${ACTUAL_VALUE_EXPIRES_IN}     ${expected_expires_in_no_scope_ldap}
    Verify Value Should Be Equal    ${ACTUAL_VALUE_REFRESH_TOKEN_EXPIRES_IN}    ${expected_refresh_token_expires_in_no_scope_ldap}
    Take Screenshot Verify Success Scene 
    Set Test Actual Result    Token : ${RESPONSE_JSON_MESSAGE}

Verify Value Response Ldap By Key 
    [Documentation]     Owner : sasipen
    [Arguments]   ${response_key}
    ${value}     Get Value Response Ldap By Key    ${response_key} 
    Should Match Regexp    ${value}     .+
    Log    ${value}

Create Browser Session
    [Documentation]     Owner : sasipen 
    [Arguments]    ${url}
    Set Up Browser Fullscreen        
    New Page       ${url}
    Set Test Variable    ${URL_AUTH}    ${url}
    Wait Until Network Is Idle

Get Code From Key Refresh Token 
    [Documentation]     Owner : sasipen
    ${code_refresh_token}    Get Value Response Ldap By Key    refresh_token
    Set Test Variable    ${CODE_REFRESH_TOKEN}    ${code_refresh_token} 

Create URL For Get Refresh Token
    [Documentation]     Owner : sasipen
    Wait Until Network Is Idle
    Get Code From Key Refresh Token
    ${url_get_refresh_token}     Replace String      ${url_get_refresh_token_schema_${test_site}}    _code_    ${CODE_REFRESH_TOKEN}
    Set Test Variable    ${URL_GET_REFRESH_TOKEN}    ${url_get_refresh_token}
    Log    ${URL_GET_REFRESH_TOKEN}

Open Browser Login And Open Page Get Token
    [Documentation]     Owner : sasipen
    [Arguments]    ${url}
    Create Browser Session   ${url}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}   
    Press Login Button
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}

Get Value From Key Access Token
    [Documentation]     Owner : sasipen
    ${value}    Get Value Response Ldap By Key    access_token
    Set Test Variable    ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}    ${value} 

Set Content Header Ldap Logout
    [Documentation]     Owner : sasipen
    [Arguments]          ${url}    ${content_type}
    ${headers}           Replace String       ${header_ldap_schema}    _Content-Type_    ${content_type}
    Set Test Variable    ${API_HEADER}    ${headers}
    Set Test Variable    ${API_URL}       ${url}

Set Body Ldap Logout
    [Documentation]     Owner : sasipen             {"access_token": "_access_token_", "state": "_state_"}
    [Arguments]        ${state}
    ${body_access_token_logout}    Replace String    ${body_ldap_schema}            _access_token_     ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}
    ${body_state}                  Replace String    ${body_access_token_logout}    _state_            ${state}
    Set Test Variable              ${API_BODY}       ${body_state}

Send Request Ldap Logout
    [Documentation]     Owner : sasipen
    Send Post Request    url=${API_URL}      headers=${API_HEADER}    body=${API_BODY}

Verify Response State Ldap Logout
    [Documentation]     Owner : sasipen
    [Arguments]        ${expected_state}
    Verify Value Response By Key    state        ${expected_state}
    ${autual_value_state}    Get Value Response By Key    state
    Set Test Actual Result    "state" : "${autual_value_state}"




































































































































































































































































# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Fill Username And Password
    [Documentation]    Owner: Nakarin
    ...    Recieve Arguments Username and Password 
    ...    Then fill it into text username and password text box
    [Arguments]  ${user}    ${pass}
    [Tags]    keyword_communicate
    Fill Text    ${txt_username_ldap}    ${user}
    Fill Text    ${txt_password_ldap}    ${pass}
    Set Test Variable         ${USER}    ${user}
    Set Test Variable         ${PASS}    ${pass}
    
Press Login Button
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Click     ${btn_login_ldap}
    Wait Until Network Is Idle

Wait For Authentication Code Expire
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    # Sleep    5m
    Wait For Elements State    ${lbl_json_response_on_webpage}    state=visible    timeout=5m

Verify Login Fail
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${actual_error_title}      Get Text    ${lbl_error_title}
    ${actual_error_message}    Get Text    ${lbl_error_message}
    Verify Value At Locator    ${lbl_error_title}      ${error_title}
    Verify Value At Locator    ${lbl_error_message}    ${error_message}
    Take Screenshot Verify Success Scene
    Set Test Actual Result     ${actual_error_title}
    Set Test Actual Result     ${actual_error_message}

Verify Invalid Request On Webpage
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${json_error_message}      Get Text    ${lbl_json_response_on_webpage}
    Verify Value At Locator    ${lbl_json_response_on_webpage}    ${json_error_message_invalid_request}
    Take Screenshot Verify Success Scene
    Set Test Actual Result     ${json_error_message}

Verify Invalid Grant On Webpage
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${json_error_message}      Get Text    ${lbl_json_response_on_webpage}
    Verify Value At Locator    ${lbl_json_response_on_webpage}    ${json_error_message_invalid_grant}
    Take Screenshot Verify Success Scene
    Set Test Actual Result     ${json_error_message}
