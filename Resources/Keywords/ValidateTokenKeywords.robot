*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set API Header Login By Client Credential
    [Documentation]    Owner: Nakarin
    ...    Set API Header for send request of Client Credential
    [Tags]    keyword_communicate
    Set Content API Header    key=Content-Type    value=application/json    append=False
    Set Content API Header    key=X-Tid           value=login by client credentials
    Log    ${API_HEADER}

Set API Body Login By Client Credential
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Client Credential
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body        ${body_validate_token_schema}
    Set Content API Body    $..client_id      ${client_id_OhFw3u_browser}
    Set Content API Body    $..token.value    ${ACCESS_TOKEN_CLIENTCREDENTIAL}
    Set Content API Body    $..nonce          ${DATE_TIME}

Send Post Request Validate Token
    [Documentation]    Owner: Nakarin
    ...    Send Post request 
    [Tags]    keyword_communicate
    ${message}    Send Request    POST    url=${url_validate_token}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]
    
Get Access Token ClientCredential
    [Documentation]    Editor: Nakarin
    ...    Get Access Token of Client Credential then Set Test Variable ${ACCESS_TOKEN_CLIENTCREDENTIAL}
    [Tags]    keyword_communicate
    Set Content Header Client Credentials    ${url_client_credentials_${test_site}}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u_browser}
    ...                            ${client_secret_id_OhFw3u_browser}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Log    ${RESPONSE.json()}[access_token]
    Set Test Variable    ${ACCESS_TOKEN_CLIENTCREDENTIAL}    ${RESPONSE.json()}[access_token]

# Set Body Validate Token Test
#     [Documentation]     Owner : sasipen
#     ...    Set client id,grant type, nonce to formate body
#     [Arguments]              ${client_id}      ${value}    ${nonce}
#     ${body_client_id}        Replace String    ${API_BODY}          _client_id_    ${client_id}
#     ${body_value}            Replace String    ${body_client_id}    _value_        ${value}
#     ${body_api}              Replace String    ${body_value}        _nonce_        ${nonce}
#     Log    ${body_api}
#     Set Test Variable        ${API_BODY}       ${body_api}

Fill FBB Username 
    [Documentation]    Owner: Nakarin
    Type Text    ${txt_fbb_user}    ${fbb_user}    delay=0.1s

Click Request OTP
    [Documentation]    Owner: Nakarin
    Click    ${btn_fbb_request_otp}
    Wait Until Network Is Idle

Fill FBB OTP Password
    [Documentation]    Owner: Nakarin
    ...    Website can detect character while typing
    Type Text    ${txt_fbb_pass}    ${FBB_OTP_PASS}    delay=0.1s

Press Login Button In Validate Token
    [Documentation]    Owner: Nakarin
    Click    ${btn_fbb_login}
    Wait Until Network Is Idle

Get FBB OTP
    [Documentation]    Owner: Nakarin
    ...    Get OTP Password From Server Log
    ...    Then Set Test Variable ${FBB_OTP_PASS}
    SSH Connect To 10.137.30.22
    ${server_log}        Get Json Log FBB OTP
    ${otp_password}      Get OTP From Json    ${server_log}
    Set Test Variable    ${FBB_OTP_PASS}    ${otp_password}

