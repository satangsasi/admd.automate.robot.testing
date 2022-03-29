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
    ${json_otp_log}      Get Json OTP Password Log FBB
    ${otp_password}      Get OTP Password From Json    ${json_otp_log}
    Set Test Variable    ${FBB_OTP_PASS}    ${otp_password}

Get Json OTP Password Log FBB
    [Documentation]    Owner: Nakarin
    [Tags]    Keyword_action
    Read    delay=5s
    Write    cat ${ADMD_PATH} | grep -E "${fbb_username}.*oneTimePassword"
    ${string}   Read    delay=1s
    Log    ${string}
    ${json_log}  Get Regexp Matches        ${string}    {.*
    Log Many    @{json_log}
    ${json_otp_log}    Convert String To JSON    ${json_log}[-1]
    Log         ${json_otp_log}
    [Return]    ${json_otp_log}

Verify Decoded Value Access Token FBB OTP
    [Documentation]    Owner: Nakarin
    ...    Decode Then verify decode value of Access Token
    [Tags]    keyword_communicate
    Decoded Access Token
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             fbbid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           login
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    otp
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous

Verify Decoded Value ID Token FBB OTP
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

Verify Response Key FBB OTP
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Response Key    $..access_token
    Verify Response Key    $..expires_in
    Verify Response Key    $..refresh_token
    Verify Response Key    $..refresh_token_expires_in
    Verify Response Key    $..id_token

Verify Response Client Id And Client Secret No Match
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_action
    ${actual_value}    Get Value Response On Web Page By Key    $..error
    Verify Value Should Be Equal    ${actual_value}          ${error_message_invalid_client}
    Take Screenshot Verify Success Scene
    Set Test Actual Result    Response On Web Page : ${actual_value}
Fill Username FBB OTP Number No Contact 
    [Documentation]    Owner: Nakarin
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text    ${txt_fbb_user}    ${fbb_username_no_contact_number}     delay=0.1s
    Set Test Provisioning Data   Username: ${fbb_username_no_contact_number} 

Verify Page Can Not Click Request Otp
    Get Element State    ${btn_fbb_request_otp}     disabled    ==    True
    Verify Locator Is Hidden    ${txt_fbb_contact_number}  
    Take Screenshot Verify Success Scene
    Set Test Actual Result    ${fbb_username_no_contact_number} No contact number. Can not click request otp button    
