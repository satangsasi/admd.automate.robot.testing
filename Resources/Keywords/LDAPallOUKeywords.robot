*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Create URL For Get Token
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Append Token(get from Auth Url) to get Token(API) Url
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_get_token_schema}    _code_    ${CODE}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}

Get Code From Authentication
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Get Code Token From Url Then Return to Set Test Variable ${CODE}
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    ${url_auth_access}    Wait Until Keyword Succeeds    ${verify_timeout}    10ms    Get Url    matches    .*code=
    ${code}    Split String         ${url_auth_access}    =
    ${code}    Set Variable         ${code}[1]
    Set Test Variable    ${CODE}    ${code}

Set Response On Webpage To Json
    [Documentation]     Owner : sasipen
    ...    Get text form webpage and change it to json message Then Return to &{RESPONSE_JSON_MESSAGE}
    ${message}           Get Text    ${lbl_json_response_on_webpage}
    &{json_message}      Evaluate    json.loads('''${message}''')    json
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Log Many             &{RESPONSE_JSON_MESSAGE}
    Take Screenshot Verify Success Scene
Get Value Response Ldap By Key
    [Documentation]     Owner : sasipen
    ...    Get value from key in &{RESPONSE_JSON_MESSAGE} Then Return to value
    [Arguments]    ${response_key}
    ${value}       Set Variable    ${RESPONSE_JSON_MESSAGE.${response_key}}
    [Return]       ${value}

Get Value Response Ldap 
    [Documentation]     Owner : sasipenkey 
    ...    Get value By Key in &{RESPONSE_JSON_MESSAGE} Then Return to ${value_token_type}
    ...    Set value to global for use in keyword verify
    ${value_token_type}    Get Value Response Ldap By Key    token_type
    Set Test Variable    ${ACTUAL_VALUE_TOKEN_TYPE}    ${value_token_type} 
    ${value_expires_in}    Get Value Response Ldap By Key    expires_in
    Set Test Variable    ${ACTUAL_VALUE_EXPIRES_IN}    ${value_expires_in}
    ${value_refresh_token_expires_in}    Get Value Response Ldap By Key    refresh_token_expires_in
    Set Test Variable    ${ACTUAL_VALUE_REFRESH_TOKEN_EXPIRES_IN}    ${value_refresh_token_expires_in}

Set Data Response Ldap For Verify
    [Documentation]     Owner : sasipen
    ...    group keyword for set data before use keyword verify
    Set Response On Webpage To Json
    Get Value Response Ldap 
    
Verify Response Ldap
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    login with scope=profile
    ...    Verify value (change) By Key access token,refresh token,id token use Should Match Regexp
    ...    Verify value (fix) by text actual=expected
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
    
Decode Login Token Jwt By Key Access Token
    [Documentation]     Owner : sasipen
    ...    Get value state login By Key access token for decode in keywode Jwt Decode form BuiltinLibrary_CommonKeywords
    ${value}         Get Value Response Ldap By Key    access_token
    ${jwt_decode}    Jwt Decode      ${value} 
    Set Test Variable         ${JWT_DECODE_ACCESS_TOKEN}      ${jwt_decode} 
    Set Test Actual Result    Login access token jwt decode : ${jwt_decode} 

Decode Login Token To Jwt By Key Id Token
    [Documentation]     Owner : sasipen
    ...    Get value state login By Key id token for decode in keywode Jwt Decode form BuiltinLibrary_CommonKeywords
    ${value}         Get Value Response Ldap By Key    id_token 
    ${jwt_decode}    Jwt Decode      ${value}
    Set Test Variable         ${JWT_DECODE_ID_TOKEN}      ${jwt_decode}
    Set Test Actual Result    Login id token jwt decode : ${jwt_decode}  

Decode Refresh Token To Jwt By Key Access Token
    [Documentation]     Owner : sasipen
    ...    Get value state refresh By Key access token for decode in keywode Jwt Decode form BuiltinLibrary_CommonKeywords
    ${value}         Get Value Response Ldap By Key    access_token
    ${jwt_decode}    Jwt Decode      ${value} 
    Set Test Variable         ${JWT_DECODE_REFRESH__ACCESS_TOKEN}      ${jwt_decode} 
    Set Test Actual Result    Refresh access token jwt decode : ${jwt_decode} 

