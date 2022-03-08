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

Click Request OTP
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
    SSH Connect To 10.137.30.22
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