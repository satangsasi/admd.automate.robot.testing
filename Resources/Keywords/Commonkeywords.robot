*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Variables ***
${HEAD_LESS}    False
${BROWSER}      chromium


*** Keywords ***
#keyword Setup
Keyword Suite Setup
    [Documentation]    Owner: Nakarin
    ...    ยังไม่ใช้  Change Directory Path To Get ADMD DEV Log เนื่องจาก path มีการเปลี่ยนแปลง และในบางข้อใช้ path ไม่เหมือนกัน
    [Tags]    keyword_communicate
    SSH Connect To Server Log
    ${admd_path}    Change Directory Path To Get ADMD DEV Log
    Set Suite Variable    ${ADMD_PATH}    ${admd_path}
    ${admd_srfp_path}    Change Directory Path To Get ADMD SRFP Log
    Set Suite Variable    ${ADMD_SRFP_PATH}    ${admd_srfp_path}

Keyword Suite Teardown
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Close All Connections

Keyword Test Teardown
    [Documentation]    Owner: Nakarin  Editor: Sasipen
    ...    Edit: add keyword Get Admd Log From Server By X Session Id for set actual result ADMD V3.2 Log
    [Tags]    keyword_communicate
    Run Keyword If Test Passed      Get Admd Log From Server By X Session Id 
    Run Keyword If Test Failed      Set Suite Documentation          ${TEST_NAME}:${\n}${TEST_MESSAGE}${\n}   append=True
    Run Keyword And Ignore Error    Set Test Documentation Detail

# Append To Document Teardown
#     [Documentation]    Owner: Nakarin
#     ...    Create Document of Provisioning Data(in order list) and Actual Result
#     ...     ปิดไว้ก่อนเหมือนจะไม่ได้ใช้:sasipen
#     [Tags]    keyword_communicate
#     # Set Test Provisioning Data    Request ${TYPE_REQUEST} : ${API_URL}
#     # Set Test Provisioning Data    Header : ${API_HEADER}
#     # Set Test Provisioning Data    Body : ${API_BODY}
#     Run Keyword And Ignore Error    Set Test Provisioning Data    User : ${USER}
#     Run Keyword And Ignore Error    Set Test Provisioning Data    Password : ${PASS}
#     # Set Test Provisioning Data    Authentication URL : ${URL_AUTH}
#     # Set Test Provisioning Data    Get Token URL : ${URL_GET_TOKEN}
#     Run Keyword And Ignore Error    Set Test Provisioning Data    Get Refresh Token URL : ${URL_GET_REFRESH_TOKEN}
#     Set Test Documentation Detail
    
