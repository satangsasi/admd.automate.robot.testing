*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Append To Document Teardown
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Run Keyword If Test Failed    Take Screenshot Failure Specific Name
    Set Test Provisioning Data    Request ${REQUEST_TYPE} : ${API_URL}
    Set Test Provisioning Data    Header : ${API_HEADER}
    Set Test Provisioning Data    Body : ${API_BODY}
    Set Test Provisioning Data    User : ${USER}
    Set Test Provisioning Data    Password : ${PASS}
    Set Test Provisioning Data    Authentication URL : ${URL_AUTH}
    Set Test Provisioning Data    Get Token URL : ${URL_GET_TOKEN}
    Set Test Provisioning Data    Get Refresh Token URL : ${URL_GET_REFRESH_TOKEN}
    Set Test Documentation Detail
    