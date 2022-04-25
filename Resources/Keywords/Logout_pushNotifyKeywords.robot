*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Fill Information For Register
    [Documentation]    Owner: sasipen
    ...    email: testrobot202203@gmail.com password : robot@2022  first name :robot   last name : test
    Type Text In Text Box    ${txt_email_register}               ${email_for_register}
    Type Text In Text Box    ${txt_password_register}            ${password_for_register}
    Type Text In Text Box    ${txt_confirm_password_register}    ${password_for_register}
    Type Text In Text Box    ${txt_firstname_register}           ${firstname_for_register}
    Type Text In Text Box    ${txt_lastname_register}            ${lastname_for_register}
    Set Test Provisioning Data    Email: ${email_for_register}
    Set Test Provisioning Data    Password: ${password_for_register}
    Set Test Provisioning Data    First Name: ${firstname_for_register}
    Set Test Provisioning Data    Last Name: ${lastname_for_register}

Click Accept Term And Condition
    [Documentation]    Owner: sasipen
    Click On Element    ${chk_term_and_condition}

Click Sign Up
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

Verify Decoded Value Access Token Register Email Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..ssid
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..uid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type      email_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action    register
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp           ldi

Verify Decoded Value Id Token Register Email Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type          email_password
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action        register
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.firstname    ${firstname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.lastname     ${lastname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.username     ${email_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.accountCategory     residential
    Verify Contain Any Value Decode Jwt     ${DECODED_ID_TOKEN}    $..nonce

Set API Header Delete Email Register
    [Documentation]    Owner: sasipen
    Set Content API Header    key=${header_content_type}    value=${content_type_json}    append=False
    Set Test Variable         ${API_URL}         ${url_delete_email_register} 

Set API Body Delete Email Register
    [Documentation]    Owner: sasipen
    Get Time Nonce
    Set Content API Body        $..publicId            ldi:${email_for_register}       
    Set Content API Body        $..deleteAllAlias      yes           

Send Post Request Delete Email Register
    [Documentation]    Owner: sasipen
    &{message}    Send Request    POST    url=${API_URL}     headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify} 
    Set Test Provisioning Data    ${message}[request]

Keyword Test Set Up Delete Email Register
    [Documentation]    Owner: sasipen
    ...     add keyword delete profile email register for user email register (testrobot202203@gmail.com) all time
    Set API Header Delete Email Register
    Set API Body Delete Email Register
    Send Post Request Delete Email Register

Fill Email And Password For Sing In
    [Documentation]    Owner: sasipen
    ...    email: testrobot202203@gmail.com password : robot@2022 
    Type Text In Text Box    ${txt_email_sing_in}               ${email_for_register}
    Type Text In Text Box    ${txt_password_sing_in}            ${password_for_register}
    Set Test Provisioning Data    Email: ${email_for_register}
    Set Test Provisioning Data    Password: ${password_for_register}

Click Sing In    
    [Documentation]    Owner: sasipen
    Click On Element    ${btn_sign_in_page_login}
    
Verify Decoded Value Access Token Sing In Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..ssid
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..uid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type      email_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action    login
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp           ldi

Verify Decoded Value Id Token Sing In Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type          email_password
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action        login
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.firstname    ${firstname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.lastname     ${lastname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.username     ${email_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.accountCategory     residential
    Verify Contain Any Value Decode Jwt     ${DECODED_ID_TOKEN}    $..nonce

Sing In And Open Link Get Token
    Create Browser Session      ${url_registered_logout_pushnotify}
    Fill Email And Password For Sing In
    Click Sing In
    Create URL For Get Token    ${url_get_token_logout_pushnotify}
    New Page                    ${URL_GET_TOKEN}

Verify Decoded Value Access Token Sso Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..ssid
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..uid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type      email_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action    sso
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp           ldi

Verify Decoded Value Id Token Sso Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.type          email_password
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..aut.action        sso
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.firstname    ${firstname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.lastname     ${lastname_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.username     ${email_for_register}
    Verify Value Json By Key    ${DECODED_ID_TOKEN}    $..info.accountCategory     residential
    Verify Contain Any Value Decode Jwt     ${DECODED_ID_TOKEN}    $..nonce

Create URL For Get Refresh Token Logout Pushnotify
    [Documentation]     Owner : sasipen
    ...    Append ${CODE_REFRESH_TOKEN}(link get refresh token) to get refresh token Url 
    ${code_refresh_token}    Get Value Response On Web Page By Key    $..refresh_token
    ${url_get_refresh_token}     Replace String      ${url_get_refresh_token_logout_pushnotify}    _code_    ${code_refresh_token}
    Set Test Variable    ${URL_GET_REFRESH_TOKEN}    ${url_get_refresh_token}
    Log    ${URL_GET_REFRESH_TOKEN}

Verify Response On Webpage Refresh Token Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Response Key    $..access_token
    Verify Response Key    $..refresh_token
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..token_type                  bearer 
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..expires_in                  7200
    Verify Value Json By Key    ${RESPONSE_JSON_MESSAGE}    $..refresh_token_expires_in    86400
Verify Decoded Value Access Token Refresh Token Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..ssid
    Verify Contain Any Value Decode Jwt     ${DECODED_ACCESS_TOKEN}    $..uid
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.type             email_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.action           refresh
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.login_channel    email_password
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..aut.network          anonymous
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..idp                  ldi
    Verify Value Json By Key    ${DECODED_ACCESS_TOKEN}    $..ial                  1.1

Set API Header Logout Pushnotify
    [Documentation]    Owner: sasipen
    Set Content API Header    key=${header_content_type}    value=${content_type_x_www}    append=False
    Set Test Variable         ${API_URL}         ${url_logout_pushnotify}

Set API Body Logout Pushnotify
    [Documentation]    Owner: sasipen
    Get Time Nonce
    ${value_access_token}    Get Value Response On Web Page By Key    $..access_token   
    Set Content API Body        $..access_token      ${value_access_token} 
    Set Content API Body        $..state             Logout Push Noti (1.10)    

Send Post Request Logout Pushnotify
    [Documentation]    Owner: sasipen
    &{message}    Send Request    POST    url=${API_URL}     headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify}
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]

Verify Response Logout Pushnotify
    [Documentation]    Owner: sasipen
    Verify Value Response By Key        $..state        Logout Push Noti (1.10)