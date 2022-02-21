*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
SSH Connect To 10.137.30.22
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Connected to 10.137.30.22 to get OTP Log via SSH
    ...    *** Variables ***
    ...    ${ssh_ip_address}    10.137.30.22
    ...    ${ssh_user}          serveradm
    ...    ${ssh_pass}          R3dh@t!@#
    [Tags]    keyword_commands
    Open Connection    ${ssh_ip_address}    prompt=$    timeout=30
    Login    ${ssh_user}     ${ssh_pass}  

Get Json Log
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Get Json Log From output of SSH Command
    [Tags]    keyword_commands
    [Arguments]    ${transaction_id}
    Write    kubectl exec -it admd-v3-2-dev-686b4cc7-ddlgw -n admd sh
    Write    cd logs/detail/
    Write    cat admd-v3-2-dev-686b4cc7-ddlgw_admd.0.detail | grep -E "gsso.post_send_one_time_password.*${transaction_id}"   
    ${string}   Read    delay=1s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    ${json_expect}    Convert String to JSON    ${json_format}[0]
    Log    ${json_expect}   
    [Return]    ${json_expect}

Get OTP From Json
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...     Get OTP Value from Json that return from SSH Command
    [Tags]    keyword_commands
    [Arguments]    ${json}
    ${otp_password}    Get Value Json By Key    ${json}    custom.Input[0].Data.Body.sendOneTimePWResponse.oneTimePassword
    Should Match Regexp    ${otp_password}    \\d+
    Log    ${otp_password}
    [Return]    ${otp_password}
    
Get Email OTP Password
    [Documentation]    Owner: Nakarin
    ...    Get Email OTP Password and return Test Variable    ${EMAIL_OTP_PASSWORD}
    [Tags]    keyword_action
    [Arguments]    ${transaction_id}
    SSH Connect To 10.137.30.22
    ${json_log}        Get Json Log             ${transaction_id}
    ${otp_password}    Get OTP From Json        ${json_log}
    Set Test Variable  ${EMAIL_OTP_PASSWORD}    ${otp_password}
