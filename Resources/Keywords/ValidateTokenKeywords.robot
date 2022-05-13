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
    Set Schema API Body     ${body_validate_token_schema}
    Set Content API Body    $..client_id      ${client_id_OhFw3u_browser}
    Set Content API Body    $..token.value    ${ACCESS_TOKEN_CLIENTCREDENTIAL}
    Set Content API Body    $..nonce          ${DATE_TIME}

Send Post Request Validate Token
    [Documentation]    Owner: Nakarin
    ...    Send Post request 
    [Tags]    keyword_communicate
    ${message}    Send Request    POST    url=${url_validate_token}    headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]
    
Get Access Token ClientCredential
    [Documentation]    Editor: Nakarin
    ...    Get Access Token of Client Credential then Set Test Variable ${ACCESS_TOKEN_CLIENTCREDENTIAL}
    [Tags]    keyword_communicate
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u_browser}
    ...                            ${client_secret_id_OhFw3u_browser}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Log    ${RESPONSE.json()}[access_token]
    Set Test Variable    ${ACCESS_TOKEN_CLIENTCREDENTIAL}    ${RESPONSE.json()}[access_token]

Verify Response Success Validate Token
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..result_code          ${expected_result_code_pass}
    Verify Value Response By Key    $..developer_message    ${expected_develope_message_pass}

Set API Header B2C
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Set Content API Header    key=Content-Type    value=application/json    append=False
    Set Content API Header    key=X-Tid           value=login by msisdn OTP

Set API Body B2C
    [Documentation]    Owner: Nakarin
    ...    
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_validate_token_schema}
    Set Content API Body    $..client_id      ${clientid_validate_token}
    Set Content API Body    $..token.value    ${RESPONSE_JSON_MESSAGE}[access_token]
    Set Content API Body    $..nonce          ${DATE_TIME}

Set API Header Request Otp Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Header     ${header_only_content_type_schema}
    Set Content API Header    ${header_content_type}    ${content_type_json}    append=False

Set API Body Request Otp Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate    
    Set Schema API Body     ${body_request_otp_validate_token_schema}
    Set Content API Body    $..client_id    ${client_id_request_otp_validate_token}        append=False
    Set Content API Body    $..public_id    ${public_id_request_otp_validate_token}        
    Set Content API Body    $..reference    ${reference}  

Send Post Request Otp Validate Token 
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    ${url_request_otp_validate_token}    headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    Request OTP : ${message}[request]
    Set Test Actual Result        Request OTP : ${message}[response]
    
Set API Header Get Token Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Header     ${header_only_content_type_schema}
    Set Content API Header    key=${header_content_type}    value=${content_type_x_www}    append=False

Set API Body Get Token Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Body     ${body_get_token_validate_token_schema}
    Set Content API Body    $..client_id        ${client_id_request_otp_validate_token}         
    Set Content API Body    $..client_secret    ${client_secret_get_token_validate_token}           
    Set Content API Body    $..grant_type       ${grant_type_validate_token}
    Set Content API Body    $..username         ${public_id_request_otp_validate_token}
    Set Content API Body    $..password         ${EMAIL_OTP_PASSWORD} 
    Set Content API Body    $..type             ${type_get_token_validate_token}    
    Set Content API Body    $..scope            ${scope_get_token_validate_token} 
    Set Content API Body    $..session_id       ${ACTUAL_VALUE_SESSION_ID}  
    Set Content API Body    $..transaction_id   ${ACTUAL_VALUE_TRANSACTION_ID} 

Send Post Request Get Token Validate Token 
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    ${url_get_token_validate_token}    headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    Get Token : ${message}[request]
    Set Test Actual Result        Get Token : ${message}[response]

Get Value Response Get Token By Key Access Token
    [Documentation]    Owner: sasipen
    ...    Get Value by key 
    [Tags]    keyword_communicate
    ${value_access_token}    Get Value Response By Key     $..access_token
    Set Test Variable    ${ACTUAL_VALUE_ACCESS_TOKEN}      ${value_access_token}

Set API Header Delete Sub Scriber
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Schema API Header     ${header_only_content_type_schema}
    Set Content API Header    key=${header_content_type}   value=${content_type_json}    append=False

