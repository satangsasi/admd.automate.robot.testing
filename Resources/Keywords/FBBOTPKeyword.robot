*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Fill Username FBB OTP
    [Documentation]    Owner: Nakarin
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text    ${txt_fbb_user}    ${fbb_user_validate_token}    delay=0.1s
    Set Test Provisioning Data   Username: ${fbb_user_validate_token}

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

Click Login Button In FBB OTP
    [Documentation]    Owner: Nakarin
    [Tags]    Keyword_communicate
    Click    ${btn_fbb_login}

Get OTP Password FBB
    [Documentation]    Owner: Nakarin
    ...    Get OTP Password From Server Log
    ...    Then Set Test Variable ${FBB_OTP_PASS}
    SSH Connect To Server Log
    ${json_otp_log}      Get Json OTP Password Log FBB
    ${otp_password}      Get OTP Password From Json    ${json_otp_log}
    Set Test Variable    ${FBB_OTP_PASS}    ${otp_password}

Get Json OTP Password Log FBB
    [Documentation]    Owner: Nakarin
    [Tags]    Keyword_action
    ${admd_path}        Change Directory Path To Get Log
    ${mobile_number}    Replace String    ${fbb_user_validate_token}    0    66    count=1
    Write    cat ${admd_path} | grep -E "${mobile_number}.*oneTimePassword"
    ${string}   Read    delay=1s
    Log    ${string}
    ${json_log}  Get Regexp Matches        ${string}    {.*
    Log Many    @{json_log}
    ${json_otp_log}    Convert String To JSON    ${json_log}[-1]
    Log         ${json_otp_log}
    [Return]    ${json_otp_log}

Create URL For Get Token FBB OTP
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Append Token(get from Auth Url) to get Token(API) Url
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    ...    - Change Variable to ${url_for_token_validate_token}
    [Tags]    keyword_communicate
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_for_token_validate_token}    _code_    ${CODE}
    Set Test Provisioning Data    Get Token URL: ${url_get_token}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}

Decode Access Token
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${decode_access_token}    JWT Decode    ${RESPONSE_JSON_MESSAGE}[access_token]
    Set Test Actual Result    Access Token: ${decode_access_token}
    ${decode_id_token}        JWT Decode    ${RESPONSE_JSON_MESSAGE}[id_token]
    Set Test Actual Result    Access Token: ${decode_id_token}
