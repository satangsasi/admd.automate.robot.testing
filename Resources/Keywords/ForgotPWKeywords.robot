*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Press Forgot Password Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Click    ${lbl_forgot_password}

Fill Mobile Number Forgot PW
    [Documentation]    Owner: Nakarin
    ...    ${forgot_pw_mobile_number}    0981721044
    [Tags]    keyword_communicate
    Type Text    ${txt_username_forgot_pw}    ${forgot_pw_mobile_number}    delay=0.1s

Get Json OTP Password Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_command
    Read    delay=5s
    ${number}    Replace String    ${forgot_pw_mobile_number}    0    66    count=1
    Write    cat ${ADMD_PATH} | grep -E "${number}.*oneTimePassword"
    ${string}   Read    delay=1s
    Log    ${string}
    ${json_log}  Get Regexp Matches        ${string}    {.*
    Log Many    @{json_log}
    ${json_otp_log}    Convert String To JSON    ${json_log}[-1]
    Log         ${json_otp_log}
    [Return]    ${json_otp_log}

Get OTP Password Forgot PW
    [Documentation]    Owner: Nakarin
    ${json_log}        Get Json OTP Password Forgot PW
    ${otp_password}    Get OTP Password From Json    ${json_log}
    Set Test Variable    ${OTP_PASSWORD}    ${otp_password}

Fill OTP Password Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    @{otp_number}    Split String To Characters    ${OTP_PASSWORD}
    ${i}      Set Variable    1
    FOR    ${number}    IN    @{otp_number}
        Type Text    //*[@id="fotp${i}"]    ${number}    delay=0.1s
        ${i}    Evaluate    ${i}+1
    END

Fill Question 1 And Question 2 Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Type Text    ${txt_question1_forget_pw}    ${forgot_pw_question1}    delay=0.1s
    Type Text    ${txt_question2_forget_pw}    ${forgot_pw_question2}    delay=0.1s

Fill New Password Forgot PW
    [Documentation]    Owner: Nakarin
    Type Text    ${txt_reset_password_forget_pw}      ${forgot_pw_new_password}    delay=0.1s
    Type Text    ${txt_confirm_password_forget_pw}    ${forgot_pw_new_password}    delay=0.1s

Verify Decoded Value Access Token Forgot PW
    [Documentation]    Owner: Nakarin
    Decoded Access Token
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..uid                  661630070398713
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             msisdn
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           forgot
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    msisdn_password
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp                  rob
Verify Decoded Value ID Token Forgot PW
    [Documentation]    Owner: Nakarin
    Decoded ID Token
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type             msisdn
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action           forgot
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.login_channel    msisdn_password
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.network          anonymous
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.public_id       669xxx21044
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.firstname       test1
    Run Keyword And Continue On Failure    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.lastname        test2

Verify Response Key Forgot PW
    [Documentation]    Owner: Nakarin
    Run Keyword And Continue On Failure    Verify Response Key From Webpage    $..access_token
    Run Keyword And Continue On Failure    Verify Response Key From Webpage    $..token_type
    Run Keyword And Continue On Failure    Verify Response Key From Webpage    $..expires_in
    Run Keyword And Continue On Failure    Verify Response Key From Webpage    $..refresh_token
    Run Keyword And Continue On Failure    Verify Response Key From Webpage    $..refresh_token_expires_in
    Run Keyword And Continue On Failure    Verify Response Key From Webpage    $..id_token



































































































































































































Press Forgot Password link
    [Documentation]    Owner: sasipen
    Click    ${llb_forgot_password}

Fill Email Or Number For Reset Password
    [Documentation]    Owner: sasipen
    [Arguments]    ${email_number}
    Type Text      ${txt_email_number_reset_password}    ${email_number}     delay=0.1s
    Set Test Provisioning Data   Email: ${email_number}
Press Next Button
    [Documentation]    Owner: sasipen
    Click    ${btn_next_reset_password}
    
Verify Email Invalid On Webpage
    [Documentation]    Owner: sasipen
    ...    Verify Text show on webpage : Email is wrong
    ...    Verify Text show on webpage : Please check your Email.
    [Tags]    keyword_communicate
    ${actual_error_email_wrong}    Get Text    ${lbl_error_email_wrong}
    ${actual_error_check_email}    Get Text    ${lbl_error_check_email}
    Verify Value Should Be Equal    ${actual_error_email_wrong}    ${error_email_wrong}
    Verify Value Should Be Equal    ${actual_error_check_email}    ${error_check_email}
    Verify Locator Is Visible       ${btn_close_error_box} 
    Take Screenshot Verify Success Scene
    Set Test Actual Result     ${actual_error_email_wrong}
    Set Test Actual Result     ${actual_error_check_email}

Fill Email In Web Page
    Type Text    ${txt_email_number_gmail}    ${email_login_gmail}     delay=0.1s

Press Next Button Gmail Login
    Click    ${btn_next_gmail}
    
Fill Password Email In Web Page
    Verify Locator Is Visible    ${btn_try_again} 
    Type Text    ${txt_password_gmail}    ${password_login_gmail}}     delay=0.1s
Press Next Button Password Gmail Login
    Click    ${btn_password_next_gmail}
    Wait Until Network Is Idle    ${verify_timeout}