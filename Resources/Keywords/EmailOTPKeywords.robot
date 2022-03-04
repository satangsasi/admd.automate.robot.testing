*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content Header Request Email Otp 
    [Documentation]     Owner : sasipen
    ...    Set header content type and url
    [Arguments]          ${url}           ${content_type}
    # ${headers}           Replace String   ${header_client_credentials_schema}    _Content-Type_    ${content_type}
    # Set Test Variable    ${API_HEADER_REQUEST_EMAIL_OTP}    ${headers}
    # Set Test Variable    ${API_URL_REQUEST_EMAIL_OTP}       ${url}
    # Set Test Provisioning Data    Request Otp Url : ${API_URL_REQUEST_EMAIL_OTP}
    # Set Test Provisioning Data    Header : ${API_HEADER_REQUEST_EMAIL_OTP}
    Set Schema API Header    ${header_only_content_type_schema}
    Set Content API Header    Content-Type    ${content_type}    append=False
    Set Test Variable    ${API_URL}       ${url}

Set Body Request Email Otp  
    [Documentation]     Owner : sasipen
    ...    Set client id,public id,reference to formate body 
    [Arguments]    ${client_id}    ${public_id}    ${reference}    
    # ${body_client_id}        Replace String    ${body_request_email_otp_schema}    _client_id_         ${client_id}
    # ${body_public_id}        Replace String    ${body_client_id}                   _public_id_         ${public_id}
    # ${body_reference}        Replace String    ${body_public_id}                   _reference_         ${reference}
    # Set Test Variable        ${API_BODY_REQUEST_EMAIL_OTP}       ${body_reference}
    # Set Test Provisioning Data    Body : ${API_BODY_REQUEST_EMAIL_OTP}
    Set Schema API Body    ${body_request_email_otp_schema}      jsonfile=False
    Set Content API Body    client_id        ${client_id}        append=False
    Set Content API Body    public_id        ${public_id}
    Set Content API Body    reference        ${reference}

Send Post Request Email Otp
    [Documentation]    Owner : sasipen
    &{message}    Send Request    POST    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    Request Email OTP : ${message}[request]
    Set Test Actual Result        Request Email OTP : ${message}[response]

Verify Value Response Email Otp By Key 
    [Documentation]     Owner : sasipen
    ...    verify value By Key use should match regexp for value(change)
    [Arguments]   ${response_key}
    ${value}      Get Value Response By Key    ${response_key} 
    Should Match Regexp    ${value}     .+
    Log    ${value}
    
Verify Response Request Email Otp
    [Documentation]    Owner : sasipen
    Verify Value Response By Key    result_code          ${expected_result_code_email_otp}
    Verify Value Response By Key    developer_message    ${expected_developer_message}
    Verify Value Response Email Otp By Key    session_id
    Verify Value Response Email Otp By Key    transaction_id
    Verify Value Response Email Otp By Key    reference_number
    # Set Test Actual Result    Request OTP :\r\n${RESPONSE.json()}

Get Value Response Request Email Otp By Key Session Id   
    [Documentation]    Owner : sasipen
    ${value_session_id}    Get Value Response By Key     session_id
    Set Test Variable    ${ACTUAL_VALUE_SESSION_ID}    ${value_session_id}

Get Value Response Request Email Otp By Key Transaction Id  
    [Documentation]    Owner : sasipen
    ${value_transaction_id}    Get Value Response By Key     transaction_id
    Set Test Variable    ${ACTUAL_VALUE_TRANSACTION_ID}    ${value_transaction_id} 

Set Content Header Get Token Email Otp 
    [Documentation]     Owner : sasipen
    ...    Set header content type and url
    [Arguments]          ${url}           ${content_type}
    # ${headers}           Replace String   ${header_client_credentials_schema}    _Content-Type_    ${content_type}
    # Set Test Variable    ${API_HEADER_GET_TOKEN_EMAIL_OTP}    ${headers}
    # Set Test Variable    ${API_URL_GET_TOKEN_EMAIL_OTP}       ${url}
    # Set Test Provisioning Data    Get Token Url : ${API_URL_GET_TOKEN_EMAIL_OTP} 
    # Set Test Provisioning Data    Header Get Token : ${API_HEADER_GET_TOKEN_EMAIL_OTP}
    Set Schema API Header    ${header_only_content_type_schema}
    Set Content API Header    Content-Type    ${content_type}    append=False
    Set Test Variable    ${API_URL}       ${url}

