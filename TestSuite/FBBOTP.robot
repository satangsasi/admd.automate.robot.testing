*** Settings ***
Resource    ./Resource_init.robot


*** Test Cases ***
TST_F2_1_1_001 Verify LoginOTP
    [Documentation]    Owner: Nakarin
    Create Browser Session    ${url_auth_fbb}