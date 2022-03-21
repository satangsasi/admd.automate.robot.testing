*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Press Forgot Password
    [Documentation]    Owner: Nakarin
    Click    ${lbl_forgot_password}
