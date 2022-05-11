*** Settings ***
Library     Browser
Resource    ./Resource_init.robot
Resource    ../Resources/Keywords/ClientCredentialKeywords.robot
Suite Setup       Keyword Suite Setup
Test Teardown     Run Keyword And Ignore Error    Keyword Test Teardown
Suite Teardown    Run Keyword And Ignore Error    Keyword Suite Teardown


*** Variables ***
${fbb_username}          8854321012


*** Keywords ***
Fill Username FBB OTP
    [Documentation]    Owner: Nakarin
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text   ${txt_fbb_user}    ${fbb_username}    
    Set Test Provisioning Data   Username: ${fbb_username}

Get Srfp App log
    Switch Connection    ${SSH_ADMD_SRFP}
    Write    reset
    Read     delay=5s
    Write    cat ${ADMD_SRFP_PATH} | grep ${X_SESSION_ID_SEND_EMAIL}   
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    SRFP AppLog: ${json_format} 


SSH Connect To Server Get Log Logout Pushnotify
    ${admd_srfc_connection}       Open Connection    ${ssh_admd_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login    ${ssh_admd_user}         ${ssh_admd_pass}
    Log    ${login_log} 
    Set Suite Variable    ${SSH_ADMD_SRFC}     ${admd_srfc_connection}
    ${admd_src_connection}       Open Connection    ${ssh_admd_ip_address}     prompt=$    timeout=${default_timeout}
    ${login_log}    Login    ${ssh_admd_user}         ${ssh_admd_pass}
    Log    ${login_log} 
    Set Suite Variable    ${SSH_ADMD_SCF}     ${admd-scf_connection}   # ADMD DEV Connection

Get Kubectl Path ADMD
    [Documentation]    Owner: sasipen
    [Arguments]    ${path_get_log}        
    Write    kubectl get pod -n admd
    ${output}    Read    delay=1s
    Log    ${output}
    @{output_line}    Split To Lines        ${output}
    FOR    ${line}    IN    @{output_line}    
        @{admd_path}       Get Regexp Matches    ${line}       (\\w\\S+)
        ${status}    Run Keyword And Return Status    Should Contain    ${admd_path}[0]    ${path_get_log}
        IF    ${status} == True
            ${admd_srfp_path}    Set Variable    ${admd_path}[0]  
            Exit For Loop
        END
    END    
    [Return]    ${admd_path}

Get Admd Path
    [Documentation]    Owner: 
    ...
    ...    
    [Tags]    keyword_command
    [Arguments]    ${kubectl_path}    ${path_tail}    
    Write    kubectl exec -it ${kubectl_path} -n admd sh
    Write    cd logs/detail/
    Write    ls -lrt | tail
    ${output}      Read    delay=2s
    Log    ${output}
    @{output_line}    Split To Lines        ${output}
    @{cat_path}       Get Regexp Matches    ${output_line}[-2]    (\\w\\S+)
    Write    reset
    Log Many    @{cat_path}
    Should Contain    ${cat_path}[-1]    ${path_tail}    msg=Can't get "${kubectl_path}[0]${path_tail}" with 'kubectl exec -it ${kubectl_path}[0] -n admd sh' command    values=False
    [Return]    ${cat_path}[-1]

Get ADMD SRFC Log Detail
    Switch Connection    ${SSH_ADMD_SRFC}
    ${admd_srfc_path}    Wait Until Keyword Succeeds    5x    2s    Get Kubectl Path ADMD    admd_srfc     
    Write    reset
    Read     delay=2s  
    ${admd_srfp_path_log}    Wait Until Keyword Succeeds    5x    2s    Get Admd Path    ${admd_srfc_path}    _SRFC.0.detail    
    Write    reset
    Read     delay=5s
    Write    cat ${admd_srfp_path_log} | grep ${X_SESSION_ID_SEND_EMAIL}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    SRFC Log Detail: ${json_format} 

Get ADMD SCF Log Detail
    Switch Connection    ${SSH_ADMD_SCF}
    ${admd_scf_path}    Wait Until Keyword Succeeds    5x    2s    Get Kubectl Path ADMD    admd-scf-776c894cb9
    Write    reset
    Read     delay=2s  
    ${admd_scf_path_log}    Wait Until Keyword Succeeds    5x    2s    Get Admd Path    ${admd_scf_path}    _SCF.0.detail    
    Write    reset
    Read     delay=5s
    Write    cat ${admd_scf_path_log} | grep ${X_SESSION_ID_SEND_EMAIL}
    ${string}   Read    delay=5s
    ${json_format}    Get Regexp Matches    ${string}    {.*
    Log    ${json_format} 
    Set Test Actual Result    SCF Log Detail: ${json_format} 

Keyword Test Teardown For Logout Pushnotify
    Close Browser    ALL
    Run Keyword If Test Passed      Get Admd Log From Server By X Session Id
    Run Keyword If Test Passed      SSH Connect To Server Get Log Logout Pushnotify
    Run Keyword If Test Passed      Get ADMD SRFC Log Detail
    Run Keyword If Test Passed      Get ADMD SCF Log Detail
    
*** Test Cases ***
Test_1_1_001
    Fill Username FBB OTP




Test SRFP - Applog

