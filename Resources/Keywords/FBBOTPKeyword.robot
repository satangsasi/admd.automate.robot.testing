*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Fill Username FBB OTP
    [Documentation]    Owner: Nakarin
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text    ${txt_fbb_user}    ${fbb_username}    delay=0.1s
    Set Test Provisioning Data   Username: ${fbb_username}

Fill OTP Password FBB 
    [Documentation]    Owner: Nakarin
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text    ${txt_fbb_pass}    ${FBB_OTP_PASS}    delay=0.1s
    Set Test Provisioning Data   OTP Password: ${FBB_OTP_PASS}

Click Request OTP Button
    [Documentation]    Owner: Nakarin
    [Tags]    Keyword_communicate
    Click    ${btn_fbb_request_otp}

Press Login Button In FBB OTP
    [Documentation]    Owner: Nakarin
    [Tags]    Keyword_communicate
    Click    ${btn_fbb_login}

Get OTP Password FBB
    [Documentation]    Owner: Nakarin
    ...    Get OTP Password From Server Log
    ...    Then Set Test Variable ${FBB_OTP_PASS}
    [Tags]    keyword_action
    # SSH Connect To Server Log
    ${json_otp_log}      Get Json OTP Password Log FBB
    ${otp_password}      Get OTP Password From Json    ${json_otp_log}
    Set Test Variable    ${FBB_OTP_PASS}    ${otp_password}
    # [Teardown]    Close All Connections

Get Json OTP Password Log FBB
    [Documentation]    Owner: Nakarin
    [Tags]    Keyword_action
    # ${admd_path}        Change Directory Path To Get Log
    # ${mobile_number}    Replace String    ${fbb_contact_number}    0    66    count=1
    Read    delay=5s
    Write    cat ${ADMD_PATH} | grep -E "${fbb_username}.*oneTimePassword"
    ${string}   Read    delay=1s
    Log    ${string}
    ${json_log}  Get Regexp Matches        ${string}    {.*
    Log Many    @{json_log}
    ${json_otp_log}    Convert String To JSON    ${json_log}[-1]
    Log         ${json_otp_log}
    [Return]    ${json_otp_log}

Decoded Access Token
    [Documentation]    Owner: Nakarin
    ...    Decode access_token then return Test Variable ${DECODED_ACCESS_TOKEN} as dot.dict type
    [Tags]    keyword_action
    ${decoded_access_token}   Jwt Decode Dot Dict        ${RESPONSE_JSON_MESSAGE.access_token}
    Set Test Actual Result    Access Token $..aut: ${decoded_access_token.aut}
    Set Test Variable         ${DECODED_ACCESS_TOKEN}    ${decoded_access_token}

Decoded ID Token
    [Documentation]    Owner: Nakarin
    ...    Decode id_token then return Test Variable ${DECODED_ACCESS_TOKEN} as dot.dict type
    [Tags]    keyword_action
    ${decoded_id_token}       Jwt Decode Dot Dict   ${RESPONSE_JSON_MESSAGE.id_token}
    Set Test Actual Result    ID Token $..aut: ${decoded_id_token.aut}
    Set Test Actual Result    ID Token $..info: ${decoded_id_token.info}
    Set Test Variable         ${DECODED_ID_TOKEN}     ${decoded_id_token}

Verify Decoded Value Access Token
    [Documentation]    Owner: Nakarin
    ...    Decode Then verify decode value of Access Token
    [Tags]    keyword_communicate
    Decoded Access Token
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             fbbid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           login
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    otp
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous

Verify Decoded Value ID Token
    [Documentation]    Owner: Nakarin
    ...    Decode Then verify decode value of ID Token
    [Tags]    keyword_communicate
    Decoded ID Token
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type               fbbid
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action             login
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.login_channel      otp
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.network            anonymous
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.public_id         88XXXX1012
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.public_id_type    fbbid
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.contact_number    093xxx5569
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.operator_id       awn