#ssh connect
SSH Connect To Server Log
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Connected to 10.137.30.22
    ...    *** Variables ADMD ***
    ...    ${ssh_admd_ip_address}    10.137.30.22
    ...    ${ssh_admd_user}          serveradm
    ...    ${ssh_admd_pass}          R3dh@t!@#
    ...    *** Variables AAF5G ***
    ...    ${ssh_aaf5g_ip_address}   10.138.37.128
    ...    ${ssh_aaf5g_user}         toro
    ...    ${ssh_aaf5g_pass}         equinox@toro;
    [Tags]    keyword_action
    ${admd_dev_connection}       Open Connection    ${ssh_admd_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login    ${ssh_admd_user}         ${ssh_admd_pass}
    Log    ${login_log}    # ADMD DEV Connection
    Set Suite Variable    ${SSH_ADMD_DEV}     ${admd_dev_connection}
    ${admd_srfpconnection}       Open Connection    ${ssh_admd_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login    ${ssh_admd_user}         ${ssh_admd_pass}
    Log    ${login_log}    # ADMD SRFP Connection
    Set Suite Variable    ${SSH_ADMD_SRFP}     ${admd_srfpconnection}
    IF    ${REGRESSION} != True
        ${aaf5g_connection}      Open Connection    ${ssh_aaf5g_ip_address}    prompt=$    timeout=${default_timeout}
        ${login_log}    Login    ${ssh_aaf5g_user}        ${ssh_aaf5g_pass}
        Write    cd /eqx/af/detail/
        Log    ${login_log}    # AAF5G Connection    
        Set Suite Variable    ${SSH_AAF5G}    ${aaf5g_connection}
    END   
    
Change Directory Path To Get ADMD DEV Log
    [Documentation]    Owner: Nakarin
    ...    Change to get log directory although old path was change - (deployed)
    ...    [Return] the admd path to get log with grep
    ...    Edit :sasipen 
    ...    Add Set Suite Variable    ${ADMD_PATH}    ${admd_path} For use in another keyword
    [Tags]    keyword_action
    Switch Connection    ${SSH_ADMD_DEV}
    ${kubectl_path}    Wait Until Keyword Succeeds    5x    2s    ADMD Get Kubectl Path
    Write    reset
    Read     delay=5s    # Wait for screen reset
    ${admd_path}    Wait Until Keyword Succeeds    5x    2s    ADMD Get Kubectl Grep Path    ${kubectl_path}
    [Return]    ${admd_path}

ADMD Get Kubectl Path
    [Documentation]    Owner: Nakarin
    ...    Read output of ssh command then return the last Kubectl path
    [Tags]    keyword_command
    Write    kubectl get pod -n admd
    ${output}          Read    delay=1s
    Log    ${output}
    @{output_line}     Split To Lines        ${output}
    FOR    ${line}    IN    @{output_line}    
        @{admd_path}       Get Regexp Matches    ${line}       (\\w\\S+)
        ${status}    Run Keyword And Return Status    Should Contain    ${admd_path}[0]    admd-v3-2-dev
        IF    ${status} == True
            ${admd_dev_path}    Set Variable    ${admd_path}[0]  
            Exit For Loop
        END
    END    
    [Return]    ${admd_dev_path}

ADMD Get Kubectl Grep Path
    [Documentation]    Owner: Nakarin
    ...    Receive ${kubectl_path} then change directory to ${kubectl_path} 
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
    Log Many    @{cat_path}
    Should Contain    ${cat_path}[-1]    admd.0.detail    msg=Can't get "${kubectl_path}[0].admd.0.detail" with 'kubectl exec -it ${kubectl_path}[0] -n admd sh' command    values=False
    [Return]    ${cat_path}[-1]

Change Directory Path To Get ADMD SRFP Log
    Switch Connection    ${SSH_ADMD_SRFP}
    ${admd_srfp_path}    Wait Until Keyword Succeeds    5x    2s    Get Kubectl Path ADMD Srfp
    Write    reset
    Read     delay=2s  
    ${admd_srfp_path_log}    Wait Until Keyword Succeeds    5x    2s    Get Admd Srfp Path    ${admd_srfp_path}
    [Return]    ${admd_srfp_path_log}

Get Kubectl Path ADMD Srfp
    [Documentation]    Owner: sasipen
    Write    kubectl get pod -n admd
    ${output}    Read    delay=1s
    Log    ${output}
    @{output_line}    Split To Lines        ${output}
    FOR    ${line}    IN    @{output_line}    
        @{admd_path}       Get Regexp Matches    ${line}       (\\w\\S+)
        ${status}    Run Keyword And Return Status    Should Contain    ${admd_path}[0]    admd-srfp
        IF    ${status} == True
            ${admd_srfp_path}    Set Variable    ${admd_path}[0]  
        ELSE
              Exit For Loop If    ${status} == True
        END
    END    
    [Return]    ${admd_srfp_path}

Get Admd Srfp Path
    [Documentation]    Owner: sasipen
    ...    ${admd_path_get_email}=admd-srfp-69c8f85ddc-swhl8  fixed path in folder variable    
    # ${admd_srfp_path_get_email}    Find Admd Srfp Path
    # Write     kubectl exec -it ${admd_srfp_path_get_email} -n admd sh 
    [Arguments]    ${kubectl_path}
    Write     kubectl exec -it ${kubectl_path} -n admd sh 
    ${output}    Read    delay=2s
    Log    ${output}
    Write    cd logs/appLog/
    Write    ls -lrt | tail
    ${output}    Read    delay=2s
    Log    ${output}
    @{output_line}    Split To Lines        ${output}
    @{cat_path}       Get Regexp Matches    ${output_line}[-2]    (\\w\\S+)
    Write    reset
    Log Many    @{cat_path}
    Should Contain    ${cat_path}[-1]    SRFP.0.log    msg=Can't get "${admd_path_get_email}_SRFP.0.log"  values=False
    ${srfp_path}    Set Variable    ${cat_path}[-1]
    [Return]    ${srfp_path}

Get Admd Log From Server
    [Documentation]    Owner: sasipen    
    ...    Get Json Log From output of SSH Command
    ...    For get message > ${X_SESSION_ID}
    [Tags]    keyword_commands
    Switch Connection    ${SSH_ADMD_DEV}
    Write    reset
    Read     delay=2s  
    Write    cat ${ADMD_PATH}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log Many   @{json_format}
    &{json_expect}    Convert Variable Type To Dot Dict    ${json_format}[-1]
    Log Many    &{json_expect}
    Set Test Variable    &{JSON_EXPECT}    &{json_expect}

Get Value X Session Id
    [Documentation]    Owner: sasipen  
    ${value_x_session_id}    Get Value Json By Key    ${JSON_EXPECT}    $..custom.Output[0].Data.Header['x-session-id']
    Set Test Variable    ${X_SESSION_ID}    ${value_x_session_id}    

Get Admd Log From Server By X Session Id
    Get Admd Log From Server
    Get Value X Session Id
    Write    cat ${ADMD_PATH} | grep ${X_SESSION_ID}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    ADMD V3.2 Log: ${json_format} 

Get AAF5G Log
    [Documentation]    Owner: Nakarin
    ...    Get AAF5G logs from server
    [Tags]    keyword_action
    ${status}    Run Keyword And Return Status    List Should Contain Value    ${TEST_TAGS}    AAF5G
    IF    ${status} == True and ${REGRESSION} != True
        Switch Connection    ${SSH_AAF5G}
        @{aaf5g_path}    Get AAF5G Path
        ${session}    ${log_path}    Get AAF5G Session    ${aaf5g_path}
        Get AAF5G Log Command    ${session}    ${log_path}
    END

Get AAF5G Path
    [Documentation]    Owner: Nakarin
    ...    Used for get AAF5G log path to get AAF5G logs
    [Tags]    keyword_commands
    @{path_list}    Create List
    Write       ls -lrt | tail
    ${path}     Read    delay=5s
    @{path}     Split To Lines    ${path}
    ${index}    Set Variable    -2
    FOR    ${counter}    IN RANGE    2
        @{aaf5g_path}     Get Regexp Matches    ${path}[${index}]    (\\w\\S+)
        ${index}    Evaluate    ${index} - 1
        Append To List    ${path_list}    ${aaf5g_path}[-1]
    END
    [Return]    ${path_list}

Get AAF5G Session
    [Documentation]    Owner: Nakarin
    ...    Used for get AFF5g Session for get AFF5G logs
    [Tags]    keyword_commands
    [Arguments]    ${log_path}
    IF    len('${USERNAME}') == 10
        ${user}    Replace String    ${USERNAME}    0    66    count=1
    ELSE
        ${user}    Set Variable      ${USERNAME}
    END
    FOR    ${element}    IN    @{log_path}
        Write    cat ${element} | grep ${user}
        ${string}    Read    delay=5s
        Write    reset
        ${json_format}    Get Regexp Matches    ${string}    {.*
        Log Many    @{json_format}
        @{string}    Run Keyword And Ignore Error     Split String      ${json_format}[0]    "
        Log Many    @{string}[1]
        ${status}    Run Keyword And Return Status    Should Contain    ${string}[1][5]    https.0
        Continue For Loop If    ${status} == False
        ${aaf5g_log_path}    Set Variable    ${element}
    END
    [Return]    ${string}[1][5]    ${aaf5g_log_path}

Get AAF5G Log Command
    [Documentation]    Owner: Nakarin
    ...    Command for used in get log via ssh command
    [Tags]    keyword_commands
    [Arguments]    ${session}         ${log_path}
    Write        cat ${log_path} | grep ${session}
    ${string}    Read    delay=5s
    ${string}    Get Regexp Matches    ${string}    {.*
    Log    ${string}
    Set Test Actual Result    AAF5G logs: ${string}

#Get Value
Get Time Nonce
    [Documentation]   Owner : sasipen
    ${current_date_time}    Get Current Date    result_format=%Y%m%d %H:%M:%S.%f
    Set Test Variable       ${DATE_TIME}    ${current_date_time}

Get OTP Password From Json
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...     Get OTP Value from Json that return from SSH Command
    [Tags]    keyword_action
    [Arguments]    ${json_log}
    ${otp_password}        Get Value Json By Key    ${json_log}    $..custom.Input[0].Data.Body.sendOneTimePWResponse.oneTimePassword
    Should Match Regexp    ${otp_password}    \\d+    msg=Can't get OTP Password
    Log         ${otp_password}
    [Return]    ${otp_password}

Get Code From Authentication
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Get Code Token From Url Then Return to Set Test Variable ${CODE}
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    ...    - Add Set Test Provisioning Data
    [Tags]    keyword_action
    Wait Until Keyword Succeeds    ${verify_timeout}      10ms    Verify Locator Is Visible    ${llb_login_web_ais}
    ${url_auth_access}    Wait Until Keyword Succeeds    ${verify_timeout}      10ms    Get Url    matches    .*code=
    ${code}    Split String         ${url_auth_access}    =
    ${code}    Set Variable         ${code}[1]
    Run Keyword And Ignore Error    Set Test Provisioning Data    Authenticate URL For Get Code: ${url_auth_access}
    Run Keyword And Ignore Error    Set Test Provisioning Data    Authentication Code: ${code}
    Set Test Variable    ${CODE}    ${code}

Get Value Response On Web Page By Key
    [Documentation]     Owner : sasipen
    ...    Get value from key in &{RESPONSE_JSON_MESSAGE} Then Return to value
    [Tags]    keyword_action
    [Arguments]    ${response_key}
    ${response_key}    Remove String        ${response_key}    $..
    ${value}           Set Variable         ${RESPONSE_JSON_MESSAGE.${response_key}}
    ${value}           Convert To String    ${value}
    [Return]           ${value}

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
    
Set Response On Webpage To Json
    [Documentation]     Owner : sasipen
    ...    Get text form webpage and change it to json message Then Return to &{RESPONSE_JSON_MESSAGE}
    [Tags]    keyword_action
    [Arguments]    ${set_test}=Provisioning Data
    ${message}           Get Text    ${lbl_json_response_on_webpage}
    &{json_message}      Evaluate    json.loads('''${message}''')    json
    Log Many             &{json_message}
    Set Test Variable    ${RESPONSE_JSON_MESSAGE}    ${json_message}
    Take Screenshot Verify Success Scene
    IF     '${set_test}' == 'Actual Result'
        Set Test Actual Result      ${RESPONSE_JSON_MESSAGE}
    ELSE    
        Run Keyword And Ignore Error    Set Test Provisioning Data    Access Token: ${RESPONSE_JSON_MESSAGE.access_token}
        Run Keyword And Ignore Error    Set Test Provisioning Data    Token Type: ${RESPONSE_JSON_MESSAGE.token_type}
        Run Keyword And Ignore Error    Set Test Provisioning Data    Expires In: ${RESPONSE_JSON_MESSAGE.expires_in}
        Run Keyword And Ignore Error    Set Test Provisioning Data    Refresh Token: ${RESPONSE_JSON_MESSAGE.refresh_token}
        Run Keyword And Ignore Error    Set Test Provisioning Data    Refresh Token Expires In: ${RESPONSE_JSON_MESSAGE.refresh_token_expires_in}
        Run Keyword And Ignore Error    Set Test Provisioning Data    ID Token: ${RESPONSE_JSON_MESSAGE.id_token}
    END

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
    Set Test Actual Result    Decoded Access Token: ${decoded_access_token}
    Set Test Variable         ${DECODED_ACCESS_TOKEN}    ${decoded_access_token}
    Log Many    &{decoded_access_token}
    Log         ${decoded_access_token}

Decoded ID Token
    [Documentation]    Owner: Nakarin
    ...    Decode id_token then return Test Variable ${DECODED_ACCESS_TOKEN} as dot.dict type
    [Tags]    keyword_action
    ${decoded_id_token}       Jwt Decode Dot Dict   ${RESPONSE_JSON_MESSAGE.id_token}
    Set Test Actual Result    Decoded ID Token: ${decoded_id_token}
    Set Test Variable         ${DECODED_ID_TOKEN}     ${decoded_id_token}
    Log Many    &{decoded_id_token}
    Log         ${decoded_id_token}

Check Time Minutes
    [Documentation]    Owner: Nakarin
    ...    Used for recheck timestamps
    [Tags]    keyword_commands
    ${current_minutes}    Get Current Date      result_format=%M
    ${current_minutes}    Convert To Integer    ${current_minutes}
    [Return]    ${current_minutes}

Wait For Authentication Code Expire
    [Documentation]    Owner: Nakarin
    ...    Wait for Token(from Auth Url) Expire about in 5 min
    [Tags]    keyword_communicate
    Robot Wait Time    5m

Type Text In Text Box
    [Documentation]     Owner : Sasipen
    ...                 Group keyword action type text by set delay 0.1 seconds
    ...                 Simulate actual user action
    [Arguments]     ${locator}      ${text}     ${delay}=0.1s       ${clear}=True
    Click On Element                ${locator}
    Type Text       selector=${locator}         txt=${text}         delay=${delay}      clear=${clear}

#verify
Verify Response Key
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_action
    [Arguments]    ${response_key}
    ${value}    Get Value Response On Web Page By Key    ${response_key}
    Should Match Regexp    ${value}    .*
    Log    ${value}

Verify Contain Any Value Decode Jwt
    [Documentation]    Owner: sasipen
    [Arguments]    ${jsondata}    ${response_key}
    ${response_key}    Remove String        ${response_key}    $..
    ${value}           Get Value Json By Key    ${jsondata}    ${response_key}
    Should Match Regexp    ${value}    .*
    Log    ${value}