Decode Refresh Token To Jwt By Key Id Token
    [Documentation]     Owner : sasipen
    ...    Get value state refresh By Key id token for decode in keywode Jwt Decode form BuiltinLibrary_CommonKeywords
    ${value}         Get Value Response Ldap By Key    id_token 
    ${jwt_decode}    Jwt Decode      ${value}
    Set Test Actual Result    Refresh id token jwt decode : ${jwt_decode}  
    Set Test Variable         ${JWT_DECODE_REFRESH__ID_TOKEN}      ${jwt_decode}

Verify Response Decode Refresh Token By Key Access Token
    [Documentation]     Owner : sasipen
    [Arguments]    ${login_subtype}  
    ${actual_value_action}    Get Refresh Value Response Jwt By Key Access Token    aut.action
    Verify Value Should Be Equal    ${actual_value_action}    ${expected_action_refresh}   
    Verify Response Login Subtype Decode Jwt    access_token    ${login_subtype}    refresh
    Verify Refresh Value Response Access Token Decode Jwt by Key    iss
    Verify Refresh Value Response Access Token Decode Jwt by Key    sub
    Verify Refresh Value Response Access Token Decode Jwt by Key    aud
    Verify Refresh Value Response Access Token Decode Jwt by Key    iat
    Verify Refresh Value Response Access Token Decode Jwt by Key    pid

Verify Response Decode Refresh Token By Key Id Token
    [Documentation]     Owner : sasipen
    [Arguments]    ${login_subtype}
    ${actual_value_action}    Get Refresh Value Response Jwt By Key Id Token    aut.action
    Verify Value Should Be Equal    ${actual_value_action}    ${expected_action_refresh}   
    Verify Response Login Subtype Decode Jwt    id_token    ${login_subtype}    refresh
    Verify Refresh Value Response Id Token Decode Jwt by Key    iss
    Verify Refresh Value Response Id Token Decode Jwt by Key    sub
    Verify Refresh Value Response Id Token Decode Jwt by Key    aud
    Verify Refresh Value Response Id Token Decode Jwt by Key    iat

Verify Response Decode Login Token By Key Access Token
    [Documentation]     Owner : sasipen
    ...    verify text value By Key action form value access token state login = expected text 
    [Arguments]    ${action_type}      ${login_subtype}
    Verify Response Action Type Decode Jwt By Key    access_token    ${action_type}
    Verify Response Login Subtype Decode Jwt    access_token    ${login_subtype}    login 
    Verify Value Response Access Token Decode Jwt by Key    iss
    Verify Value Response Access Token Decode Jwt by Key    sub
    Verify Value Response Access Token Decode Jwt by Key    aud
    Verify Value Response Access Token Decode Jwt by Key    iat
    Verify Value Response Access Token Decode Jwt by Key    pid

Verify Response Decode Login Token By Key Id Token
    [Documentation]     Owner : sasipen
    ...    verify text value By Key action form value id token state login = expected text 
    [Arguments]    ${action_type}      ${login_subtype}
    Verify Response Action Type Decode Jwt By Key    id_token    ${action_type}
    Verify Response Login Subtype Decode Jwt    id_token    ${login_subtype}    login
    Verify Value Response Id Token Decode Jwt by Key    iss
    Verify Value Response Id Token Decode Jwt by Key    sub
    Verify Value Response Id Token Decode Jwt by Key    aud
    Verify Value Response Id Token Decode Jwt by Key    iat

