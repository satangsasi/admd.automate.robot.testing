*** Settings ***
Resource          ./Resource_init.robot
Suite Setup       Keyword Suite Setup
Test Teardown     Run Keyword And Ignore Error    Keyword Test Teardown
Suite Teardown    Run Keyword And Ignore Error    Keyword Suite Teardown


*** Test Cases ***
TST_F9_1_1_001 Verify forgot password with registered mobile number
    [Documentation]    Owner: Nakarin
    ...    \r\n*** Conditions ***
    ...    \r\nscope = profile
    [Tags]    Success    Forgot_Password
    Create Browser Session      ${url_login_change_password}
    Press Forgot Password
    Fill Mobile Number Forgot Password
    Click Button Submit         ${btn_submit_request_otp}
    Get OTP Password Forgot Password
    Fill OTP Password Forgot Password
    Click Button Submit         ${btn_submit_confirm_otp}
    Fill Question 1 And Question 2 Forgot Password
    Click Button Submit         ${btn_submit_done_question}
    Fill New Password Forgot Password
    Click Button Submit         ${btn_submit_done_forgot_pw}
    Create URL For Get Token    ${url_get_token_forgot_pw}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Verify Response Key Forgot Password
    Verify Decoded Value Access Token Forgot PW
    Verify Decoded Value ID Token Forgot Password

TST_F9_1_1_002 Verify forgot password with registered Email
    [Documentation]    Owner: sasipen
    ...    \r\n***Conditions***
    ...    \r\nscope = profile
    [Tags]    Success    Forgot_Password            
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Create URL For Get Token           ${url_get_token_forgot_pw}           
    New Page                           ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response On Webpage Forgot Password
    Decoded Access Token
    Verify Decoded Value Access Token Forgot Password By Email
    Decoded ID Token
    Verify Decoded Value ID Token Forgot Password By Email

TST_F9_1_1_003 Verify forgot password with Large Characters
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nwith ใช้ Mail ตัวอักษรพิมพ์เล็ก พิมพ์ใหญ่
    ...    \r\nตอน register ใช้  ตัวอักษรพิมพ์เล็ก (testais0000000004@gmail.com)
    ...    \r\nตอน forgot ใช้  ตัวอักษรพิมพ์ใหญ่ (TESTAIS0000000004@gmail.com)
    ...    \r\nเมล์ส่ง link activate เเละ forgot ได้ เพราะ Template ส่งเป็น lower case
    [Tags]    Fail    Forgot_Password    
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw_large_character}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Create URL For Get Token           ${url_get_token_forgot_pw}           
    New Page                           ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response On Webpage Forgot Password
    Decoded Access Token
    Verify Decoded Value Access Token Forgot Password By Email
    Decoded ID Token
    Verify Decoded Value ID Token Forgot Password By Email

TST_F9_0_1_001 Verify forgot password fail
    [Documentation]    Owner: sasipen
    ...    \r\n***Conditions***
    ...    \r\nwith Email that have never been registered
    [Tags]    Fail    Forgot_Password    
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_not_registered}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Email Invalid On Webpage

TST_F9_0_1_002 Verify forgot password fail
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nwith authcode expired
    [Tags]    Fail    Forgot_Password          
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Create URL For Get Token           ${url_get_token_forgot_pw}
    Wait For Authentication Code Expire
    New Page                           ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response Forgot Password Authcode Expired

TST_F9_0_1_003 Verify forgot password fail
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nwith authcode ซ้ำ
    [Tags]    Fail    Forgot_Password
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Create URL For Get Token           ${url_get_token_forgot_pw}           
    New Page    ${URL_GET_TOKEN}
    New Page    ${URL_GET_TOKEN}
    Take Screenshot Verify Success Scene
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response Forgot Password With Duplicate Authen Code

TST_F9_0_1_004 Verify forgot password fail
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nwith ใช้ activate url ซ้ำ
    ...    \r\n***On-Hold***
    ...    \r\nต้อง get log error invalid_code from server  แต่ตอนนี้ยังหา log ไม่เจอ
    [Tags]    Fail    Forgot_Password    On-Hold
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Open Link And Confirm New Password Again
    Verify Error After Confirm New Password 2 Times 

TST_F9_0_1_005 Verify forgot password fail
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nwith invalid client_id
    [Tags]    Fail    Forgot_Password    
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Create URL For Get Token           ${invalid_client_id_url_get_token_forgot_pw}          
    New Page                           ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response Forgot Password Invalid Client Id

TST_F9_0_1_006 Verify forgot password fail
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nwith invalid client_secret
    [Tags]    Fail    Forgot_Password 
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Create URL For Get Token           ${invalid_client_secret_url_get_token_forgot_pw}          
    New Page                           ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response Forgot Password Invalid Client Secret


TST_F9_0_1_007 Verify forgot password fail
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nwith missingclient_id
    [Tags]    Fail    Forgot_Password    
    Create Browser Session             ${url_login_change_password}
    Press Forgot Password
    Fill Email For Reset Password      ${email_for_forgot_pw}
    Click Button Submit                ${btn_submit_request_otp}
    Verify Send Link Confirm New Password Succeeds
    Get Link Confirm New Password Form Server
    Create Browser Session             ${URL_CONFIRM_NEW_PASSWORD}
    Fill New Password
    Click Button Submit                ${btn_submit_new_password}
    Create URL For Get Token           ${invalid_missing_client_id_url_get_token_forgot_pw}         
    New Page                           ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response Forgot Password Missing Client Id

Test Log admd dev
    Get Admd Log From Server By X Session Id