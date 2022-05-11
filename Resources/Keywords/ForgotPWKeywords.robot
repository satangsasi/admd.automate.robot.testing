*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Press Forgot Password
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Click On Element    ${lbl_forgot_password}
    [Teardown]    Get AAF5G Log

Fill Mobile Number Forgot Password
    [Documentation]    Owner: Nakarin
    ...    \r\n${forgot_pw_mobile_number}
    ...    \r\nMobile Number = 0981721044
    [Tags]    keyword_communicate
    Type Text In Text Box    ${txt_username_forgot_pw}    ${forgot_pw_mobile_number}
    Set Test Variable       ${USERNAME}       ${forgot_pw_mobile_number}
    Set Test Provisioning Data    Username: ${forgot_pw_mobile_number}
    
Get Json OTP Password Forgot PW
    [Documentation]    Owner: Nakarin    Editor: Atitaya  , Sasipen
    ...    Edit : add keyword Switch Connection ${SSH_ADMD_DEV}
    [Tags]    keyword_command
    ${number}    Replace String    ${forgot_pw_mobile_number}    0    66    count=1
    Switch Connection    ${SSH_ADMD_DEV}
    Write    cat ${ADMD_PATH} | grep -E "${number}.*oneTimePassword"
    ${string}   Read    delay=1s
    Log    ${string}
    ${json_log}  Get Regexp Matches        ${string}    {.*
    Log Many    @{json_log}
    ${json_otp_log}    Convert String To JSON    ${json_log}[-1]
    Log         ${json_otp_log}
    [Return]    ${json_otp_log}

Get OTP Password Forgot Password
    [Documentation]    Owner: Nakarin
    ...    Getting OTP Password for Forgot PW
    [Tags]    keyword_communicate
    Switch Connection    ${SSH_ADMD_DEV}
    ${json_log}        Get Json OTP Password Forgot PW
    ${otp_password}    Get OTP Password From Json    ${json_log}
    Set Test Variable    ${OTP_PASSWORD}    ${otp_password}

Fill OTP Password Forgot Password
    [Documentation]    Owner: Nakarin
    ...    The txt box in webpage have own xpath and can detect typing
    [Tags]    keyword_action
    @{otp_number}    Split String To Characters    ${OTP_PASSWORD}
    ${i}      Set Variable    1
    FOR    ${number}    IN    @{otp_number}
        Type Text In Text Box    //*[@id="fotp${i}"]    ${number}
        ${i}    Evaluate    ${i}+1
    END
    Set Test Provisioning Data    OTP Password: ${OTP_PASSWORD}

Fill Question 1 And Question 2 Forgot Password
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Type Text In Text Box    ${txt_question1_forget_pw}    ${forgot_pw_question1}    
    Type Text In Text Box    ${txt_question2_forget_pw}    ${forgot_pw_question2}    

Fill New Password Forgot Password
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Type Text In Text Box    ${txt_reset_password_forget_pw}      ${forgot_pw_new_password_moile}   
    Type Text In Text Box    ${txt_confirm_password_forget_pw}    ${forgot_pw_new_password_moile}    

Verify Decoded Value Access Token Forgot PW
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Decoded Access Token
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..uid                  661640096682863
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             msisdn
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           forgot
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    msisdn_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp                  rob

Verify Decoded Value ID Token Forgot Password
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

Verify Response Key Forgot Password
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Verify Response Key    $..access_token
    Verify Response Key    $..token_type
    Verify Response Key    $..expires_in
    Verify Response Key    $..refresh_token
    Verify Response Key    $..refresh_token_expires_in
    Verify Response Key    $..id_token

Click Button Submit
    [Documentation]    Owner: sasipen
    [Arguments]    ${path_button}
    Click On Element    ${path_button}   

Fill Email For Reset Password
    [Documentation]    Owner: sasipen
    ...    ${email} = testrobot202203@gmail.com
    [Arguments]    ${email}
    Type Text In Text Box      ${txt_username_forgot_pw}    ${email}     
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

Get Admd Srfp Session
    [Documentation]    Owner: sasipen
    ...     find session id form log server by email send forgot password
    [Arguments]    ${admd_path}
    Switch Connection    ${SSH_ADMD_SRFP}
    Write    reset
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
    Set Test Variable    ${X_SESSION_ID_SEND_EMAIL}    ${session}
    
Get Admd Srfp Confirm Link New Password
    [Documentation]    Owner: sasipen
    ...     find Confirm Link New Password form log server by text confirmLink and session id 
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
    IF        ${REGRESSION} == True
        ${confirmlink}       Replace String     ${confirmlink}     https://iot-apivr.ais.co.th       https://10.137.30.22 
    END    
    Set Test Variable    ${URL_CONFIRM_NEW_PASSWORD}    ${confirmlink}

Get Link Confirm New Password Form Server
    [Documentation]    Owner: sasipen
    ...    link confirm new password set name > ${URL_CONFIRM_NEW_PASSWORD} 
    ${session_id}    Get Admd Srfp Session    ${ADMD_SRFP_PATH}
    Get Admd Srfp Confirm Link New Password   ${ADMD_SRFP_PATH}    ${session_id}      
    Set Test Provisioning Data   Link Confirm New Password : ${URL_CONFIRM_NEW_PASSWORD}

Fill New Password 
    [Documentation]    Owner: sasipen
    ...    ${new_password_email} = robot@2022
    Type Text In Text Box      ${txt_new_password}            ${new_password_email}     
    Type Text In Text Box      ${txt_confirm_new_password}    ${new_password_email}     
    Set Test Provisioning Data   New Password : ${new_password_email}       

Verify Send Link Confirm New Password Succeeds
    [Documentation]    Owner: sasipen
    Verify Locator Is Visible     ${img_send_succeeds}   
    Verify Value At Locator       ${lbl_succeeds}                      ${succeeds_send_email_reset_pw} 
    Verify Value At Locator       ${lbl_succeeds_check_your_email}     ${succeeds_check_email_reset_pw} 
    Take Screenshot Verify Success Scene

Verify Response On Webpage Forgot Password
    [Documentation]    Owner: sasipen
    Verify Response Key    $..access_token
    Verify Response Key    $..refresh_token
    Verify Response Key    $..id_token
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..token_type                  bearer 
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..expires_in                  86400
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..refresh_token_expires_in    86400

Verify Decoded Value Access Token Forgot Password By Email
    [Documentation]    Owner: sasipen
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..uid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type      email_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action    forgot
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp           rob

Verify Decoded Value ID Token Forgot Password By Email
    [Documentation]    Owner: sasipen
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type                email_password
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action              forgot
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.firstname          robot
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.lastname           test
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.username           testrobot202203@gmail.com
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.accountCategory    residential
    Verify Contain Any Value Decode Jwt     ${DECODED_ID_TOKEN}    $..nonce

# Keyword Test Teardown For Forgot Password By Email
#     Switch Connection  ${SSH_ADMD}
#     Exit SSH Connect ADMD
#     Keyword Test Teardown
    
Verify Response Forgot Password With Duplicate Authen Code
    [Documentation]    Owner: sasipen
    ${actual_value}    Get Value Response On Web Page By Key    $..error
    Verify Value Should Be Equal    ${actual_value}          ${error_message_invalid_grant} 
    Take Screenshot Verify Success Scene

Open Link And Confirm New Password Again
    [Documentation]    Owner: sasipen
    New Page               ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit    ${btn_submit_new_password}                

Verify Error After Confirm New Password 2 Times 
    [Documentation]    Owner: sasipen
    Verify Locator Is Visible    ${img_send_fail}      
    Verify Value At Locator      ${lbl_error_somthing_wrong}      ${error_somthing_wrong}                      
    Verify Value At Locator      ${lbl_error_please_try_again}    ${error_please_try_again}
    Take Screenshot Verify Success Scene

Verify Response Forgot Password Authcode Expired
    [Documentation]    Owner: sasipen
    ${actual_value}    Get Value Response On Web Page By Key    $..error
    Verify Value Should Be Equal    ${actual_value}          ${error_message_invalid_grant} 
    Take Screenshot Verify Success Scene

Verify Response Forgot Password Invalid Client Id
    [Documentation]    Owner: sasipen
    ${actual_value}    Get Value Response On Web Page By Key    $..error
    Verify Value Should Be Equal    ${actual_value}          ${error_message_invalid_grant} 
    Take Screenshot Verify Success Scene

Verify Response Forgot Password Invalid Client Secret
    [Documentation]    Owner: sasipen
    ${actual_value}    Get Value Response On Web Page By Key    $..error
    Verify Value Should Be Equal    ${actual_value}          ${error_message_invalid_client} 
    Take Screenshot Verify Success Scene

Verify Response Forgot Password Missing Client Id
    [Documentation]    Owner: sasipen
    ${actual_value}    Get Value Response On Web Page By Key    $..error
    Verify Value Should Be Equal    ${actual_value}          ${error_message_invalid_request}
    Take Screenshot Verify Success Scene
