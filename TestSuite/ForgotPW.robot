*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Keyword Test Teardown

*** Test Cases ***
TST_F9_1_1_001 Verify forgot password with registered mobile number
    [Documentation]    Owner: Nakarin
    ...    \r\n*** Conditions ***
    ...    \r\nscope = profile
    [Tags]    Success    Test
    Create Browser Session    ${url_login_change_password}
    Press Forgot Password









































































































































TST_F9_1_1_002 Verify forgot password with registered Email
    [Documentation]    Owner: sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nscope = profile
    [Tags]    Success    test1
    Create Browser Session    ${url_gmail_login}
    Fill Email In Web Page
    Press Next Button Gmail Login
    Fill Password Email In Web Page
    Press Next Button Password Gmail Login

TST_F9_0_1_001 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith Email that have never been registered
    [Tags]    Forgot_Password    Fail     sasi    
    Create Browser Session    ${url_auth_forgot_pw_email}
    Press Forgot Password link
    Fill Email Or Number For Reset Password    ${email_not_registered}
    Press Next Button
    Verify Email Invalid On Webpage

TST_F9_0_1_002 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith authcode expired
    [Tags]    Fail    On-Hold

TST_F9_0_1_003 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith authcode ซ้ำ
    [Tags]    Fail    On-Hold

TST_F9_0_1_004 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith ใช้ activate url ซ้ำ
    [Tags]    Fail    On-Hold

TST_F9_0_1_005 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith ใช้ Mail ตัวอักษรพิมพ์เล็ก พิมพ์ใหญ่
    ...    \r\nตอน register ใช้  ตัวอักษรพิมพ์เล็ก (testais0000000004@gmail.com)
    ...    \r\nตอน forgot ใช้  ตัวอักษรพิมพ์ใหญ่ (TESTAIS0000000004@gmail.com)
    ...    \r\nเมล์ส่ง link activate แต่ไม่สามารถ forgot ได้
    [Tags]    Fail    On-Hold

TST_F9_0_1_006 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith invalid client_id
    [Tags]    Fail    On-Hold

TST_F9_0_1_007 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith invalid client_secret
    [Tags]    Fail    On-Hold

TST_F9_0_1_008 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith missingclient_id
    [Tags]    Fail    On-Hold
