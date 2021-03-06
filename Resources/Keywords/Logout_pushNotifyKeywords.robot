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
    Click On Element    ${cbx_term_and_condition}

Click Sign Up
    [Documentation]    Owner: sasipen
    [Arguments]    ${button_sing_up}
    Click On Element    ${button_sing_up}

Verify Page Sing Up Success
    [Documentation]    Owner: sasipen
    Verify Locator Is Visible    ${img_sing_up_success}
    Verify Value At Locator      ${lbl_success_register}           ${success_register}
    Verify Value At Locator      ${lbl_please_confirm_register}    ${please_confirm_register}
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
    ${session_id}    Get Admd Srfp Session    ${ADMD_SRFP_PATH}
    Get Admd Srfp Confirm Link Register       ${ADMD_SRFP_PATH}    ${session_id}
    Set Test Variable    ${X_SESSION_ID_LOGOUT_PUSHNOTIFY}    ${session_id} 
    Set Test Provisioning Data   Link Confirm Register : ${URL_CONFIRM_REGISTER}

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
    Set Content API Body        $..publicId            ldi:${email_for_register}       
    Set Content API Body        $..deleteAllAlias      yes           

Send Post Request Delete Email Register
    [Documentation]    Owner: sasipen
    &{message}    Send Request    POST    url=${API_URL}     headers=${API_HEADER}    body=${API_BODY}    verify=${ssl_verify} 
    Set Test Provisioning Data    ${message}[request]
    Set Test Actual Result        ${message}[response]

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

SSH Connect To Server Get Log Logout Pushnotify
    ${admd_srfc_connection}    Open Connection    ${ssh_admd_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login      ${ssh_admd_user}   ${ssh_admd_pass}
    Log    ${login_log} 
    Set Suite Variable    ${SSH_ADMD_SRFC}    ${admd_srfc_connection}
    ${admd_scf_connection}     Open Connection    ${ssh_admd_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login      ${ssh_admd_user}   ${ssh_admd_pass}
    Log    ${login_log} 
    Set Suite Variable    ${SSH_ADMD_SCF}     ${admd_scf_connection}

Get ADMD SRFP App log
    Switch Connection    ${SSH_ADMD_SRFP}
    Write    reset
    Read     delay=5s
    # Write    cat ${ADMD_SRFP_PATH} | grep ${X_SESSION_ID_LOGOUT_PUSHNOTIFY}  
    Write    cat ${ADMD_SRFP_PATH} | grep ${X_SESSION_ID}  
    ${X_SESSION_ID}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    SRFP AppLog: ${json_format} 

Get ADMD SRFC Path
    Switch Connection    ${SSH_ADMD_SRFC}
    ${admd_srfc_path}    Wait Until Keyword Succeeds    5x    2s    Get Kubectl Path ADMD    admd-srfc     
    Write    reset
    Read     delay=2s  
    ${admd_srfc_path_log}    Wait Until Keyword Succeeds    5x    2s    Get Admd Path    ${admd_srfc_path}    logs/detail    _SRFC.0.detail    
    Set Suite Variable    ${ADMD_SRFC_PATH}    ${admd_srfc_path_log}

Get ADMD SRFC Log Detail
    Switch Connection    ${SSH_ADMD_SRFC}
    Write    reset
    Read     delay=5s
    # Write    cat ${admd_srfp_path_log} | grep ${X_SESSION_ID_LOGOUT_PUSHNOTIFY}
    Write    cat ${ADMD_SRFC_PATH} | grep ${X_SESSION_ID}
    ${X_SESSION_ID}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    SRFC Log Detail: ${json_format} 

Get ADMD SCF Path
    Switch Connection    ${SSH_ADMD_SCF}
    ${admd_scf_path}    Wait Until Keyword Succeeds    5x    2s    Get Kubectl Path ADMD    admd-scf-776c894cb9
    Write    reset
    Read     delay=2s  
    ${admd_scf_path_log}    Wait Until Keyword Succeeds    5x    2s    Get Admd Path    ${admd_scf_path}    logs/detail    _SCF.0.detail    
    Set Suite Variable    ${ADMD_SCF_PATH}    ${admd_scf_path_log}

Get ADMD SCF Log Detail   
    Switch Connection    ${SSH_ADMD_SCF} 
    Write    reset
    Read     delay=5s
    # Write    cat ${admd_scf_path_log} | grep ${X_SESSION_ID_LOGOUT_PUSHNOTIFY}
    Write    cat ${admd_scf_path_log} | grep ${X_SESSION_ID}
    ${X_SESSION_ID}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    SCF Log Detail: ${json_format} 

Keyword Suite Setup For Logout Pushnotify
    Keyword Suite Setup
    SSH Connect To Server Get Log Logout Pushnotify
    Get ADMD SRFC Path
    Get ADMD SCF Path

Keyword Test Teardown For Logout Pushnotify
    Close Browser    ALL
    Run Keyword If Test Passed      Get Admd Log From Server By X Session Id
    Run Keyword If Test Passed      Get ADMD SRFP App log
    Run Keyword If Test Passed      Get ADMD SRFC Log Detail
    Run Keyword If Test Passed      Get ADMD SCF Log Detail