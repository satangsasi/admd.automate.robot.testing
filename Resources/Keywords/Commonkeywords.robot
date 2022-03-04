*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Append To Document Teardown
    [Documentation]    Owner: Nakarin
    ...    Create Document of Provisioning Data(in order list) and Actual Result
    [Tags]    keyword_communicate
    # Set Test Provisioning Data    Request ${TYPE_REQUEST} : ${API_URL}
    # Set Test Provisioning Data    Header : ${API_HEADER}
    # Set Test Provisioning Data    Body : ${API_BODY}
    Set Test Provisioning Data    User : ${USER}
    Set Test Provisioning Data    Password : ${PASS}
    Set Test Provisioning Data    Authentication URL : ${URL_AUTH}
    Set Test Provisioning Data    Get Token URL : ${URL_GET_TOKEN}
    Set Test Provisioning Data    Get Refresh Token URL : ${URL_GET_REFRESH_TOKEN}
    Set Test Documentation Detail
    
SSH Connect To 10.137.30.22
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Connected to 10.137.30.22
    ...    *** Variables ***
    ...    ${ssh_ip_address}    10.137.30.22
    ...    ${ssh_user}          serveradm
    ...    ${ssh_pass}          R3dh@t!@#
    [Tags]    keyword_commands
    Open Connection    ${ssh_ip_address}    prompt=$    timeout=30
    Login    ${ssh_user}     ${ssh_pass} 

Change Directory Path To Get Log
    [Documentation]    Owner: Nakarin
    ...    Change to get log directory although path old was change
    ...    [Return] the admd path to get log with grep
    [Tags]    keyword_command
    Write    kubectl get pod -n admd
    ${output}          Read    delay=1s
    @{output}          Split To Lines        ${output}
    @{kubectl_path}    Get Regexp Matches    ${output}[-2]    (\\w\\S+)
    Write    reset
    Write    kubectl exec -it ${kubectl_path}[0] -n admd sh
    Write    cd logs/detail/
    Write    ls -lrt | tail
    ${output}      Read    delay=2s
    @{output}      Split To Lines        ${output}
    @{cat_path}    Get Regexp Matches    ${output}[-2]    (\\w\\S+)
    Write    reset
    Read    delay=1s
    [Return]    ${cat_path}[-1]

Get Json Log Email Otp
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Get Json Log From output of SSH Command
    [Tags]    keyword_commands
    [Arguments]    ${transaction_id}
    ${admd_path}    Change Directory Path To Get Log
    Write    cat ${admd_path} | grep -E "gsso.post_send_one_time_password.*${transaction_id}"   
    ${string}   Read    delay=1s
    ${json_format}    Get Regexp Matches        ${string}    {.*
    ${json_expect}    Convert String To JSON    ${json_format}[0]
    Log         ${json_expect}
    [Return]    ${json_expect}

Get OTP From Json
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...     Get OTP Value from Json that return from SSH Command
    [Tags]    keyword_commands
    [Arguments]    ${json}
    ${otp_password}        Get Value Json By Key    ${json}    custom.Input[0].Data.Body.sendOneTimePWResponse.oneTimePassword
    Should Match Regexp    ${otp_password}    \\d+
    Log         ${otp_password}
    [Return]    ${otp_password}
    
Get Email OTP Password
    [Documentation]    Owner: Nakarin
    ...    Get Email OTP Password and return Test Variable    ${EMAIL_OTP_PASSWORD}
    [Tags]    keyword_action
    [Arguments]    ${transaction_id}
    SSH Connect To 10.137.30.22
    ${json_log}        Get Json Log Email Otp   ${transaction_id}
    ${otp_password}    Get OTP From Json        ${json_log}
    Set Test Variable  ${EMAIL_OTP_PASSWORD}    ${otp_password}