*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
SSH Connect To 10.137.30.22
    [Documentation]    Owner: Nakarin
    ...    Connected to 10.137.30.22 to get OTP Log via SSH
    [Tags]    keyword_command
    Open Connection    ${ssh_ip_address}    prompt=$    timeout=30
    Login    ${ssh_user}     ${ssh_pass}
    ${json}    Get Json Log    WFxqpBzOkjphfYv3kQ
    Log    ${json.Data.oneTimePassword}

Get Json Log
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_command
    [Arguments]    ${transaction_id}
    ${log1}    Write    kubectl exec -it admd-v3-2-dev-686b4cc7-ddlgw -n admd sh
    Log    ${log1}
    ${log2}    Write    cd logs/detail/
    Log    ${log2}
    ${log3}    Write    cat admd-v3-2-dev-686b4cc7-ddlgw_admd.0.detail | grep -E "gsso.post_send_one_time_password.*${transaction_id}"
    Log    ${log3}
    ${string}    Read    delay=1s
    Log    ${string}
    # ${json}    Convert String to JSON    ${string}
    [Return]    ${json}