Verify Response Ldap No Scope Profile
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    login with don't have scope=profile
    ...    Verify value (change) By Key access token,refresh token use should match regexp
    ...    Verify value (fix) by text actual=expected
    ...    ***Editor Note***
    ...    - Add Set Test Actual Result
    Verify Value Response Ldap By Key   access_token 
    Verify Value Response Ldap By Key   refresh_token 
    Verify Value Should Be Equal    ${ACTUAL_VALUE_TOKEN_TYPE}     ${expected_token_type}
    Verify Value Should Be Equal    ${ACTUAL_VALUE_EXPIRES_IN}     ${expected_expires_in_ldap}
    Verify Value Should Be Equal    ${ACTUAL_VALUE_REFRESH_TOKEN_EXPIRES_IN}    ${expected_refresh_token_expires_in_ldap}
    Take Screenshot Verify Success Scene 
    Set Test Actual Result    Token : ${RESPONSE_JSON_MESSAGE}

Verify Value Response Ldap By Key 
    [Documentation]     Owner : sasipen
    ...    After get text and change to json message verify value By Key use should match regexp
    [Arguments]   ${response_key}
    ${value}     Get Value Response Ldap By Key    ${response_key}
    Should Match Regexp    ${value}     .+
    Log    ${value}

Create Browser Session
    [Documentation]     Owner : sasipen
    ...    Setting browser and open url 
    ...    Set url to global for create provisioning data
    [Arguments]    ${url}
    Set Up Browser Fullscreen    
    New Page       ${url}
    Set Test Variable    ${URL_AUTH}    ${url}
    Wait Until Network Is Idle

Get Code From Key Refresh Token 
    [Documentation]     Owner : sasipen
    ...    Get value By Key refresh token after use link get token
    ...    Set value to global for create link get refresh token
    ${code_refresh_token}    Get Value Response Ldap By Key    refresh_token
    Set Test Variable    ${CODE_REFRESH_TOKEN}    ${code_refresh_token} 

Create URL For Get Refresh Token
    [Documentation]     Owner : sasipen
    ...    Append ${CODE_REFRESH_TOKEN}(link get refresh token) to get refresh token Url 
    Wait Until Network Is Idle
    Get Code From Key Refresh Token
    ${url_get_refresh_token}     Replace String      ${url_get_refresh_token_schema_${test_site}}    _code_    ${CODE_REFRESH_TOKEN}
    Set Test Variable    ${URL_GET_REFRESH_TOKEN}    ${url_get_refresh_token}
    Log    ${URL_GET_REFRESH_TOKEN}

Open Browser Login And Open Page Get Token
    [Documentation]     Owner : sasipen
    ...    Group keyword open url, fill uesr and pass , press login. create url for get token of content provider  
    [Arguments]    ${url}
    Create Browser Session   ${url}
    Fill Username And Password    ${user_ldap_provider}    ${pass_ldap_provider}   
    Press Login Button
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}

Get Value From Key Access Token
    [Documentation]     Owner : sasipen
    ...    Get value By Key access token form file json message state logout
    ${value}    Get Value Response Ldap By Key    access_token
    Set Test Variable    ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}    ${value} 

Set Content Header Ldap Logout
    [Documentation]     Owner : sasipen
    ...    Append valiable to set header schema state logout 
    ...    Set url to global for create provisioning data
    [Arguments]          ${url}    ${content_type}
    ${headers}           Replace String       ${header_ldap_schema}    _Content-Type_    ${content_type}
    Set Test Variable    ${API_HEADER}    ${headers}
    Set Test Variable    ${API_URL}       ${url}

Set Body Ldap Logout
    [Documentation]     Owner : sasipen
    ...   Append value By Key access token to set body schema state logout 
    ...   Set url to global for create provisioning data
    [Arguments]        ${state}
    ${body_access_token_logout}    Replace String    ${body_ldap_schema}            _access_token_     ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}
    ${body_state}                  Replace String    ${body_access_token_logout}    _state_            ${state}
    Set Test Variable              ${API_BODY}       ${body_state}

Send Post Request Ldap Logout
    [Documentation]     Owner : sasipen
    ...    send request api form data
    Send Post Request    url=${API_URL}      headers=${API_HEADER}    body=${API_BODY}

Verify Response State Ldap Logout
    [Documentation]     Owner : sasipen
    ...    Verify value By Key state = expected
    ...    Set respones to Actual Result 
    [Arguments]        ${expected_state}
    Verify Value Response By Key    state        ${expected_state}
    ${autual_value_state}    Get Value Response By Key    state
    Set Test Actual Result    "state" : "${autual_value_state}"