Set Body Get Token Email Otp  
    [Documentation]     Owner : sasipen
    ...    Set client id,public id,reference to formate body 
    [Arguments]    ${client_id}    ${client_secret}    ${grant_type}    ${username}    ${password}    ${type}    ${scope}    ${session_id}    ${transaction_id}   
    # ${body_client_id}        Replace String    ${body_get_token_email_otp_schema}    _client_id_        ${client_id}
    # ${body_client_secret}    Replace String    ${body_client_id}                     _client_secret_    ${client_secret}
    # ${body_grant_type}       Replace String    ${body_client_secret}                 _grant_type_       ${grant_type}
    # ${body_username}         Replace String    ${body_grant_type}                    _username_         ${username}
    # ${body_password}         Replace String    ${body_username}                      _password_         ${password}
    # ${body_type}             Replace String    ${body_password}                      _type_             ${type}       
    # ${body_scope}            Replace String    ${body_type}                          _scope_            ${scope}       
    # ${body_session_id}       Replace String    ${body_scope}                         _session_id_       ${session_id}
    # ${body_transaction_id}   Replace String    ${body_session_id}                    _transaction_id_   ${transaction_id}
    # Set Test Variable        ${API_BODY_GET_TOKEN}    ${body_transaction_id}
    # Set Test Provisioning Data    Body Get Token : ${API_BODY_GET_TOKEN} 
    Set Schema API Body    ${body_get_token_email_otp_schema}    jsonfile=False
    Set Content API Body    client_id         ${client_id}        append=False
    Set Content API Body    client_secret     ${client_secret}       
    Set Content API Body    grant_type        ${grant_type}      
    Set Content API Body    username          ${username}    
    Set Content API Body    password          ${password}    
    Set Content API Body    type              ${type}  
    Set Content API Body    scope             ${scope}
    Set Content API Body    session_id        ${session_id}
    Set Content API Body    transaction_id    ${transaction_id}

Send Post Request Get Token Email Otp
    [Documentation]     Owner : sasipen
    ...    send request Post for get token 
    &{message}    Send Request    POST    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    Get Token Email OTP : ${message}[request]
    Set Test Actual Result        Get Token Email OTP : ${message}[response]

Verify Response Get Token Email Otp
    [Documentation]     Owner : sasipen
    ...    Verify response form value(fix) by key and Should Match Regexp value (change) 
    Verify Value Response Email Otp By Key     access_token
    Verify Value Response Email Otp By Key     refresh_token
    Verify Value Response Email Otp By Key     id_token
    Verify Value Response By Key               token_type                  ${expected_token_type}
    Verify Value Response By Key               expires_in                  ${expected_expires_in_email_otp}
    Verify Value Response By Key               refresh_token_expires_in    ${expected_refresh_token_expires_in_email_otp}
    # Set Test Actual Result    Response Get Token : ${RESPONSE.json()}

Set Body Get Token Email Otp No Session And Transaction Id  
    [Documentation]     Owner : sasipen
    ...    Set client id,public id,reference to formate body 
    [Arguments]    ${client_id}    ${client_secret}    ${grant_type}    ${username}    ${password}    ${type}    ${scope}     
    # ${body_client_id}        Replace String    ${body_get_token_email_otp_no_session_transaction_id_schema}    _client_id_        ${client_id}
    # ${body_client_secret}    Replace String    ${body_client_id}                     _client_secret_    ${client_secret}
    # ${body_grant_type}       Replace String    ${body_client_secret}                 _grant_type_       ${grant_type}
    # ${body_username}         Replace String    ${body_grant_type}                    _username_         ${username}
    # ${body_password}         Replace String    ${body_username}                      _password_         ${password}
    # ${body_type}             Replace String    ${body_password}                      _type_             ${type}       
    # ${body_scope}            Replace String    ${body_type}                          _scope_            ${scope}       
    # Set Test Variable        ${API_BODY_GET_TOKEN}       ${body_scope}   
    # Set Test Provisioning Data    Body Get Token : ${API_BODY_GET_TOKEN}   
    Set Schema API Body     ${body_get_token_email_otp_no_session_transaction_id_schema}    jsonfile=False
    Set Content API Body    client_id         ${client_id}        append=False  
    Set Content API Body    client_secret     ${client_secret}  
    Set Content API Body    grant_type        ${grant_type}
    Set Content API Body    username          ${username}
    Set Content API Body    password          ${password}
    Set Content API Body    type              ${type}
    Set Content API Body    scope             ${scope}  

Send Post Request Get Token Email Otp Invalid
    [Documentation]     Owner : sasipen
    ...     Send request Post to api
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Get Token Email OTP Invalid : ${message}[request]
    Set Test Actual Result        Get Token Email OTP Invalid : ${message}[response]

Verify Response Get Token Email Otp Error
    [Documentation]     Owner : sasipen
    ...    Verify response form value(fix) by key
    [Arguments]    ${error_message}
    Verify Value Response By Key    error    ${error_message}
    # Set Test Actual Result    Response Get Token : ${RESPONSE.json()}

Wait For Password Expire
    [Documentation]    Owner: Nakarin
    ...    Wait for Token(from Auth Url) Expire about in 5 min
    [Tags]    keyword_communicate
    Sleep    5m

Verify Response Invalid Request Email Otp
    Verify Value Response By Key    result_code          ${expected_invalid_result_code_email_otp} 
    Verify Value Response By Key    developer_message    ${expected_invalid_developer_message} 
    # Set Test Actual Result    Request OTP :\r\n${RESPONSE.json()}

Send Post Request Email Otp Invalid
    [Documentation]     Owner : sasipen
    ...     Send request Post to api
    [Arguments]        ${status_code}
    &{message}     Send Request    POST    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Request Email OTP Invalid : ${message}[request]
    Set Test Actual Result        Request Email OTP Invalid : ${message}[response]
