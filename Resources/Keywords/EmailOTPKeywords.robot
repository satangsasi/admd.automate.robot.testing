*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content Header Request Email Otp 
    [Documentation]     Owner : sasipen
    ...    Set header content type and url
    [Arguments]          ${url}           ${content_type}
    Set Schema API Header    ${header_only_content_type_schema}
    Set Content API Header   ${header_content_type}    ${content_type}    append=False
    Set Test Variable    ${API_URL}       ${url}

Set Body Request Email Otp  
    [Documentation]     Owner : sasipen
    ...    Set client id,public id,reference to formate body 
    [Arguments]    ${client_id}    ${public_id}    ${reference}    
    Set Schema API Body    ${body_request_email_otp_schema}      jsonfile=False
    Set Content API Body    $..client_id        ${client_id}        append=False
    Set Content API Body    $..public_id        ${public_id}
    Set Content API Body    $..reference        ${reference}

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
    Set Schema API Header     ${header_only_content_type_schema}
    Set Content API Header    ${header_content_type}    ${content_type}    append=False
    Set Test Variable    ${API_URL}       ${url}

Set Body Get Token Email Otp  
    [Documentation]     Owner : sasipen
    ...    Set client id,public id,reference to formate body 
    [Arguments]    ${client_id}    ${client_secret}    ${grant_type}    ${username}    
    ...            ${password}    ${type}    ${scope}    ${session_id}    ${transaction_id}   
    Set Schema API Body    ${body_get_token_email_otp_schema}    jsonfile=False
    Set Content API Body    $..client_id         ${client_id}        append=False
    Set Content API Body    $..client_secret     ${client_secret}       
    Set Content API Body    $..grant_type        ${grant_type}      
    Set Content API Body    $..username          ${username}    
    Set Content API Body    $..password          ${password}    
    Set Content API Body    $..type              ${type}  
    Set Content API Body    $..scope             ${scope}
    Set Content API Body    $..session_id        ${session_id}
    Set Content API Body    $..transaction_id    ${transaction_id}

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

Decode Get Token Email Otp Jwt By Key Access Token
    [Documentation]     Owner : sasipen
    ...    Get value state login By Key access token for decode in keyword Jwt Decode form BuiltinLibrary_CommonKeywords
    ${value}         Get Value Response By Key    access_token
    ${jwt_decode}    Jwt Decode      ${value} 
    Set Test Variable         ${JWT_DECODE_ACCESS_TOKEN}      ${jwt_decode} 
    Set Test Actual Result    Jwt decode Access Token : ${JWT_DECODE_ACCESS_TOKEN}

Decode Get Token Email Otp Jwt By Key Id Token
    [Documentation]     Owner : sasipen
    ...    Get value state login By Key access token for decode in keyword Jwt Decode form BuiltinLibrary_CommonKeywords
    ${value}         Get Value Response By Key    id_token
    ${jwt_decode}    Jwt Decode      ${value} 
    Set Test Variable         ${JWT_DECODE_ID_TOKEN}      ${jwt_decode} 
    Set Test Actual Result    Jwt decode Id Token : ${JWT_DECODE_ID_TOKEN}

Verify Response Decode Get Token Email Otp By Key Access Token
    ${actual_value_type}             Get Value Json By Key    ${JWT_DECODE_ACCESS_TOKEN}   aut.type
    ${actual_value_action}           Get Value Json By Key    ${JWT_DECODE_ACCESS_TOKEN}   aut.action
    ${actual_value_login_channel}    Get Value Json By Key    ${JWT_DECODE_ACCESS_TOKEN}   aut.login_channel
    ${actual_value_network}          Get Value Json By Key    ${JWT_DECODE_ACCESS_TOKEN}   aut.network
    Verify Value Should Be Equal    ${actual_value_type}             email 
    Verify Value Should Be Equal    ${actual_value_action}           login
    Verify Value Should Be Equal    ${actual_value_login_channel}    otp
    Verify Value Should Be Equal    ${actual_value_network}          anonymous

Verify Response Decode Get Token Email Otp By Key Id Token
    ${actual_value_type}             Get Value Json By Key    ${JWT_DECODE_ID_TOKEN}   aut.type
    ${actual_value_action}           Get Value Json By Key    ${JWT_DECODE_ID_TOKEN}   aut.action
    ${actual_value_login_channel}    Get Value Json By Key    ${JWT_DECODE_ID_TOKEN}   aut.login_channel
    ${actual_value_network}          Get Value Json By Key    ${JWT_DECODE_ID_TOKEN}   aut.network
    Verify Value Should Be Equal    ${actual_value_type}             email 
    Verify Value Should Be Equal    ${actual_value_action}           login
    Verify Value Should Be Equal    ${actual_value_login_channel}    otp
    Verify Value Should Be Equal    ${actual_value_network}          anonymous

Set Body Get Token Email Otp No Session And Transaction Id  
    [Documentation]     Owner : sasipen
    ...    Set client id,public id,reference to formate body 
    [Arguments]    ${client_id}    ${client_secret}    ${grant_type}    ${username}    ${password}    ${type}    ${scope}     
    Set Schema API Body     ${body_get_token_email_otp_no_session_transaction_id_schema}    jsonfile=False
    Set Content API Body    $..client_id         ${client_id}        append=False  
    Set Content API Body    $..client_secret     ${client_secret}  
    Set Content API Body    $..grant_type        ${grant_type}
    Set Content API Body    $..username          ${username}
    Set Content API Body    $..password          ${password}
    Set Content API Body    $..type              ${type}
    Set Content API Body    $..scope             ${scope}  

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

Wait For Password Expire
    [Documentation]    Owner: Nakarin
    ...    Wait for Token(from Auth Url) Expire about in 5 min
    [Tags]    keyword_communicate
    Sleep    5m

Verify Response Invalid Request Email Otp
    Verify Value Response By Key    result_code          ${expected_invalid_result_code_email_otp} 
    Verify Value Response By Key    developer_message    ${expected_invalid_developer_message} 

Send Post Request Email Otp Invalid
    [Documentation]     Owner : sasipen
    ...     Send request Post to api
    [Arguments]        ${status_code}
    &{message}     Send Request    POST    url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Request Email OTP Invalid : ${message}[request]
    Set Test Actual Result        Request Email OTP Invalid : ${message}[response]

Get Email OTP Password
    [Documentation]    Owner: Nakarin
    ...    Get Email OTP Password and return Test Variable    ${EMAIL_OTP_PASSWORD}
    [Tags]    keyword_action
    [Arguments]    ${transaction_id}
    # SSH Connect To Server Log
    ${json_log}        Get Json Log Email Otp        ${transaction_id}
    ${otp_password}    Get OTP Password From Json    ${json_log}
    Set Test Variable  ${EMAIL_OTP_PASSWORD}         ${otp_password}
    # [Teardown]    Close All Connections

Get Json Log Email Otp
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Get Json Log From output of SSH Command
    [Tags]    keyword_commands
    [Arguments]     ${transaction_id}
    # ${ADMD_PATH}    Change Directory Path To Get Log
    Read    delay=5s
    Write    cat ${ADMD_PATH} | grep -E "gsso.post_send_one_time_password.*${transaction_id}"
    ${string}   Read    delay=1s
    ${json_format}    Get Regexp Matches        ${string}    {.*
    ${json_expect}    Convert String To JSON    ${json_format}[0]
    Log         ${json_expect}
    [Return]    ${json_expect}
