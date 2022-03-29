*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set API Header FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Set Content API Header    key=Content-Type    value=application/json    append=False
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
    Set Test Actual Result        Access Token: ${RESPONSE_JSON_MESSAGE.access_token}
    Set Test Actual Result        ID Token: ${RESPONSE_JSON_MESSAGE.id_token}
    
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
    Write    cat ${ADMD_PATH} | grep -E "oneTimePassword.*${RESPONSE_JSON_MESSAGE.transaction_id}"
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches        ${string}    {.*
    ${json_expect}    Convert String To JSON    ${json_format}[0]
    Log         ${json_expect}
    [Return]    ${json_expect}
    Set Test Actual Result    ADMD V3.2 Log: ${json_expect}

Verify Response Key FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Response Key    $..result_code
    Verify Response Key    $..developer_message
    Verify Response Key    $..transaction_id
    Verify Response Key    $..reference_number
    Verify Response Key    $..contact_number
    Verify Response Key    $..session_id

Verify Response Key Get Token FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Response Key    $..access_token
    Verify Response Key    $..token_type
    Verify Response Key    $..expires_in
    Verify Response Key    $..refresh_token
    Verify Response Key    $..refresh_token_expires_in
    Verify Response Key    $..id_token
    
Verify Decoded Value Access Token FBB No Web View
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Decoded Access Token
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             fbbid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           login
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    otp
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..uid                  661620133267336
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..ial                  1.1
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aal                  1
    
    
































































































































# =================>





















































































































































# =================>