Open Browser Login Employee And Open Page Get Token
    [Documentation]     Owner : sasipen
    ...    Group keyword open url, fill uesr and pass , press login. create url for get token of employee
    [Arguments]    ${url}
    Create Browser Session   ${url}
    Fill Username And Password    ${user_ldap_employee}    ${pass_ldap_employee}
    Press Login Button
    Create URL For Get Token
    New Page                 ${URL_GET_TOKEN}

Get Value Response Jwt By Key Access Token
    [Documentation]     Owner : sasipen
    ...    Change response form jwt to json message 
    ...    Get value By Key...in key aut form access toeken in json message 
    [Arguments]    ${response_key} 
    ${value}       Get Value Json By Key    ${JWT_DECODE_ACCESS_TOKEN}    ${response_key}
    [Return]       ${value}
    
Verify Value Response Access Token Decode Jwt by Key
    [Arguments]    ${response_key}
    ${value}    Get Value Response Jwt By Key Access Token    ${response_key}
    ${value}    Convert To String    ${value}
    Should Match Regexp    ${value}     .+
    Log    ${value}
    
Get Value Response Jwt By Key Id Token
    [Documentation]     Owner : sasipen
    ...    Change response form jwt state login to json message 
    ...    Get value By Key...in key aut form id toeken in json message 
    [Arguments]    ${response_key}    
    ${value}       Get Value Json By Key    ${JWT_DECODE_ID_TOKEN}    ${response_key}
    [Return]       ${value}

Verify Value Response Id Token Decode Jwt by Key
    [Arguments]    ${response_key}
    ${value}    Get Value Response Jwt By Key Id Token    ${response_key}
    ${value}    Convert To String    ${value}
    Should Match Regexp    ${value}     .+
    Log    ${value}

Get Refresh Value Response Jwt By Key Access Token 
    [Documentation]     Owner : sasipen
    ...    Change response form jwt state refresh to json message 
    ...    Get value By Key...in key aut form access toeken in json message 
    [Arguments]    ${response_key} 
    ${value}       Get Value Json By Key      ${JWT_DECODE_REFRESH_ACCESS_TOKEN}    ${response_key}   
    [Return]       ${value}

Verify Refresh Value Response Access Token Decode Jwt by Key
    [Arguments]    ${response_key}
    ${value}       Get Refresh Value Response Jwt By Key Access Token    ${response_key}
    ${value}    Convert To String    ${value}
    Should Match Regexp    ${value}     .+
    Log    ${value}

Get Refresh Value Response Jwt By Key Id Token 
    [Documentation]     Owner : sasipen
    ...    Change response form jwt state refresh to json message 
    ...    Get value By Key...in key aut form id toeken in json message 
    [Arguments]    ${response_key} 
    ${value}       Get Value Json By Key      ${JWT_DECODE_REFRESH_ID_TOKEN}    ${response_key}
    [Return]       ${value}

Verify Refresh Value Response Id Token Decode Jwt by Key
    [Arguments]    ${response_key}
    ${value}       Get Refresh Value Response Jwt By Key Id Token    ${response_key}
    ${value}    Convert To String    ${value}
    Should Match Regexp    ${value}     .+
    Log    ${value}

Verify Response Login Subtype Decode Jwt
    [Documentation]     Owner : sasipen
    ...    Verify value by login subtype and then verify   
    ...    Value by key login subtype of Content Provider = ldapCp
    ...    Value by key login subtype of Employee = ldapEmployee 
    [Arguments]    ${response_key}    ${login_subtype}    ${state_test}
    IF    '${login_subtype}' == 'Content Provider'
        IF     '${response_key}' == 'access_token'
            ${actual_value_login_subtype}    Get Value From Login Subtype For Verify Response Access Token     ${state_test}
            Verify Value Should Be Equal     ${actual_value_login_subtype}    ${expected_value_login_subtype_cp}
        ELSE IF     '${response_key}' == 'id_token'
            ${actual_value_login_subtype}    Get Value From Login Subtype For Verify Response Id Token     ${state_test}
            Verify Value Should Be Equal     ${actual_value_login_subtype}    ${expected_value_login_subtype_cp}
        END
    ELSE IF  '${login_subtype}' == 'Employee'
        IF     '${response_key}' == 'access_token' 
            ${actual_value_login_subtype}    Get Value From Login Subtype For Verify Response Access Token     ${state_test}
            Verify Value Should Be Equal     ${actual_value_login_subtype}    ${expected_value_login_subtype_employee}
        ELSE IF    '${response_key}' == 'id_token' 
            ${actual_value_login_subtype}    Get Value From Login Subtype For Verify Response Id Token     ${state_test}
            Verify Value Should Be Equal     ${actual_value_login_subtype}    ${expected_value_login_subtype_employee}
        END    
    END

