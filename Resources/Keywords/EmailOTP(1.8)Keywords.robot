*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
SSH Connect To 10.137.30.22
    [Documentation]    Owner: Nakarin
    ...    Connected to 10.137.30.22 to get OTP Log via SSH
    [Tags]    keyword_command
    Open Connection    ${ssh_ip_address}    prompt=$    timeout=30
    Login    ${ssh_user}     ${ssh_pass}
    ${json}    Get Json Log    huuZxUrIINiGcAOGmo
    ${password}    Get Value Json By Key    ${json}    custom.Input[0].Data.Body.sendOneTimePWResponse.oneTimePassword
    Log    ${password} 


Get Json Log
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_command
    [Arguments]    ${transaction_id}
    Write    kubectl exec -it admd-v3-2-dev-686b4cc7-ddlgw -n admd sh
    Write    cd logs/detail/
    Write    cat admd-v3-2-dev-686b4cc7-ddlgw_admd.0.detail | grep -E "gsso.post_send_one_time_password.*${transaction_id}"
    ${string}    Read    delay=1s
    Log         ${string}
    ${json_format}    Get Regexp Matches    ${string}    {.*   
    Log     ${json_format}  
    ${json_expect}    Convert String to JSON    ${json_format}[0]
    Log    ${json_expect}   
    [Return]    ${json_expect}