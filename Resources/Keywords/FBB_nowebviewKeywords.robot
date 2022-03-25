*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set API Header FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Set Content API Header    key=Content-Type    value=application/json
    Set Test Variable        ${API_URL}           ${url_fbb_nowebview}

Set API Body FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_verify_login_nowebview}
    Set Content API Body    key=$..nonce        value=${DATE_TIME}

Send Request FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${message}    Send Request    POST  url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]
    ${response_json_message}      Convert Variable Type To Dot Dict    ${RESPONSE.json()}
    Set Test Provisioning Data    Transaction ID: ${response_json_message.transaction_id}
    Set Test Provisioning Data    Session ID: ${response_json_message.session_id}
    Set Test Variable             ${RESPONSE_JSON_MESSAGE}    ${response_json_message}
    
Set API Header Get Token FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Set Content API Header    key=Content-Type    value=application/x-www-form-urlencoded
    Set Test Variable         ${API_URL}          ${url_get_token_fbb_nowebview}

Set API Body Get Token FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_verify_get_token_login_nowebview}
    # Set Content API Body    key=$..transaction_id    value=${RESPONSE_JSON_MESSAGE}[transaction_id]
    # Set Content API Body    key=$..session_id        value=${RESPONSE_JSON_MESSAGE}[session_id]
    Set Content API Body    key=$..transaction_id    value=${RESPONSE_JSON_MESSAGE.transaction_id}
    Set Content API Body    key=$..session_id        value=${RESPONSE_JSON_MESSAGE.session_id}
    Set Content API Body    key=$..password          value=${FBB_NO_WEB_VIEW_OTP_PASSWORD}
    Set Content API Body    key=$..nonce             value=${DATE_TIME}

Send Request Get Token FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${message}    Send Request    POST  url=${API_URL}    headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]
    ${response_json_message}      Convert Variable Type To Dot Dict    ${RESPONSE.json()}
    Set Test Variable             ${RESPONSE_JSON_MESSAGE}    ${response_json_message}

Get OTP Password FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${json_log}        Get Json Log FBB No Web View
    ${otp_password}    Get OTP Password From Json         ${json_log}
    Set Test Provisioning Data    OTP Password: ${otp_password}
    Set Test Variable  ${FBB_NO_WEB_VIEW_OTP_PASSWORD}    ${otp_password}

Get Json Log FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_commands
    Read     delay=5s
    # Write    cat ${ADMD_PATH} | grep -E "oneTimePassword.*${RESPONSE_JSON_MESSAGE}[transaction_id]"
    Write    cat ${ADMD_PATH} | grep -E "oneTimePassword.*${RESPONSE_JSON_MESSAGE.transaction_id}"
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches        ${string}    {.*
    ${json_expect}    Convert String To JSON    ${json_format}[0]
    Log         ${json_expect}
    [Return]    ${json_expect}

Verify Response Key FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Run Keyword And Continue On Failure    Verify Response Key    $..result_code
    Run Keyword And Continue On Failure    Verify Response Key    $..developer_message
    Run Keyword And Continue On Failure    Verify Response Key    $..transaction_id
    Run Keyword And Continue On Failure    Verify Response Key    $..reference_number
    Run Keyword And Continue On Failure    Verify Response Key    $..contact_number
    Run Keyword And Continue On Failure    Verify Response Key    $..session_id

Verify Response Key Get Token FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Run Keyword And Continue On Failure    Verify Response Key    $..access_token
    Run Keyword And Continue On Failure    Verify Response Key    $..token_type
    Run Keyword And Continue On Failure    Verify Response Key    $..expires_in
    Run Keyword And Continue On Failure    Verify Response Key    $..refresh_token
    Run Keyword And Continue On Failure    Verify Response Key    $..refresh_token_expires_in
    Run Keyword And Continue On Failure    Verify Response Key    $..id_token
    
Verify Decoded Value Access Token FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Decoded Access Token
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             fbbid
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           login
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    otp
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..uid                  661620133267336
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..ial                  1.1
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aal                  1
    
    
































































































































# =================>





















































































































































# =================>
Set API Header Get Token FBB No Web View No Match
    [Documentation]    Owner: Atitaya
    [Tags]    
    Set Content API Header    key=${header_content_type}          value=${content_type_x_www}       append=False             
    Set Test Variable         ${API_URL_NO_MATCH}       ${url_get_token_fbb_nowebview}

Set API Body Get Token FBB No Web View No Match   
    [Documentation]    Owner: Atitaya
    [Tags]
    Get Time Nonce
    Set Schema API Body     ${body_verify_get_token_login_nowebview}        
    Set Content API Body    $..client_secret    ${invalid_client_secret_nowebview}       
    Set Content API Body    $..password         ${FBB_NO_WEB_VIEW_OTP_PASSWORD}
    Set Content API Body    $..transaction_id   ${RESPONSE_JSON_MESSAGE.transaction_id}
    Set Content API Body    $..session_id       ${RESPONSE_JSON_MESSAGE.session_id}    
    Set Content API Body    $..nonce            ${DATE_TIME}

Send Request Token FBB No Web View No Match
    [Documentation]    Owner: Atitaya
    [Tags]
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    url=${API_URL_NO_MATCH}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}    verify=${ssl_verify}
    Set Test Provisioning Data      Request Client Invalid : ${message}[request]
    Set Test Actual Result          Request Client Invalid : ${message}[response]

Verify Response Get Token With Client Id And Client Secret No Match  
    [Documentation]    Owner: Atitaya
    [Tags]    
    Verify Value Response By Key    $..error    ${error_message_invalid_client}