Get Value From Login Subtype For Verify Response Access Token 
    [Documentation]     Owner : sasipen
    ...    Get value By Key login subtype form access toekn state login or refresh
    [Arguments]    ${state_test} 
    IF    '${state_test}' == 'login'
        ${actual_value_login_subtype}    Get Value Response Jwt By Key Access Token     aut.login_subtype
    ELSE IF    '${state_test}' == 'refresh'
        ${actual_value_login_subtype}    Get Refresh Value Response Jwt By Key Access Token      aut.login_subtype
    END     
    [Return]    ${actual_value_login_subtype}

Get Value From Login Subtype For Verify Response Id Token 
    [Documentation]     Owner : sasipen
    ...    Get value By Key login subtype form id toekn state login or refresh
    [Arguments]    ${state_test} 
    IF    '${state_test}' == 'login'
        ${actual_value_login_subtype}    Get Value Response Jwt By Key Id Token     aut.login_subtype
    ELSE IF    '${state_test}' == 'refresh'
        ${actual_value_login_subtype}    Get Refresh Value Response Jwt By Key Id Token      aut.login_subtype
    END     
    [Return]   ${actual_value_login_subtype}

Verify Response Action Type Decode Jwt By Key
    [Documentation]     Owner : sasipen
    ...    Verify value By Key action form key access token or id token type login or sso in json message
    ...    Value By Key action of login = login
    ...    Value By Key action of sso = sso
    [Arguments]    ${response_key}    ${action_type}
    IF    '${response_key}' == 'access_token'
        ${actual_value_action}    Get Value Response Jwt By Key Access Token    aut.action
        IF    '${action_type}' == 'login'     
        Verify Value Should Be Equal    ${actual_value_action}    ${expected_action_login} 
        ELSE IF    '${action_type}' == 'sso'      
        Verify Value Should Be Equal    ${actual_value_action}    ${expected_action_sso}
        END  
    ELSE IF    '${response_key}' == 'id_token'      
        ${actual_value_action}    Get Value Response Jwt By Key Id Token    aut.action
        IF    '${action_type}' == 'login'     
        Verify Value Should Be Equal    ${actual_value_action}    ${expected_action_login} 
        ELSE IF   '${action_type}' == 'sso'      
        Verify Value Should Be Equal    ${actual_value_action}    ${expected_action_sso}
        END
    END

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

Wait For Authentication Code Expire
    [Documentation]    Owner: Nakarin
    ...    Wait for Token(from Auth Url) Expire about in 5 min
    [Tags]    keyword_communicate
    Sleep    5m

Verify Login Fail
    [Documentation]    Owner: Nakarin
    ...    Verify Text shown on webpage
    ...    Title: "Wrong Username or Password"
    ...    Message: "Please check your Username or Password."
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
    ...    Verify Text of json show on webpage : {"error":"invalid_request"}
    [Tags]    keyword_communicate   
    ${json_error_message}      Get Text    ${lbl_json_response_on_webpage}
    Verify Value At Locator    ${lbl_json_response_on_webpage}    ${json_error_message_invalid_request}
    Take Screenshot Verify Success Scene
    Set Test Actual Result     ${json_error_message}