Set API Body Delete Sub Scriber
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request delete sub-scriber
    [Tags]    keyword_communicate
    Set Schema API Body     ${body_delete_sub_scriber_schema}
    Set Content API Body    $..msisdn    ${public_id_request_otp_validate_token}         
    
Send Post Request Delete Sub Scriber
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    ${url_delete_sub_scriber}    headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    Delete Sub Scriber : ${message}[request]
    Set Test Actual Result        Delete Sub Scriber : ${message}[response]

Set API Header Validate Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Content API Header    ${header_content_type}    ${content_type_json}    append=False
    Set Content API Header    ${header_x_tid}           validate_2   

Set API Body Validate Token
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Client Credential
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_validate_token_schema}
    Set Content API Body    $..client_id      ${client_id_request_otp_validate_token}    
    Set Content API Body    $..token.value    ${ACTUAL_VALUE_ACCESS_TOKEN}
    Set Content API Body    $..nonce          ${DATE_TIME}

Send Post Request Validate Token No Profile
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    Request Validate Token No Profile : ${message}[request]
    Set Test Actual Result        Request Validate Token No Profile : ${message}[response]

Verify Response Validate Token No Profile 
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..result_code            ${expected_result_code_40402}
    Verify Value Response By Key    $..developer_message      ${error_message_subscriber_not_found}

Set API Header Validate Token Invalid Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_json}    append=False
    Set Content API Header    key=${header_x_tid}           value=login msisdn by grant type = password (nowebview)

Set API Body Validate Token Invalid Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_validate_token_schema}
    Set Content API Body    $..client_id    ${clientid_validate_token_invalid}    
    Set Content API Body    $..token.value        ${ACTUAL_VALUE_ACCESS_TOKEN}
    Set Content API Body    $..nonce          ${DATE_TIME}

Send Post Request Validate Token Invalid Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    Request Validate Invalid Client Id : ${message}[request]
    Set Test Actual Result        Request Validate Invalid Client Id : ${message}[response]

Verify Response Validate Token Invalid Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..result_code            ${expected_result_code_40106}
    Verify Value Response By Key    $..developer_message      ${error_message_invalid_client} 

Set API Header Validate Token Invalid Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_json}    append=False
    Set Content API Header    key=${header_x_tid}           value=validate_2

Set API Body Validate Token Invalid Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Test Variable       ${VALUE_ACCESS_TOKEN_INVALID}    ${ACTUAL_VALUE_ACCESS_TOKEN}n
    Set Schema API Body     ${body_validate_token_schema}   
    Set Content API Body    $..client_id      ${clientid_request_otp_validate_token}
    Set Content API Body    $..token.value    ${value_access_token_invalid}
    Set Content API Body    $..nonce          ${DATE_TIME}

Send Post Request Validate Token Invalid Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    Request Validate Invalid Access Token : ${message}[request]
    Set Test Actual Result        Request Validate Invalid Access Token : ${message}[response]

Verify Response Validate Token Invalid Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Should Not Be Equal    ${ACTUAL_VALUE_ACCESS_TOKEN}    ${VALUE_ACCESS_TOKEN_INVALID}      
    Verify Value Response By Key    $..result_code            ${expected_result_code_40001} 
    Verify Value Response By Key    $..developer_message      ${error_message_invalid_code}

Set API Header Validate Token Missing Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_json}    append=False
    Set Content API Header    key=${header_x_tid}           value=login by auto msisdn

Set API Body Validate Token Missing Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Get Time Nonce                                                                                    
    Set Content API Body    $..token.type            access_token                    append=False                                                                                                                                                                                       
    Set Content API Body    $..token.value           ${ACTUAL_VALUE_ACCESS_TOKEN}    
    Set Content API Body    $..nonce                 ${DATE_TIME}

Send Post Request Validate Token Missing Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    Request Validate Missing Client Id : ${message}[request]
    Set Test Actual Result        Request Validate Missing Client Id : ${message}[response]

Verify Response Validate Token Missing Client Id
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..result_code            ${expected_result_code_40000}
    Verify Value Response By Key    $..developer_message      ${error_message_missing_invalid_parameter}

Set API Header Validate Token Expired Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_json}    append=False
    Set Content API Header    key=${header_x_tid}           value=validate_2