Get Json Log FBB OTP
    [Documentation]    Owner: Nakarin
    ${admd_path}    Change Directory Path To Get Log
    ${mobile_number}    Replace String    ${fbb_user}    0    66    count=1
    Write    cat ${admd_path} | grep -E "${mobile_number}.*oneTimePassword"
    ${string}   Read    delay=1s
    ${json_format}    Get Regexp Matches        ${string}    {.*
    Log Many    @{json_format}
    ${json_expect}    Convert String To JSON    ${json_format}[0]
    Log         ${json_expect}
    [Return]    ${json_expect}

Verify Response Success Login Client Credentials
    [Documentation]    Owner: Nakarin
    Verify Value Response By Key    result_code          ${expected_result_code_pass}
    Verify Value Response By Key    developer_message    ${expected_develope_message_pass}








































































































































































































Set API Header Request Otp Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Header     ${header_only_content_type_schema}
    Set Content API Header    ${header_content_type}    ${content_type_json}    append=False

Set API Body Request Otp Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate    
    Set Schema API Body     ${body_request_otp_validate_token_schema}
    Set Content API Body    client_id    ${client_id_request_otp_validate_token}        append=False
    Set Content API Body    public_id    ${public_id_request_otp_validate_token}        
    Set Content API Body    reference    ${reference}  

Send Post Request Otp Validate Token 
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    ${url_request_otp_validate_token}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    Requset OTP : ${message}[request]
    Set Test Actual Result        Requset OTP : ${message}[response]
Set API Header Get Token Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Header     ${header_only_content_type_schema}
    Set Content API Header    ${header_content_type}    ${content_type_x_www}    append=False

Set API Body Get Token Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Body     ${body_get_token_validate_token_schema}
    Set Content API Body    client_id        ${client_id_request_otp_validate_token}         append=False
    Set Content API Body    client_secret    ${client_secret_get_token_validate_token}           
    Set Content API Body    grant_type       ${grant_type_validate_token} 
    Set Content API Body    username         ${public_id_request_otp_validate_token}
    Set Content API Body    password         ${EMAIL_OTP_PASSWORD} 
    Set Content API Body    type             ${type_get_token_validate_token}    
    Set Content API Body    scope            ${scope_get_token_validate_token} 
    Set Content API Body    session_id       ${ACTUAL_VALUE_SESSION_ID}  
    Set Content API Body    transaction_id   ${ACTUAL_VALUE_TRANSACTION_ID} 

Send Post Request Get Token Validate Token 
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    ${url_get_token_validate_token}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    Get Token : ${message}[request]
    Set Test Actual Result        Get Token : ${message}[response]
Get Value Response Get Token By Key Access Token
    ${value_access_token}    Get Value Response By Key     access_token
    Set Test Variable    ${ACTUAL_VALUE_ACCESS_TOKEN}      ${value_access_token}

Set API Header Delete Sub Scriber
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Header     ${header_only_content_type_schema}
    Set Content API Header    ${header_content_type}   ${content_type_json}    append=False

Set API Body Delete Sub Scriber
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Client Credential
    [Tags]    keyword_communicate
    Set Schema API Body     ${body_delete_sub_scriber_schema}
    Set Content API Body    msisdn    ${public_id_request_otp_validate_token}         append=False
    
Send Post Request Delete Sub Scriber
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    ${url_delete_sub_scriber}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    Delete Sub Scriber : ${message}[request]
    Set Test Actual Result        Delete Sub Scriber : ${message}[response]
Set API Header Validate Token
    [Documentation]    Owner: Nakarin
    ...    Set API Header for send request of Client Credential
    [Tags]    keyword_communicate
    Set Content API Header    ${header_content_type}    ${content_type_json}    append=False
    Set Content API Header    ${header_x_tid}           validate_2   


Set API Body Validate Token
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Client Credential
    [Tags]    keyword_communicate
    Set Schema API Body     ${body_validate_token_schema}
    Set Content API Body    client_id    ${client_id_request_otp_validate_token}    append=False
    Set Content API Body    value        ${ACTUAL_VALUE_ACCESS_TOKEN}

Send Post Request Validate Token No Profile
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Request Validate Token No Profile : ${message}[request]
    Set Test Actual Result        Request Validate Token No Profile : ${message}[response]

Verify Response Validate Token No Profile 
    Verify Value Response By Key    result_code            ${expected_result_code_no_profile}
    Verify Value Response By Key    developer_message      ${error_message_subscriber_not_found}

Set API Header Validate Token Invalid Client Id
    [Documentation]    Owner: Nakarin
    ...    Set API Header for send request of Client Credential
    [Tags]    keyword_communicate
    Set Content API Header    ${header_content_type}    ${content_type_json}    append=False
    Set Content API Header    ${header_x_tid}           login msisdn by grant type = password (nowebview)

Set API Body Validate Token Invalid Client Id
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Client Credential
    [Tags]    keyword_communicate
    Set Schema API Body     ${body_validate_token_schema}
    Set Content API Body    client_id    ${clientid_validate_token_invalid}    append=False
    Set Content API Body    value        ${ACTUAL_VALUE_ACCESS_TOKEN}

Send Post Request Validate Token Invalid Client Id
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Request Validate Invalid Client Id : ${message}[request]
    Set Test Actual Result        Request Validate Invalid Client Id : ${message}[response]

Verify Response Validate Token Invalid Client Id
    Verify Value Response By Key    result_code            ${expected_result_code_invalid_client_id}
    Verify Value Response By Key    developer_message      ${error_message_invalid_client} 

Set API Header Validate Token Invalid Access Token
    [Documentation]    Owner: Nakarin
    ...    Set API Header for send request of Client Credential
    [Tags]    keyword_communicate
    Set Content API Header    ${header_content_type}    ${content_type_json}    append=False
    Set Content API Header    ${header_x_tid}           validate_2

Set API Body Validate Token Invalid Access Token
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Client Credential
    [Tags]    keyword_communicate
    Set Schema API Body     ${body_validate_token_schema}   
    Set Content API Body    client_id    ${clientid_validate_token_invalid}    append=False
    Set Content API Body    value        ${access_token_invalid}
Send Post Request Validate Token Invalid Access Token
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Request Validate Invalid Access Token : ${message}[request]
    Set Test Actual Result        Request Validate Invalid Access Token : ${message}[response]


Verify Response Validate Token Invalid Access Token
    Verify Value Response By Key    result_code            ${expected_result_code_invalid_access_token} 
    Verify Value Response By Key    developer_message      ${error_message_invalid_code}