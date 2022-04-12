*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content Header Client Credentials 
    [Documentation]     Owner : sasipen
    ...    Set header content type and url
    [Arguments]    ${url}     ${content_type}
    Set Schema API Header     ${header_client_credentials_schema}    
    Set Content API Header    key=${header_content_type}    value=${content_type}        append=False
    Set Test Variable         ${API_URL}       ${url}

Set Body Client Credentials
    [Documentation]     Owner : sasipen
    ...    Set client id,client secret,grant type, nonce to formate body 
    [Arguments]             ${client_id}      ${client_secret}    ${grant_type}   ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_schema}       jsonfile=False
    Set Content API Body    $..client_id        ${client_id}        append=False
    Set Content API Body    $..client_secret    ${client_secret}
    Set Content API Body    $..grant_type       ${grant_type}
    Set Content API Body    $..nonce            ${DATE_TIME}

Set Body Client Credentials Missing Client Id
    [Documentation]     Owner : sasipen
    ...    Set client secret,grant type, nonce to formate body
    [Arguments]             ${client_secret}    ${grant_type}    ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_missing_id_schema}       jsonfile=False
    Set Content API Body    $..client_secret    ${client_secret}               append=False
    Set Content API Body    $..grant_type       ${grant_type}
    Set Content API Body    $..nonce            ${DATE_TIME}

Set Body Client Credentials Missing Client Secret
    [Documentation]     Owner : sasipen
    ...    Set client id,grant type, nonce to formate body 
    [Arguments]             ${client_id}    ${grant_type}    ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_missing_secret_schema}       jsonfile=False
    Set Content API Body    $..client_id    ${client_id}                           append=False
    Set Content API Body    $..grant_type   ${grant_type}
    Set Content API Body    $..nonce        ${DATE_TIME}
 
Set Body Client Credentials Missing Grant Type
    [Documentation]     Owner : sasipen
    ...    Set client id,client secret,nonce to formate body 
    [Arguments]             ${client_id}    ${client_secret}    ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_missing_grant_type_schema}       jsonfile=False
    Set Content API Body    $..client_id        ${client_id}                           append=False
    Set Content API Body    $..client_secret    ${client_secret}
    Set Content API Body    $..nonce            ${DATE_TIME}

Send Request Client Credentials
    [Documentation]     Owner : sasipen 
    ...     Send request Post to api
    &{message}    Send Request    POST  url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]

Send Request Client Credentials Invalid
    [Documentation]     Owner : sasipen
    ...     Send request Post to api
    [Arguments]        ${status_code}    
    ${message}    Send Request    POST  url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]
    Set Test Variable    ${MESSAGE_RESPONSE}    ${message}[response]
 
Verify Response Client Credentials
    [Documentation]     Owner : sasipen
    ...    Verify response form value(fix) by key and Should Match Regexp value (change) 
    [Arguments]    ${expected_expires_in}
    ${token}       Get Value Response By Key     $..access_token
    Should Match Regexp             ${token}     .+  
    Verify Value Response By Key    $..token_type   ${expected_token_type}
    Verify Value Response By Key    $..expires_in   ${expected_expires_in}

Verify Response Client Credentials Error
    [Documentation]     Owner : sasipen
    ...    Verify response form value(fix) by key
    [Arguments]    ${error_message}
    Verify Value Response By Key    $..error    ${error_message}

Decode Token To Jwt Client Credentials
    [Documentation]     Owner : sasipen
    ...    Get value by key from response and decode by jwt
    ${value}            Get Value Response By Key    $..access_token
    ${jwt_decode}       Jwt Decode Dot Dict   ${value}
    Set Test Actual Result    Jwt decode : ${jwt_decode}
    Set Test Variable    ${RESPONSE_JWT_DECODE}    ${jwt_decode}

Verify Response Jwt Decode
    [Documentation]     Owner : sasipen
    Verify Response Decode Jwt By Key    $..iss
    Verify Response Decode Jwt By Key    $..sub
    Verify Response Decode Jwt By Key    $..aud
    Verify Response Decode Jwt By Key    $..exp
    Verify Response Decode Jwt By Key    $..iat
    Verify Response Decode Jwt By Key    $..jti
    Verify Response Decode Jwt By Key    $..client
    Verify Response Decode Jwt By Key    $..ssid
    
Verify Response Decode Jwt By Key
    [Documentation]     Owner : sasipen
    [Arguments]    ${response_key}    
    ${value}      Get Value Json By Key    ${RESPONSE_JWT_DECODE}    ${response_key}
    ${value}      Convert To String    ${value}
    Should Match Regexp    ${value}     .+
    Log    ${value}    
