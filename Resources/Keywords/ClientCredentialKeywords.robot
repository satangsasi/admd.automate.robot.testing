*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Get Time Nonce
    [Documentation]    Owner: Satangsasi
    ${Datetime}             Get Current Date        result_format=%Y%m%d %H:%M:%S.%f      
    Set Test Variable       ${DATETIME}         ${Datetime}
Set Content Header Client Credentials
    [Documentation]     Owner : sasipen
    [Arguments]          ${url}           ${content_type}
    ${headers}           Replace String   ${header_client_credentials_schema}    _Content-Type_    ${content_type}
    Set Test Variable    ${API_HEADER}    ${headers}
    Set Test Variable    ${API_URL}       ${url}

Set Body Client Credentials
    [Documentation]     Owner : sasipen
    [Arguments]              ${client_id}      ${client_secret}    ${grant_type}   ${nonce}
    Get Time Nonce
    ${body_client_id}        Replace String    ${body_client_credentials_schema}   _client_id_         ${client_id}
    ${body_client_secret}    Replace String    ${body_client_id}                   _client_secret_     ${client_secret}
    ${body_grant_type}       Replace String    ${body_client_secret}               _grant_type_        ${grant_type}
    ${body_nonce}            Replace String    ${body_grant_type}                  _nonce_             ${DATETIME}
    Set Test Variable        ${API_BODY}       ${body_nonce}

Set Body Client Credentials Missing Client Id
    [Documentation]     Owner : sasipen
    [Arguments]              ${client_secret}  ${grant_type}     ${nonce}
    Get Time Nonce
    ${body_client_secret}    Replace String    ${body_client_credentials_missing_id_schema}    _client_secret_     ${client_secret}
    ${body_grant_type}       Replace String    ${body_client_secret}                           _grant_type_        ${grant_type}
    ${body_nonce}            Replace String    ${body_grant_type}                              _nonce_             ${DATETIME}
    Set Test Variable        ${API_BODY}       ${body_nonce}

Set Body Client Credentials Missing Client Secret
    [Documentation]     Owner : sasipen
    [Arguments]              ${client_id}      ${grant_type}    ${nonce}
    Get Time Nonce
    ${body_client_id}        Replace String    ${body_client_credentials_missing_secret_schema}   _client_id_         ${client_id}
    ${body_grant_type}       Replace String    ${body_client_id}                                  _grant_type_        ${grant_type}
    ${body_nonce}            Replace String    ${body_grant_type}                                 _nonce_             ${DATETIME}
    Set Test Variable        ${API_BODY}       ${body_nonce}

Set Body Client Credentials Missing Grant Type
    [Documentation]     Owner : sasipen
    [Arguments]              ${client_id}      ${client_secret}    ${nonce}
    Get Time Nonce
    ${body_client_id}        Replace String    ${body_client_credentials_missing_grant_type_schema}   _client_id_         ${client_id}
    ${body_client_secret}    Replace String    ${body_client_id}                                      _client_secret_     ${client_secret}
    ${body_nonce}            Replace String    ${body_client_secret}                                  _nonce_             ${DATETIME}
    Set Test Variable        ${API_BODY}       ${body_nonce}

Send Request Client Credentials
    [Documentation]     Owner : sasipen 
    Send Post Request    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}
 
Send Request Client Credentials Invalid
    [Documentation]     Owner : sasipen
    [Arguments]        ${statuscode}    
    Send Post Request    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    expected_status=${statuscode}
 
Verify Response Client Credentials
    [Documentation]     Owner : sasipen
    [Arguments]    ${expected_expires_in}
    ${token}       Get Value Response By Key     access_token
    Should Match Regexp             ${token}     .+  
    Verify Value Response By Key    token_type   ${expected_token_type}
    Verify Value Response By Key    expires_in   ${expected_expires_in}
    Set Test Actual Result    Token : ${RESPONSE.json()}

Verify Response Client Credentials Error
    [Documentation]     Owner : sasipen
    [Arguments]    ${error_message}
    Verify Value Response By Key    error    ${error_message}
    Set Test Actual Result    Token : ${RESPONSE.json()}

Decode Token To Jwt Client Credentials 
    ${value}            Get Value Response By Key    access_token
    ${jwt_decode}       Jwt Decode      ${value}
    Set Test Actual Result    Jwt decode : ${jwt_decode}
