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
    # Set Test Provisioning Data    User : ${USER}
    # Set Test Provisioning Data    Password : ${PASS}
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
