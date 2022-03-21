*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Press Forgot Password Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Click    ${lbl_forgot_password}
    Wait Until Network Is Idle    ${verify_timeout}

Press Next Button Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    # @{btn_next}    Create List    ${btn_next1_forgot_pw}    ${btn_next2_forgot_pw}    ${btn_next3_forgot_pw}    ${btn_next4_forgot_pw}
    # FOR    ${xpath}    IN    @{btn_next}
    #     ${status}    Run Keyword And Return Status    Get Element State    selector=${xpath}    state=visible
    #     IF    ${status} == True
    #         Wait For Elements State    selector=${xpath}    state=enabled    timeout=${verify_timeout}
    #         Click    ${xpath}
    #         Exit For Loop
    #     END
    # END
    ${status}    Run Keyword And Return Status    Variable Should Exist    ${BTN_COUNT}
    ${count}     Set Variable If    ${status} == False    0    ${BTN_COUNT}
    Wait For Elements State    selector=${btn_next_forgot_pw}[${count}]    state=enabled    timeout=${verify_timeout}
    Click    ${btn_next_forgot_pw}[${count}]
    ${count}    Evaluate    ${count} + 1
    Set Test Variable    ${BTN_COUNT}   ${count}
    Wait Until Network Is Idle    ${verify_timeout}

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
    @{otp}    Split String To Characters    ${OTP_PASSWORD}
    ${i}      Set Variable    1
    FOR    ${character}    IN    @{otp}
        Type Text    //*[@id="fotp${i}"]    ${character}    delay=0.1s
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