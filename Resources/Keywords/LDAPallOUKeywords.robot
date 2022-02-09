*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Create URL For Get Token
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    ***Editor Note***
    ...    - Add Set Test Provisioning Data
    Wait Until Network Is Idle
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_get_token_schema}    _code_    ${CODE}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}
    #Set Documentation Test Url Get Token     ${URL_GET_TOKEN}    
Get Code From Authentication
    [Documentation]     Owner : sasipen
    ${url_authentication_access}    Get Url 
    ${code}    Split String         ${url_authentication_access}    =
    ${code}    Set Variable         ${code}[1]     
    Set Test Variable    ${CODE}    ${code}
Verify Response Access Token Login LDAP
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    ***Editor Note***
    ...    - Add Set Test Actual Result
    [Arguments]           ${key_response_1}=${EMPTY}        ${key_response_2}=${EMPTY} 
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json 
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE} 
    IF    '${key_response_2}' != '${EMPTY}'
        Verify Value Response Ldap By Key   access_token  
        Verify Value Response Ldap By Key   id_token 
        Take Screenshot Verify Success Scene
    ELSE
        Verify Value Response Ldap By Key    access_token  
        Take Screenshot Verify Success Scene
    END
    Set Test Actual Result    Token : ${RESPONSE_JSON_MESSAGE}
Verify Response Access Token Refresh LDAP
    [Documentation]     Owner : sasipen
    [Arguments]           ${key_response_1}=${EMPTY}        ${key_response_2}=${EMPTY}            
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json        
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE}
    IF    '${key_response_2}' != '${EMPTY}'
        Verify Value Response Ldap By Key   access_token  
        Verify Value Response Ldap By Key   id_token 
        Take Screenshot Verify Success Scene
    ELSE
        Verify Value Response Ldap By Key   access_token  
        Take Screenshot Verify Success Scene
    END
    # Set Test Variable    ${ACTUAL_RESULT}        &{RESPONSE_JSON_MESSAGE}
    Set Test Actual Result      Refresh Token : ${RESPONSE_JSON_MESSAGE}

Verify Value Response Ldap By Key 
    [Documentation]     Owner : sasipen
    [Arguments]   ${key}
    ${value}    Set Variable    ${RESPONSE_JSON_MESSAGE.${key}} 
    Should Match Regexp    ${value}     .+
    Log    ${value}

# Set Response Login To Actual Result Login  
#     [Arguments]    ${value_1}=${EMPTY}        ${value_2}=${EMPTY}    
#     IF    '${value_2}' != '${EMPTY}'
#         Set Test Variable    ${ACTUAL_RESULT_LOGIN}    access token login LDAP ${value_1}\r\nid token login LDAP ${value_2}      
#     ELSE
#         Set Test Variable    ${ACTUAL_RESULT_LOGIN}    access token login LDAP ${value_1}
#     END

# Set Response Refresh To Actual Result Refresh
#     [Arguments]    ${value_1}=${EMPTY}        ${value_2}=${EMPTY}    
#     IF    '${value_2}' != '${EMPTY}'
#         Set Test Variable    ${ACTUAL_RESULT_REFRESH}    access token refresh LDAP ${value_1}\r\nid token refresh LDAP ${value_2}      
#     ELSE
#         Set Test Variable    ${ACTUAL_RESULT_REFRESH}    access token refresh LDAP ${value_1}
#     END

# Append Response Login And Refresh To Actual Result  
#     [Arguments]          ${actual_login}=${EMPTY}        ${actual_refresh}=${EMPTY} 
#     Set Test Variable    ${ACTUAL_RESULT}         ${actual_login}\r\n${actual_refresh}    

Create Browser Session
    [Documentation]     Owner : sasipen 
    [Arguments]    ${url}
    Set Up Browser Fullscreen        
    New Page       ${url}
    Set Test Variable    ${URL_AUTH}    ${url}
    #Set Documentation Test Url Authentication    ${url} 
Get Code From Key Refresh Token 
    [Documentation]     Owner : sasipen
    ${code_refresh_token}    Get Value Response Ldap By Key    refresh_token
    Set Test Variable    ${CODE_REFRESH_TOKEN}    ${code_refresh_token} 

Create URL For Get Refresh Token
    [Documentation]     Owner : sasipen
    Wait Until Network Is Idle
    Get Code From Key Refresh Token 
    ${url_get_refresh_token}     Replace String      ${url_get_refresh_token_schema_dev}    _code_    ${CODE_REFRESH_TOKEN}  
    Set Test Variable    ${URL_GET_REFRESH_TOKEN}    ${url_get_refresh_token}
    Log    ${URL_GET_REFRESH_TOKEN}
    #Set Documentation Test Url Get Refresh Token    ${URL_GET_REFRESH_TOKEN}
Open Browser Login And Open Page Get Token 
    [Documentation]     Owner : sasipen
    [Arguments]    ${url}
    Create Browser Session   ${url}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}   
    Press Login Button
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}   


Get Value Response Ldap By Key
    [Documentation]     Owner : sasipen
    [Arguments]        ${response_key}
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json        
    ${value}           Set Variable    ${json_message.${response_key}} 
    [Return]     ${value}             
    
Get Value From Key Access Token
    [Documentation]     Owner : sasipen
    ${value}    Get Value Response Ldap By Key    access_token
    Set Test Variable    ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}    ${value} 

Set Content Header Ldap Logout
    [Documentation]     Owner : sasipen
    [Arguments]          ${url}    ${content_type}
    ${headers}           Replace String       ${header_ldap_schema}    _Content-Type_    ${content_type}            
    Set Test Variable    ${HEADER_LDAP_LOGOUT}    ${headers}
    Set Test Variable    ${URL}    ${url}
    Set Documentation Test Request    POST    ${URL}    
    Set Documentation Test Header    ${HEADER_LDAP_LOGOUT}

Set Body Ldap Logout
    [Documentation]     Owner : sasipen             {"access_token": "_access_token_", "state": "_state_"} 
    [Arguments]        ${state}    
    ${body_access_token_logout}        Replace String    ${body_ldap_schema}            _access_token_     ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}
    ${body_state}                      Replace String    ${body_access_token_logout}    _state_            ${state}           
    Set Test Variable        ${BODY_LDAP_LOGOUT}         ${body_state}      
    Set Documentation Test Body    ${BODY_LDAP_LOGOUT}

Send Request Ldap Logout
    Send Post Request    url=${URL}      headers=${HEADER_LDAP_LOGOUT}    body=${BODY_LDAP_LOGOUT}  

Verify Response State Ldap Logout
    [Arguments]        ${state} 
    Verify Value Response By Key    state        ${state} 
    # ${ACTUAL_RESULT}    Get Value Response By Key    state





































































































































































































































































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
    
LDAP Keywords Teardown
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Set Test Provisioning Data    User : ${USER}
    Set Test Provisioning Data    Password : ${PASS}
    Set Test Provisioning Data    Authentication URL : ${URL_AUTH}
    Set Test Provisioning Data    Get Token URL : ${URL_GET_TOKEN}
    Set Test Provisioning Data    Get Refresh Token URL : ${URL_GET_REFRESH_TOKEN}
    Set Test Documentation Detail
