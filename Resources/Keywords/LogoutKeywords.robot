*** Settings ***
Resource    ../../TestSuite/Resource_init.robot

*** Keywords ***
Set Body Ldap Logout With Client Id
    [Documentation]     Owner : sasipen
    ...   Append value By Key access token to set body schema state logout 
    ...   Set url to global for create provisioning data
    Set Content API Body    $..access_token       ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}    append=False
    Set Content API Body    $..client_id          ${client_id_X6jpU}     
    Set Content API Body    $..state              ${state_logout_ldap_employee}

Set Body Ldap Logout With Invalid Client Id
    [Documentation]     Owner : sasipen
    ...   Append value By Key access token to set body schema state logout 
    ...   Set url to global for create provisioning data
    Set Content API Body    $..access_token       ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}    append=False
    Set Content API Body    $..client_id          ${invalid_client_id_PK+WUA}     
    Set Content API Body    $..state              ${state_logout_ldap_employee}



































Fill Username And Password Login Page 
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Type Text    ${txt_username_ldap}      ${user_ldap_employee}       delay=0.1s
    Type Text    ${txt_password_ldap}      ${pass_ldap_employee}       delay=0.1s
    Set Test Provisioning Data   Username: ${user_ldap_employee}
    Set Test Provisioning Data   Password: ${pass_ldap_employee}
    Set Test Variable       ${USERNAME}       ${user_ldap_employee} 

Press Login Button In Page 
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    ${stamp_minutes}    Check Time Minutes
    Click       ${btn_login_ldap}
    Wait Until Network Is Idle      ${verify_timeout}
    [Teardown]    Get AAF5G Log    ${stamp_minutes}

Set API Header Logout
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_x_www}    append=False
    Set Test Variable         ${URL_LOGOUT}         ${url_logout} 

Set API Body Logout Expired Access Token
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Get Time Nonce
    Set Content API Body        $..access_token         ${expired_access_token_logout}     
    Set Content API Body        $..state                ${value_satae_logout_expired}
    Set Content API Body        $..nonce                ${DATE_TIME}

Send Post Request Logout
    [Documentation]    Owner: Atitaya
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    url=${URL_LOGOUT}     headers=${API_HEADER}    body=${API_BODY}   expected_status=${status_code}    verify=${ssl_verify} 
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]

Get Json Error Log Logout From Server
    [Documentation]
    [Tags]    keyword_commands
    Switch Connection  ${SSH_ADMD}
    Write    cat ${ADMD_PATH} | grep -E "Body.*data_not_found"
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log Many   @{json_format}
    &{json_expect}    Convert Variable Type To Dot Dict    ${json_format}[0]
    Log Many    &{json_expect}
    Set Test Variable    &{JSON_EXPECT}    &{json_expect}
    Set Test Actual Result    ADMD V3.2 Log: ${json_expect}

Verify Json Error Log Logout From Server
    [Documentation]    Owner:Atitaya 
    [Tags]    keyword_commands
    Verify Value Json By Key    ${JSON_EXPECT}    $..custom.Input[0].Data.Body.resultCode          ${expected_result_code_40401}     
    Verify Value Json By Key    ${JSON_EXPECT}    $..custom.Input[0].Data.Body.developerMessage    ${expected_developer_message_not_found}    

Verify Response Logout Expired Access Token
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Verify Value Response By Key        $..state        ${value_satae_logout_expired}

Set API Body Logout Incorrect Access Token
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Get Time Nonce
    Set Content API Body        $..access_token         ${incorrect_access_token_logout}
    Set Content API Body        $..error                ${error_message_invalid_code}
    Set Content API Body        $..nonce                ${DATE_TIME}

Verify Response Logout Incorrect Access Token
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    ${access_token}   Get Value Response On Web Page By Key    $..access_token
    Verify Value Should Not Be Equal    ${incorrect_access_token_logout}    ${access_token}
    Verify Value Response By Key        $..error        ${error_message_invalid_code}

Set API Body Logout Missing Access Token
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Get Time Nonce
    Set Content API Body        $..error        ${error_message_invalid_request}
    Set Content API Body        $..nonce        ${DATE_TIME}

Verify Response Logout Missing Access Token
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Verify Value Response By Key        $..error        ${error_message_invalid_request}

Set API Body Invalid URL Logout
    [Documentation]    Owner: Atitaya
    [Tags]    Keyword_communicate
    Get Time Nonce
    ${access_token}    Get Value Response On Web Page By Key       $..access_token
    Set Content API Body        $..access_token         ${access_token}
    Set Content API Body        $..state                ${state_logout_ldap_employee}
    Set Content API Body        $..nonce                ${DATE_TIME}

Send Post Request Invalid URL 
    [Documentation]    Owner: Atitaya
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    url=${invalid_url_aut_logout}     headers=${API_HEADER}    body=${API_BODY}   expected_status=${status_code}    verify=${ssl_verify} 
    Set Test Provisioning Data    Request URL Invalid : ${message}[request]
    Set Test Actual Result        Request URL Invalid : ${message}[response]

Verify Response Logout Feature With Unknow URL 
    [Documentation]    Owner: Atitaya
    [Tags]      keyword_communicate      
    Verify Value Response By Key        $..error        ${error_message_invalid_request}
