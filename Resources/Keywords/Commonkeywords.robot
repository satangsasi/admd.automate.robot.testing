*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Variables ***
${HEAD_LESS}    True
${BROWSER}      chromium


*** Keywords ***
Append To Document Teardown
    [Documentation]    Owner: Nakarin
    ...    Create Document of Provisioning Data(in order list) and Actual Result
    [Tags]    keyword_communicate
    # Set Test Provisioning Data    Request ${TYPE_REQUEST} : ${API_URL}
    # Set Test Provisioning Data    Header : ${API_HEADER}
    # Set Test Provisioning Data    Body : ${API_BODY}
    Run Keyword And Ignore Error    Set Test Provisioning Data    User : ${USER}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Password : ${PASS}
    # Set Test Provisioning Data    Authentication URL : ${URL_AUTH}
    # Set Test Provisioning Data    Get Token URL : ${URL_GET_TOKEN}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Get Refresh Token URL : ${URL_GET_REFRESH_TOKEN}
    Set Test Documentation Detail
    
SSH Connect To Server Log
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Connected to 10.137.30.22
    ...    *** Variables ***
    ...    ${ssh_admd_ip_address}    10.137.30.22
    ...    ${ssh_admd_user}          serveradm
    ...    ${ssh_admd_pass}          R3dh@t!@#
    [Tags]    keyword_action
    ${admd_connection}       Open Connection    ${ssh_admd_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login    ${ssh_admd_user}         ${ssh_admd_pass}
    Log    ${login_log}    # ADMD Connection
    ${aaf5g_connection}      Open Connection    ${ssh_aaf5g_ip_address}    prompt=$    timeout=${default_timeout}
    ${login_log}    Login    ${ssh_aaf5g_user}        ${ssh_aaf5g_pass}
    Log    ${login_log}    # AAF5G Connection
    Set Suite Variable    ${SSH_ADMD}     ${admd_connection}
    Set Suite Variable    ${SSH_AAF5G}    ${aaf5g_connection}
    
Change Directory Path To Get ADMD Log
    [Documentation]    Owner: Nakarin
    ...    Change to get log directory although old path was change - (deployed)
    ...    [Return] the admd path to get log with grep
    [Tags]    keyword_action
    Switch Connection    ${SSH_ADMD}
    ${kubectl_path}    Wait Until Keyword Succeeds    5x    2s    ADMD Get Kubectl Path
    Write    reset
    Read     delay=5s    # Wait for screen reset
    ${admd_path}    Wait Until Keyword Succeeds    5x    2s    ADMD Get Kubectl Grep Path    ${kubectl_path}
    [Return]    ${admd_path}

ADMD Get Kubectl Grep Path
    [Documentation]    Owner: Nakarin
    ...    Recieve ${kubectl_path} then change directory to ${kubectl_path} 
    ...    then return ${cat_path} to get log
    [Tags]    keyword_command
    [Arguments]    ${kubectl_path}
    Write    kubectl exec -it ${kubectl_path} -n admd sh
    Write    cd logs/detail/
    Write    ls -lrt | tail
    ${output}      Read    delay=2s
    Log    ${output}
    @{output_line}    Split To Lines        ${output}
    @{cat_path}       Get Regexp Matches    ${output_line}[-2]    (\\w\\S+)
    Write    reset
    Read     delay=5s    # Wait for screen reset
    Log Many    @{cat_path}
    Should Contain    ${cat_path}[-1]    admd.0.detail    msg=Can't get "${kubectl_path}[0].admd.0.detail" with 'kubectl exec -it ${kubectl_path}[0] -n admd sh' command    values=False
    [Return]    ${cat_path}[-1]

ADMD Get Kubectl Path
    [Documentation]    Owner: Nakarin
    ...    Read output of ssh command then return the last Kubectl path
    [Tags]    keyword_command
    Write    kubectl get pod -n admd
    ${output}          Read    delay=1s
    Log    ${output}
    @{output_line}     Split To Lines        ${output}
    @{kubectl_path}    Get Regexp Matches    ${output_line}[-2]    (\\w\\S+)
    Log Many    @{kubectl_path}
    Should Contain    ${kubectl_path}[0]    admd    msg=Can't get any item with 'kubectl get pod -n admd' command    values=False
    [Return]    ${kubectl_path}[0]

Get OTP Password From Json
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...     Get OTP Value from Json that return from SSH Command
    [Tags]    keyword_action
    [Arguments]    ${json_log}
    ${otp_password}        Get Value Json By Key    ${json_log}    $..custom.Input[0].Data.Body.sendOneTimePWResponse.oneTimePassword
    Should Match Regexp    ${otp_password}    \\d+    msg=Can't get OTP Password
    Log         ${otp_password}
    [Return]    ${otp_password}

Create Browser Session
    [Documentation]     Owner : sasipen
    ...    Setting browser and open url
    ...    Set url to global for create provisioning data
    [Tags]    keyword_action
    [Arguments]    ${url}     ${browser}=${BROWSER}
    Set Up Browser Fullscreen    browser=${browser}    headless=${HEAD_LESS}    ignore_ssl_certificate=${ignore_ssl_verify}
    New Page       ${url}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Authentication URL : ${url}
    Wait Until Network Is Idle    ${verify_timeout}

Create URL For Get Token
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Append Token(get from Auth Url) to get Token(API) Url
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    [Tags]    keyword_action
    [Arguments]    ${url_for_get_token}
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_for_get_token}    _code_    ${CODE}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Get Token URL: ${url_get_token}
    
