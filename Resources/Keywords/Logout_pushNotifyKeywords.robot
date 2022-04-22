*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Fill Information For Register
    [Documentation]    Owner: sasipen
    ...    email: testrobot202203@gmail.com password : robot@2022  first name :robot   last name : test
    Type Text In Element    ${txt_email_register}               ${email_for_register}
    Type Text In Element    ${txt_password_register}            ${password_for_register}
    Type Text In Element    ${txt_confirm_password_register}    ${password_for_register}
    Type Text In Element    ${txt_firstname_register}           ${firstname_for_register}
    Type Text In Element    ${txt_lastname_register}            ${lastname_for_register}
    Set Test Provisioning Data    Email: ${email_for_register}
    Set Test Provisioning Data    Password: ${password_for_register}
    Set Test Provisioning Data    First Name: ${firstname_for_register}
    Set Test Provisioning Data    Last Name: ${lastname_for_register}

Click Accept Term And Condition
    [Documentation]    Owner: sasipen
    Click On Element    ${chk_term_and_condition}

Click Sign Up Button
    [Documentation]    Owner: sasipen
    [Arguments]    ${button_sing_up}
    Click On Element    ${button_sing_up}

Verify Page Sing Up Success
    Verify Locator Is Visible    ${img_sing_up_success}
    Verify Value At Locator      ${lbl_success_register}           ${success_register}
    Verify Value At Locator      ${lbl_please_confirm_register}    ${please_confirm_register}
    ${text_please}    Get Text    ${lbl_please_confirm_register}
    Log    ${text_please}    
    Take Screenshot Verify Success Scene
    
Get Admd Srfp Confirm Link Register
    [Documentation]    Owner: sasipen
    ...     find Confirm Link Register form log server by text mailServer and session id 
    [Arguments]    ${admd_path}    ${session} 
    Write    reset
    Read     delay=5s
    Write    cat ${admd_path} | grep -E "mailServer.*${session}"
    ${output}      Read    delay=2s
    Log    ${output} 
    ${json_format}    Get Regexp Matches    ${output}    {.*
    Log Many    @{json_format}
    ${json_confirmlink_register}   Convert String To JSON    ${json_format}[0]   
    ${confirmlink_register}    Get Value Json By Key    ${json_confirmlink_register}    $..custom1.Message[1].link
    Log    ${confirmlink_register}  
    IF        ${REGRESSION} == True
        ${confirmlink_register}       Replace String     ${confirmlink_register}     https://iot-apivr.ais.co.th       https://10.137.30.22 
    END    
    Set Test Variable    ${URL_CONFIRM_REGISTER}    ${confirmlink_register}

Get Link Confirm Register Form Server
    [Documentation]    Owner: sasipen
    ${srfp_path}     Get Admd Srfp Path
    ${session_id}    Get Admd Srfp Session    ${srfp_path}
    Get Admd Srfp Confirm Link Register       ${srfp_path}    ${session_id}

Verify Response On Webpage Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Response Key    $..access_token
    Verify Response Key    $..refresh_token
    Verify Response Key    $..id_token
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..token_type                  bearer 
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..expires_in                  7200
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..refresh_token_expires_in    86400

Verify Decoded Value Access Token Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..ssid
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..uid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type      email_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action    register
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp           ldi

Verify Decoded Value Id Token Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type          email_password
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action        forgot
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.firstname    ${firstname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.lastname     ${lastname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.username     ${email_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.accountCategory     residential
    Verify Contain Any Value Decode Jwt     ${DECODED_ID_TOKEN}    $..nonce