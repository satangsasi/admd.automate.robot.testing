*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Get Time Nonce
    [Documentation]   Owner : sasipen
    ${current_date_time}    Get Current Date    result_format=%Y%m%d %H:%M:%S.%f      
    Set Test Variable       ${DATE_TIME}    ${current_date_time}

Set Content Header Client Credentials 
    [Documentation]     Owner : sasipen
    ...    Set header content type and url
    [Arguments]          ${url}           ${content_type}
    Set Schema API Header     ${header_client_credentials_schema}    jsonfile=False
    Set Content API Header    Content-Type    ${content_type}        append=False
    # ${headers}           Replace String   ${header_client_credentials_schema}    _Content-Type_    ${content_type}
    # Set Test Variable    ${API_HEADER}    ${headers}
    Set Test Variable    ${API_URL}       ${url}

Set Body Client Credentials
    [Documentation]     Owner : sasipen
    ...    Set client id,client secret,grant type, nonce to formate body 
    [Arguments]              ${client_id}      ${client_secret}    ${grant_type}   ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_schema}    jsonfile=False
    Set Content API Body    client_id        ${client_id}        append=False
    Set Content API Body    client_secret    ${client_secret}
    Set Content API Body    grant_type       ${grant_type}
    Set Content API Body    nonce            ${DATE_TIME}
    # ${body_client_id}        Replace String    ${body_client_credentials_schema}   _client_id_         ${client_id}
    # ${body_client_secret}    Replace String    ${body_client_id}                   _client_secret_     ${client_secret}
    # ${body_grant_type}       Replace String    ${body_client_secret}               _grant_type_        ${grant_type}
    # ${body_nonce}            Replace String    ${body_grant_type}                  _nonce_             ${DATE_TIME}
    # Set Test Variable        ${API_BODY}       ${body_nonce}

Set Body Client Credentials Missing Client Id
    [Documentation]     Owner : sasipen
    ...    Set client secret,grant type, nonce to formate body
    [Arguments]              ${client_secret}  ${grant_type}     ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_missing_id_schema}    jsonfile=False
    Set Content API Body    client_secret    ${client_secret}               append=False
    Set Content API Body    grant_type       ${grant_type}
    Set Content API Body    nonce            ${DATE_TIME}
    # ${body_client_secret}    Replace String    ${body_client_credentials_missing_id_schema}    _client_secret_     ${client_secret}
    # ${body_grant_type}       Replace String    ${body_client_secret}                           _grant_type_        ${grant_type}
    # ${body_nonce}            Replace String    ${body_grant_type}                              _nonce_             ${DATE_TIME}
    # Set Test Variable        ${API_BODY}       ${body_nonce}

Set Body Client Credentials Missing Client Secret
    [Documentation]     Owner : sasipen
    ...    Set client id,grant type, nonce to formate body 
    [Arguments]              ${client_id}      ${grant_type}    ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_missing_secret_schema}    jsonfile=False
    Set Content API Body    client_id    ${client_id}                           append=False
    Set Content API Body    grant_type   ${grant_type}
    Set Content API Body    nonce        ${DATE_TIME}
    # ${body_client_id}        Replace String    ${body_client_credentials_missing_secret_schema}   _client_id_         ${client_id}
    # ${body_grant_type}       Replace String    ${body_client_id}                                  _grant_type_        ${grant_type}
    # ${body_nonce}            Replace String    ${body_grant_type}                                 _nonce_             ${DATE_TIME}
    # Set Test Variable        ${API_BODY}       ${body_nonce}

Set Body Client Credentials Missing Grant Type
    [Documentation]     Owner : sasipen
    ...    Set client id,client secret,nonce to formate body 
    [Arguments]              ${client_id}      ${client_secret}    ${nonce}
    Get Time Nonce
    Set Schema API Body     ${body_client_credentials_missing_grant_type_schema}    jsonfile=False
    Set Content API Body    client_id        ${client_id}                           append=False
    Set Content API Body    client_secret    ${client_secret}
    Set Content API Body    nonce            ${DATE_TIME}
    # ${body_client_id}        Replace String    ${body_client_credentials_missing_grant_type_schema}   _client_id_         ${client_id}
    # ${body_client_secret}    Replace String    ${body_client_id}                                      _client_secret_     ${client_secret}
    # ${body_nonce}            Replace String    ${body_client_secret}                                  _nonce_             ${DATE_TIME}
    # Set Test Variable        ${API_BODY}       ${body_nonce}

Send Request Client Credentials
    [Documentation]     Owner : sasipen 
    ...     Send request Post to api
    &{message}    Send Request    POST  url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]
 
Send Request Client Credentials Invalid
    [Documentation]     Owner : sasipen
    ...     Send request Post to api
    [Arguments]        ${status_code}    
    ${message}    Send Request    POST  url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]
 
Verify Response Client Credentials
    [Documentation]     Owner : sasipen
    ...    Verify response form value(fix) by key and Should Match Regexp value (change) 
    [Arguments]    ${expected_expires_in}
    ${token}       Get Value Response By Key     access_token
    Should Match Regexp             ${token}     .+  
    Verify Value Response By Key    token_type   ${expected_token_type}
    Verify Value Response By Key    expires_in   ${expected_expires_in}
    # Set Test Actual Result    Token : ${RESPONSE.json()}

Verify Response Client Credentials Error
    [Documentation]     Owner : sasipen
    ...    Verify response form value(fix) by key
    [Arguments]    ${error_message}
    Verify Value Response By Key    error    ${error_message}
    # Set Test Actual Result    Token : ${RESPONSE.json()}

Decode Token To Jwt Client Credentials
    [Documentation]     Owner : sasipen
    ...    Get value by key from response and decode by jwt
    ${value}            Get Value Response By Key    access_token
    ${jwt_decode}       Jwt Decode      ${value}
    Set Test Actual Result    Jwt decode : ${jwt_decode}
    