Get Code From Authentication
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Get Code Token From Url Then Return to Set Test Variable ${CODE}
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    ...    - Add Set Test Provisioning Data
    [Tags]    keyword_action
    ${url_auth_access}    Wait Until Keyword Succeeds    ${verify_timeout}      10ms    Get Url    matches    .*code=
    ${code}    Split String         ${url_auth_access}    =
    ${code}    Set Variable         ${code}[1]
    Run Keyword And Ignore Error    Set Test Provisioning Data    Authenticate URL For Get Code: ${url_auth_access}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Authentication Code: ${code}
    Set Test Variable    ${CODE}    ${code}

Set Response On Webpage To Json
    [Documentation]     Owner : sasipen
    ...    Get text form webpage and change it to json message Then Return to &{RESPONSE_JSON_MESSAGE}
    [Tags]    keyword_action
    ${message}           Get Text    ${lbl_json_response_on_webpage}
    &{json_message}      Evaluate    json.loads('''${message}''')    json
    Log Many             &{json_message}
    Set Test Variable    ${RESPONSE_JSON_MESSAGE}    ${json_message}
    Take Screenshot Verify Success Scene
    Run Keyword And Ignore Error    Set Test Provisioning Data    Access Token: ${RESPONSE_JSON_MESSAGE.access_token}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Token Type: ${RESPONSE_JSON_MESSAGE.token_type}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Expires In: ${RESPONSE_JSON_MESSAGE.expires_in}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Refresh Token: ${RESPONSE_JSON_MESSAGE.refresh_token}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Refresh Token Expires In: ${RESPONSE_JSON_MESSAGE.refresh_token_expires_in}
    Run Keyword And Ignore Error    Set Test Provisioning Data    ID Token: ${RESPONSE_JSON_MESSAGE.id_token}

Get Value Response On Web Page By Key
    [Documentation]     Owner : sasipen
    ...    Get value from key in &{RESPONSE_JSON_MESSAGE} Then Return to value
    [Tags]    keyword_action
    [Arguments]    ${response_key}
    ${response_key}    Remove String        ${response_key}    $..
    ${value}           Set Variable         ${RESPONSE_JSON_MESSAGE.${response_key}}
    ${value}           Convert To String    ${value}
    [Return]           ${value}

Keyword Suite Setup
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    SSH Connect To Server Log
    ${admd_path}    Change Directory Path To Get ADMD Log
    Set Suite Variable    ${ADMD_PATH}    ${admd_path}

Keyword Suite Teardown
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Close All Connections

Keyword Test Teardown
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Get Admd Log From Server
    Run Keyword If Test Failed      Set Suite Documentation          ${TEST_NAME}:${\n}${TEST_MESSAGE}${\n}   append=True
    Run Keyword And Ignore Error    Set Test Documentation Detail

Jwt Decode Dot Dict
    [Documentation]    Owner: Nakarin
    ...    Decoded JWT Then return variable as dot.dict Type
    [Tags]    keyword_action
    [Arguments]    ${encode_variable}
    ${decoded}   JWT Decode    ${encode_variable}
    ${decoded_dot_dict}    Convert Variable Type To Dot Dict    ${decoded}
    [Return]    ${decoded_dot_dict}

Decoded Access Token
    [Documentation]    Owner: Nakarin
    ...    Decode access_token then return Test Variable ${DECODED_ACCESS_TOKEN} as dot.dict type
    [Tags]    keyword_action
    ${decoded_access_token}   Jwt Decode Dot Dict        ${RESPONSE_JSON_MESSAGE.access_token}
    Set Test Actual Result    Access Token: ${decoded_access_token}
    Set Test Variable         ${DECODED_ACCESS_TOKEN}    ${decoded_access_token}
    Log Many    &{decoded_access_token}
    Log         ${decoded_access_token}

Decoded ID Token
    [Documentation]    Owner: Nakarin
    ...    Decode id_token then return Test Variable ${DECODED_ACCESS_TOKEN} as dot.dict type
    [Tags]    keyword_action
    ${decoded_id_token}       Jwt Decode Dot Dict   ${RESPONSE_JSON_MESSAGE.id_token}
    Set Test Actual Result    ID Token: ${decoded_id_token}
    Set Test Variable         ${DECODED_ID_TOKEN}     ${decoded_id_token}
    Log Many    &{decoded_id_token}
    Log         ${decoded_id_token}

Verify Response Key
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_action
    [Arguments]    ${response_key}
    ${value}    Get Value Response On Web Page By Key    ${response_key}
    Should Match Regexp    ${value}    .*
    Log    ${value}

Get Time Nonce
    [Documentation]   Owner : sasipen
    ${current_date_time}    Get Current Date    result_format=%Y%m%d %H:%M:%S.%f      
    Set Test Variable       ${DATE_TIME}    ${current_date_time}
    
Get Value X Session ID
    ${value_x_session_id}    Get Value Response Headers By Key    $..X-Session-Id
    Set Test Variable    ${X_SESSION_ID}     ${value_x_session_id}

Get Admd Log From Server
    [Documentation]    Owner: sasipen    
    ...    Get Json Log From output of SSH Command
    ...    edit message grep > ${X_SESSION_ID}
    [Tags]    keyword_commands
    Write    cat ${ADMD_PATH} | grep ${X_SESSION_ID}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    ADMD V3.2 Log: ${json_format} 