Set API Body Validate Token Expired Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_validate_token_schema}   
    Set Content API Body    $..client_id      ${clientid_request_otp_validate_token}
    Set Content API Body    $..token.value    ${expired_access_token_validate_token} 
    Set Content API Body    $..nonce          ${DATE_TIME}

Send Post Request Validate Token Expired Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    Request Validate Expired Access Token : ${message}[request]
    Set Test Actual Result        Request Validate Expired Access Token : ${message}[response]

Verify Response Validate Token Expired Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Should Not Be Equal    ${ACTUAL_VALUE_ACCESS_TOKEN}    ${expired_access_token_validate_token}         
    Verify Value Response By Key    $..result_code            ${expected_result_code_40401}
    Verify Value Response By Key    $..developer_message      ${error_message_data_not_found}

Set API Header Validate Token Missing Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_json}    append=False
    Set Content API Header    key=${header_x_tid}           value=login by auto msisdn

Set API Body Validate Token Missing Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Get Time Nonce           
    Set Content API Body    $..client_id     ${clientid_validate_token}    append=False                                                                           
    Set Content API Body    $..token.type    access_token                                                                                                                                                                                                          
    Set Content API Body    $..nonce         ${DATE_TIME}

Send Post Request Validate Token Missing Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    Request Validate Missing Access Token : ${message}[request]
    Set Test Actual Result        Request Validate Missing Access Token : ${message}[response]

Verify Response Validate Token Missing Access Token
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..result_code            ${expected_result_code_40000}
    Verify Value Response By Key    $..developer_message      ${error_message_missing_invalid_parameter}

SSH Connect To Server Validate Token Profile Have Gupimpi
    [Documentation]    Owner: sasipen
    [Tags]    keyword_action
    ${validate_token_connection}       Open Connection    ${ssh_validate_token_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login    ${ssh_validate_token_user}    ${ssh_validate_token_pass}           
    Log    ${login_log} 
    Set Test Variable    ${SSH_VALIDATE_TOKEN}     ${validate_token_connection}

Get Code Form Link Authorization By SSH Connect
    [Documentation]    Owner: sasipen
    Switch Connection    ${SSH_VALIDATE_TOKEN}
    Read     delay=2s  
    Write    curl -kv -X GET 'https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&redirect_uri=https%3A%2F%2Fwww.ais.co.th%2F&scope=profile&state=LIB140000001' -H "x-msisdn":"66819633124"
    ${output}    Read    delay=1s
    Log    ${output}
    #อาจจะต้องตัดคำให้ได้โค้ด ${CODE} มาแล้วเอามาใช้ในคีย์เวิร์ด Get Token Form Code By SSH Connect
   
Create URL For Get Token By SSH Connect
    [Documentation]    Owner: sasipen
    ...        ${url_get_token_Gupimpi}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&client_secret=adfea93d79e56e5219eccd63cc884ae3&grant_type=authorization_code&redirect_uri=https%3A%2F%2Fwww.ais.co.th%2F&code=_code_
    ${url_get_token_Gupimpi}     Replace String      ${url_get_token_Gupimpi}    _code_    ${CODE}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token_Gupimpi}

Get Token Form Code By SSH Connect  
    [Documentation]    Owner: sasipen
    Write    reset
    Write    curl -kv -X GET '${URL_GET_TOKEN}'
    ${output}    Read    delay=1s
    Log    ${output}
    #ได้ response กลับมา เอาค่า value ของ access token 

Set API Header Validate Token Profile Have Gupimpi
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_json}    append=False
    Set Content API Header    key=${header_x_tid}           value=validate004

Set API Body Validate Token Profile Have Gupimpi
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_validate_token_schema}   
    Set Content API Body    $..client_id      skZHmM4IPAFMCbco8D4MAO0HNSI7VuX/aVThDpTFLbI=
    Set Content API Body    $..token.value    #value ของ access token 
    Set Content API Body    $..nonce          ${DATE_TIME}

Send Post Request Validate Token Profile Have Gupimpi
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    ${url_validate_token}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data    Request Validate Missing Access Token : ${message}[request]
    Set Test Actual Result        Request Validate Missing Access Token : ${message}[response]

