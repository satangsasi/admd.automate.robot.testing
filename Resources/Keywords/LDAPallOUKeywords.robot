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
# Get Value Response LDAP By Key 
#     [Arguments]     ${response_key}
#     &{response_value}       Set Variable    ${RESPONSE_JSON_MESSAGE}
#     ${value_${response_key}}    Set Variable    ${response_value.${response_key}}

Verify Response Access Token Login LDAP
    [Arguments]           ${key_response_1}=${EMPTY}        ${key_response_2}=${EMPTY}            
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json 
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE}     
    IF    '${key_response_2}' != '${EMPTY}'
        Dictionary Should Contain Key    &{RESPONSE_JSON_MESSAGE}    access_token 
        ${value_${key_response_1}}       Set Variable    ${RESPONSE_JSON_MESSAGE.${key_response_1}}                
        Log      ${value_${key_response_1}} 
        Dictionary Should Contain Key          ${json_message}    id_token 
        ${value_${key_response_2}}       Set Variable    ${RESPONSE_JSON_MESSAGE.${key_response_2}}  
        Take Screenshot Verify Success Scene
    ELSE
        Dictionary Should Contain Key                 ${json_message}    access_token 
        ${value_${key_response_1}}       Set Variable    ${RESPONSE_JSON_MESSAGE.${key_response_1}} 
        # ${access_token_value}    Set Variable         ${json_message}[access_token]
        # Set Test Variable    ${ACCESS_TOKEN_LOGIN_LDAP}    ${access_token_value}  
        # Log      ${ACCESS_TOKEN_LOGIN_LDAP}
        # Set Test Variable    ${ACTUAL_RESULT_LOGIN}    access token login LDAP ${ACCESS_TOKEN_LOGIN_LDAP}
        Take Screenshot Verify Success Scene
    END
    #Set Actual Result Access Token Login And Refresh LDAP    actual_login=${ACTUAL_RESULT_LOGIN}

Verify Response Access Token Refresh LDAP
    [Arguments]           ${key_response_1}=${EMPTY}        ${key_response_2}=${EMPTY}            
    ${message}         Get Text    ${lbl_json_response_on_webpage} 
    &{json_message}    Evaluate    json.loads('''${message}''')    json        
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE}
    IF    '${key_response_2}' != '${EMPTY}'
        Dictionary Should Contain Key          ${json_message}    access_token 
        Dictionary Should Contain Key          ${json_message}    id_token 
        ${access_token_value}    Set Variable         ${json_message}[access_token]
        ${id_token_value}        Set Variable         ${json_message}[id_token]
        Set Test Variable    ${ACCESS_TOKEN_REFRESH_LDAP}    ${access_token_value}  
        Set Test Variable    ${ID_TOKEN_REFRESH_LDAP}        ${id_token_value}
        Log      ${ACCESS_TOKEN_REFRESH_LDAP}  
        Log      ${ID_TOKEN_REFRESH_LDAP}   
        Set Test Variable    ${ACTUAL_RESULT_REFRESH}    access token refresh LDAP ${ACCESS_TOKEN_REFRESH_LDAP}\r\nid token refresh LDAP ${ID_TOKEN_REFRESH_LDAP}       
        Take Screenshot Verify Success Scene
    ELSE
        Dictionary Should Contain Key                 ${json_message}    access_token 
        ${access_token_value}    Set Variable         ${json_message}[access_token]
        Set Test Variable    ${ACCESS_TOKEN_REFRESH_LDAP}    ${access_token_value}  
        Log      ${ACCESS_TOKEN_REFRESH_LDAP}
        Set Test Variable    ${ACTUAL_RESULT_REFRESH}    access token refresh LDAP ${ACCESS_TOKEN_REFRESH_LDAP}
        Take Screenshot Verify Success Scene
    END
    Set Actual Result Access Token Login And Refresh LDAP    ${ACTUAL_RESULT_LOGIN}    ${ACTUAL_RESULT_REFRESH}    

Set Actual Result Access Token Login And Refresh LDAP    
    [Arguments]          ${actual_login}=${EMPTY}        ${actual_refresh}=${EMPTY} 
    Set Test Variable    ${ACTUAL_RESULT}         ${actual_login}\r\n${actual_refresh}    

Open Browser And Login 
    [Arguments]            ${type_url_authentication}
    Set Up Browser Fullscreen        
    New Page                      ${type_url_authentication}      
    Fill Username And Password    ${user_provider}         ${pass_provider}  
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

 ${access_token_value}    Set Variable         ${json_message}[access_token]
        ${id_token_value}        Set Variable         ${json_message}[id_token]
        Set Test Variable    ${ACCESS_TOKEN_LOGIN_LDAP}    ${access_token_value}  
        Set Test Variable    ${ID_TOKEN_LOGIN_LDAP}        ${id_token_value}
        Log      ${ACCESS_TOKEN_LOGIN_LDAP}   
        Log      ${ID_TOKEN_LOGIN_LDAP}  
        Set Test Variable    ${ACTUAL_RESULT_LOGIN}    access token login LDAP ${ACCESS_TOKEN_LOGIN_LDAP}\r\nid token login LDAP ${ID_TOKEN_LOGIN_LDAP}      
        Take Screenshot Verify Success Scene


















































































































































































































































































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
    ${actual_error_title}      Get Text    ${lbl_error_title}
    ${actual_error_message}    Get Text    ${lbl_error_message}
    Set Test Variable    ${ACTUAL_RESULT}    '${actual_error_title}\r\n${actual_error_message}'
