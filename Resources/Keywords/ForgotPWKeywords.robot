*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Press Forgot Password Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Click    ${lbl_forgot_password}

Fill Mobile Number Forgot PW
    [Documentation]    Owner: Nakarin
    ...    \r\n${forgot_pw_mobile_number}
    ...    \r\nMobile Number = 0981721044
    [Tags]    keyword_communicate
    Type Text    ${txt_username_forgot_pw}    ${forgot_pw_mobile_number}    delay=0.1s
    Set Test Provisioning Data    Username: ${forgot_pw_mobile_number}

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
    ...    Getting OTP Password for Forgot PW
    [Tags]    keyword_communicate
    ${json_log}        Get Json OTP Password Forgot PW
    ${otp_password}    Get OTP Password From Json    ${json_log}
    Set Test Variable    ${OTP_PASSWORD}    ${otp_password}

Fill OTP Password Forgot PW
    [Documentation]    Owner: Nakarin
    ...    The txt box in webpage have own xpath and can detect typing
    [Tags]    keyword_action
    @{otp_number}    Split String To Characters    ${OTP_PASSWORD}
    ${i}      Set Variable    1
    FOR    ${number}    IN    @{otp_number}
        Type Text    //*[@id="fotp${i}"]    ${number}    delay=0.1s
        ${i}    Evaluate    ${i}+1
    END
    Set Test Provisioning Data    OTP Password: ${OTP_PASSWORD}

Fill Question 1 And Question 2 Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Type Text    ${txt_question1_forget_pw}    ${forgot_pw_question1}    delay=0.1s
    Type Text    ${txt_question2_forget_pw}    ${forgot_pw_question2}    delay=0.1s

Fill New Password Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Type Text    ${txt_reset_password_forget_pw}      ${forgot_pw_new_password}    delay=0.1s
    Type Text    ${txt_confirm_password_forget_pw}    ${forgot_pw_new_password}    delay=0.1s

Verify Decoded Value Access Token Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Decoded Access Token
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..uid                  661630070398713
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             msisdn
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           forgot
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    msisdn_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp                  rob

Verify Decoded Value ID Token Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Decoded ID Token
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type             msisdn
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action           forgot
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.login_channel    msisdn_password
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.network          anonymous
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.public_id       669xxx21044
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.firstname       test1
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.lastname        test2

Verify Response Key Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Response Key    $..access_token
    Verify Response Key    $..token_type
    Verify Response Key    $..expires_in
    Verify Response Key    $..refresh_token
    Verify Response Key    $..refresh_token_expires_in
    Verify Response Key    $..id_token

Fill Email For Reset Password
    [Documentation]    Owner: sasipen
    [Arguments]    ${email}
    Type Text      ${txt_username_forgot_pw}    ${email}     delay=0.1s
    Set Test Provisioning Data   Email: ${email}
    
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

Open New SSH Connect 
    [Documentation]    Owner: sasipen
    Close Connection 
    SSH Connect To Server Log

Get Admd Srfp Path
    [Documentation]    Owner: sasipen
    Switch Connection    ${SSH_ADMD}
    Write     kubectl exec -it admd-srfp-69c8f85ddc-xjxsn -n admd sh 
    ${output}    Read    delay=2s
    Write    cd logs/appLog/
    Write    ls -lrt | tail
    ${output}    Read    delay=2s
    Log    ${output}
    @{output_line}    Split To Lines        ${output}
    @{cat_path}       Get Regexp Matches    ${output_line}[-2]    (\\w\\S+)
    Write    reset
    Read     delay=5s  
    Log Many    @{cat_path}
    Should Contain    ${cat_path}[-1]    SRFP.0.log    msg=Can't get "admd-srfp-69c8f85ddc-xjxsn_SRFP.0.log"  values=False
    ${srfp_path}    Set Variable    ${cat_path}[-1]
    [Return]    ${srfp_path}    

Get Admd Srfp Session
    [Documentation]    Owner: sasipen
    ...     find session id form log server by email send forgot password
    [Arguments]    ${admd_path}
    Write    cat ${admd_path} | grep -E "testrobot202203@gmail.com.*Session" 
    ${output}      Read    delay=2s
    Log    ${output} 
    ${json_log}    Get Regexp Matches    ${output}    {.*
    ${json_session_log}    Convert String To JSON    ${json_log}[-1]
    Log    ${json_session_log}
    ${session_log}    Get Value Json By Key    ${json_session_log}    $..Session
    Log    ${session_log}  
    @{session_value}    Split String    ${session_log}    :
    Log    ${session_value}[0]
    ${session}    Set Variable    ${session_value}[0]
    [Return]    ${session}    
    
Get Admd Srfp Confirm Link New Password
    [Documentation]    Owner: sasipen
    [Arguments]    ${admd_path}    ${session} 
    Write    reset
    Read     delay=5s
    Write    cat ${admd_path} | grep -E "confirmLink.*${session}"
    ${output}      Read    delay=2s
    Log    ${output} 
    ${json_format}    Get Regexp Matches    ${output}    {.*
    Log Many    @{json_format}
    ${json_confirmlink}   Convert String To JSON    ${json_format}[0]   
    ${confirmlink}    Get Value Json By Key    ${json_confirmlink}    $..custom1.Message[1]
    Log    ${confirmlink}  
    Set Test Variable    ${URL_CONFIRM_NEW_PASSWORD}    ${confirmlink}

Get Confirm New Password Link Form Server
    [Documentation]    Owner: sasipen
    ...    link confirm new password set name > ${URL_CONFIRM_NEW_PASSWORD} 
    ${srfp_path}     Get Admd Srfp Path
    ${session_id}    Get Admd Srfp Session    ${srfp_path}
    Get Admd Srfp Confirm Link New Password   ${srfp_path}    ${session_id}      
   
            

