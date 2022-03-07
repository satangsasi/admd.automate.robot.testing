*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Append To Document Teardown
    [Documentation]    Owner: Nakarin
    ...    Create Document of Provisioning Data(in order list) and Actual Result
    [Tags]    keyword_communicate
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
    ...    Change to get log directory although old path was change - (deployed)
    ...    [Return] the admd path to get log with grep
    [Tags]    keyword_command
    Write    kubectl get pod -n admd
    ${output}          Read    delay=1s
    @{output}          Split To Lines        ${output}
    @{kubectl_path}    Get Regexp Matches    ${output}[-2]    (\\w\\S+)
    Write    reset
    Read     delay=1s
    Write    kubectl exec -it ${kubectl_path}[0] -n admd sh
    Write    cd logs/detail/
    Write    ls -lrt | tail
    ${output}      Read    delay=2s
    @{output}      Split To Lines        ${output}
    @{cat_path}    Get Regexp Matches    ${output}[-2]    (\\w\\S+)
    Write    reset
    Read    delay=1s
    [Return]    ${cat_path}[-1]

Get OTP Password From Json
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...     Get OTP Value from Json that return from SSH Command
    [Tags]    keyword_commands
    [Arguments]    ${json_log}
    ${otp_password}        Get Value Json By Key    ${json_log}    custom.Input[0].Data.Body.sendOneTimePWResponse.oneTimePassword
    Should Match Regexp    ${otp_password}    \\d+
    Log         ${otp_password}
    [Return]    ${otp_password}

Create Browser Session
    [Documentation]     Owner : sasipen
    ...    Setting browser and open url 
    ...    Set url to global for create provisioning data
    [Arguments]    ${url}
    Set Up Browser Fullscreen  
    New Page       ${url}
    Set Test Provisioning Data    Authentication URL : ${url}
    Wait Until Network Is Idle