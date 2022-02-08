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
Verify Response Access Token Login LDAP
    [Arguments]           ${key_response_1}=${EMPTY}        ${key_response_2}=${EMPTY} 
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json 
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE} 
    IF    '${key_response_2}' != '${EMPTY}'
        Dictionary Should Contain Key    ${RESPONSE_JSON_MESSAGE}   access_token 
        Dictionary Should Contain Key    ${RESPONSE_JSON_MESSAGE}   id_token 
        ${access_token_value_login}   Verify Value Response LDAP By Key   access_token  
        ${id_token_value_login}       Verify Value Response LDAP By Key   id_token 
        Take Screenshot Verify Success Scene
    ELSE
        Dictionary Should Contain Key    ${RESPONSE_JSON_MESSAGE}    access_token 
        ${access_token_value_login}     Verify Value Response LDAP By Key    access_token  
        Take Screenshot Verify Success Scene
    END
    Set Test Variable    ${ACTUAL_RESULT}        &{RESPONSE_JSON_MESSAGE}    
Verify Response Access Token Refresh LDAP
    [Arguments]           ${key_response_1}=${EMPTY}        ${key_response_2}=${EMPTY}            
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json        
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE}
    IF    '${key_response_2}' != '${EMPTY}'
        Dictionary Should Contain Key    ${RESPONSE_JSON_MESSAGE}    access_token 
        Dictionary Should Contain Key    ${RESPONSE_JSON_MESSAGE}    id_token 
        ${access_token_value_refresh}    Verify Value Response LDAP By Key   access_token  
        ${id_token_value_refresh}        Verify Value Response LDAP By Key   id_token 
        Take Screenshot Verify Success Scene
    ELSE
        Dictionary Should Contain Key    ${RESPONSE_JSON_MESSAGE}     access_token 
        ${access_token_value_refresh}    Verify Value Response LDAP By Key   access_token  
        Take Screenshot Verify Success Scene
    END
    Set Test Variable    ${ACTUAL_RESULT}        &{RESPONSE_JSON_MESSAGE}  

Verify Value Response LDAP By Key 
    [Arguments]   ${key}
    ${value}    Set Variable    ${RESPONSE_JSON_MESSAGE.${key}} 
    Should Match Regexp    ${value}     .+
    [Return]    ${value}

Set Response Login To Actual Result Login  
    [Arguments]    ${value_1}=${EMPTY}        ${value_2}=${EMPTY}    
    IF    '${value_2}' != '${EMPTY}'
        Set Test Variable    ${ACTUAL_RESULT_LOGIN}    access token login LDAP ${value_1}\r\nid token login LDAP ${value_2}      
    ELSE
        Set Test Variable    ${ACTUAL_RESULT_LOGIN}    access token login LDAP ${value_1}
    END

Set Response Refresh To Actual Result Refresh
    [Arguments]    ${value_1}=${EMPTY}        ${value_2}=${EMPTY}    
    IF    '${value_2}' != '${EMPTY}'
        Set Test Variable    ${ACTUAL_RESULT_REFRESH}    access token refresh LDAP ${value_1}\r\nid token refresh LDAP ${value_2}      
    ELSE
        Set Test Variable    ${ACTUAL_RESULT_REFRESH}    access token refresh LDAP ${value_1}
    END

Append Response Login And Refresh To Actual Result  
    [Arguments]          ${actual_login}=${EMPTY}        ${actual_refresh}=${EMPTY} 
    Set Test Variable    ${ACTUAL_RESULT}         ${actual_login}\r\n${actual_refresh}    

Open Browser And Login 
    [Arguments]            ${type_url_authentication}
    Set Up Browser Fullscreen        
    New Page                      ${type_url_authentication}      
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}    
    Press Login Button

Get Code From Key Refresh Token 
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json 
    ${access_token}    Set Variable            ${json_message}[access_token]
    Log     ${access_token}   
    ${code_refresh_token}    Set Variable         ${json_message}[refresh_token]
    Log    ${code_refresh_token}   
    Set Test Variable    ${CODE_REFRESH_TOKEN}    ${code_refresh_token} 

Create URL For Get Refresh Token
    Wait Until Network Is Idle
    Get Code From Key Refresh Token 
    ${url_get_refresh_token}     Replace String      ${url_get_refresh_token_schema_dev}    _code_    ${CODE_REFRESH_TOKEN}  
    Set Test Variable    ${URL_GET_REFRESH_TOKEN}    ${url_get_refresh_token}
    Log    ${URL_GET_REFRESH_TOKEN}   

Open Browser Login And Open Page Get Token 
    [Arguments]    ${type_url_authentication}
    Open Browser And Login   ${type_url_authentication}
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}   

Get Value From Access Token
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json        
    ${value_access_token}    Set Variable     ${json_message.access_ken}
    Set Test Variable    ${ACCESS_TOKEN_FOR_LOGOUT}    ${value_access_token} 














































































































































































































































































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
    Append Text Login Fail To Actual Result
Append Text Login Fail To Actual Result
    [Documentation]    Owner: Nakarin
    # [Arguments]     ${list_variable}    ${locator}
    ${actual_error_title}      Get Text    ${lbl_error_title}
    ${actual_error_message}    Get Text    ${lbl_error_message}
    Set Test Variable    ${ACTUAL_RESULT}    '${actual_error_title}\r\n${actual_error_message}'
    # ${text}    Get Text     ${locator}
    # Append To List    ${list_variable}    ${text}