Verify Invalid Grant On Webpage
    [Documentation]    Owner: Nakarin
    ...    Verify Text of json show on webpage : {"error":"invalid_grant"}
    [Tags]    keyword_communicate
    ${json_error_message}      Get Text    ${lbl_json_response_on_webpage}
    Verify Value At Locator    ${lbl_json_response_on_webpage}    ${json_error_message_invalid_grant}
    Take Screenshot Verify Success Scene
    Set Test Actual Result     ${json_error_message}

Verify Response Decrypted Pid Ldap Content Provider Snake Case
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Value Response By Key    result_code          ${expected_result_code_pass}
    Verify Value Response By Key    developer_message    ${expected_develope_messagee_pass}
    Verify Value Response By Key    private_id           ${expected_private_id_cp_pass}
    Verify Value Response By Key    partner_id           ${expected_partner_id_pass}
    Verify Value Response By Key    public_id            ${expected_public_id_cp_pass}
    Set Test Actual Result          DecyptedPartnerSpecificPrivateId :\n\r${RESPONSE.json()}

Verify Response Decrypted Pid Ldap Content Provider Camel Case
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Value Response By Key    resultCode          ${expected_result_code_pass}
    Verify Value Response By Key    developerMessage    ${expected_develope_messagee_pass}
    Verify Value Response By Key    privateId           ${expected_private_id_cp_pass}
    Verify Value Response By Key    partnerId           ${expected_partner_id_pass}
    Verify Value Response By Key    publicId            ${expected_public_id_cp_pass}
    Set Test Actual Result          DecyptedPartnerSpecificPrivateId :\n\r${RESPONSE.json()}

Get Json Log Ldap From Server 
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Get Json Log From output of SSH Command
    ...    edit message grep > error
    [Tags]    keyword_commands
    SSH Connect To 10.137.30.22
    Write    kubectl exec -it admd-v3-2-dev-686b4cc7-ddlgw -n admd sh
    Write    cd logs/detail/
    Write    cat admd-v3-2-dev-686b4cc7-ddlgw_admd.0.detail | grep -E "aaf.post_authenticate_ldap.*error"   
    ${string}   Read    delay=1s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    ${json_expect}    Convert String to JSON    ${json_format}[0]
    Log    ${json_expect}
    Set Test Variable    ${JSON_EXPECT}    ${json_expect}

Verify Value Log Error From Server 
    [Documentation]    Owner: Sasipen
    ...    verify Value from key error by Json file from SSH Command
    [Tags]    keyword_commands
    [Arguments]    ${error_message}
    Verify Value Json By Key    ${JSON_EXPECT}    custom.Output[0].Data.Body.error    ${error_message}
    



























































































































































#------------------------------sasipen-------------------------
Send Get Request LDAP 
    [Documentation]     Owner : sasipen 
    [Arguments]          ${url}
    Send Get Request     url=${url}
    Set Test Variable    ${API_URL}       ${url}
Verify Response Decrypted Pid Ldap Employee Snake Case
    [Documentation]     Owner : sasipen 
    Verify Value Response By Key    result_code          ${expected_result_code_pass}
    Verify Value Response By Key    developer_message    ${expected_develope_messagee_pass} 
    Verify Value Response By Key    private_id           ${expected_private_id_emp_pass}
    Verify Value Response By Key    partner_id           ${expected_partner_id_pass}
    Verify Value Response By Key    public_id            ${expected_public_id_emp_pass}    
    Set Test Actual Result          DecyptedPartnerSpecificPrivateId :\n\r${RESPONSE.json()}
Verify Response Decrypted Pid Ldap Employee Camel Case
    [Documentation]     Owner : sasipen 
    Verify Value Response By Key    resultCode          ${expected_result_code_pass}
    Verify Value Response By Key    developerMessage    ${expected_develope_messagee_pass} 
    Verify Value Response By Key    privateId           ${expected_private_id_emp_pass} 
    Verify Value Response By Key    partnerId           ${expected_partner_id_pass}
    Verify Value Response By Key    publicId            ${expected_public_id_emp_pass}    
    Set Test Actual Result          DecyptedPartnerSpecificPrivateId :\n\r${RESPONSE.json()}
Send Post Request LDAP
    [Documentation]     Owner : sasipen 
    Send Post Request    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}
    
   