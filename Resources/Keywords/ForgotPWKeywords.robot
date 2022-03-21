*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Press Forgot Password
    [Documentation]    Owner: Nakarin
    Click    ${lbl_forgot_password}



































































































































































































































































































Press Forgot Password link
    [Documentation]    Owner: sasipen
    Click    ${llb_forgot_password}

Fill Email Or Number For Reset Password
    [Documentation]    Owner: sasipen
    [Arguments]    ${email_number}
    Type Text      ${txt_email_number_reset_password}    ${email_number}     delay=0.1s
    Set Test Provisioning Data   Email: ${email_number}
Press Next Button
    [Documentation]    Owner: sasipen
    Click    ${btn_next_reset_password}
    
Verify Email Invalid On Webpage
    [Documentation]    Owner: sasipen
    ...    Verify Text show on webpage : Email is wrong
    ...    Verify Text show on webpage : Please check your Email.
    [Tags]    keyword_communicate
    ${actual_error_email_wrong}    Get Text    ${lbl_error_email_wrong}
    ${actual_error_check_email}    Get Text    ${lbl_error_check_email}
    Verify Value Should Be Equal    ${actual_error_email_wrong}    ${error_email_wrong}
    Verify Value Should Be Equal    ${actual_error_check_email}    ${error_check_email}
    Verify Locator Is Visible       ${btn_close_error_box} 
    Take Screenshot Verify Success Scene
    Set Test Actual Result     ${actual_error_email_wrong}
    Set Test Actual Result     ${actual_error_check_email}

Fill Email In Web Page
    Type Text    ${txt_email_number_gmail}    ${email_login_gmail}     delay=0.1s

Press Next Button Gmail Login
    Click    ${btn_next_gmail}
    
Fill Password Email In Web Page
    Verify Locator Is Visible    ${btn_try_again} 
    Type Text    ${txt_password_gmail}    ${password_login_gmail}}     delay=0.1s
Press Next Button Password Gmail Login
    Click    ${btn_password_next_gmail}