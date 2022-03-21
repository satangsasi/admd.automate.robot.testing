*** Settings ***
Resource          ./Resource_init.robot
Suite Setup       Keyword Suite Setup
Test Teardown     Keyword Test Teardown
Suite Teardown    Keyword Suite Teardown


*** Test Cases ***
TST_F9_1_1_001 Verify forgot password with registered mobile number
    [Documentation]    Owner: Nakarin
    ...    \r\n***Conditions***
    ...    \r\nscope = profile
    [Tags]    Success    Sprint4    Test
    Create Browser Session    ${url_login_change_password}
    Press Forgot Password Forgot PW
    Fill Mobile Number Forgot PW
    Click    ${btn_next1_forgot_pw}
    Get OTP Password Forgot PW
    Fill OTP Password Forgot PW
    Click    ${btn_next2_forgot_pw}
    Fill Question 1 And Question 2 Forgot PW
    Click    ${btn_next3_forgot_pw}
    Fill New Password Forgot PW
    Click    ${btn_next4_forgot_pw}
    Create URL For Get Token     ${url_get_token_change_password_schema}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Verify Response Key Forgot PW
    Verify Decoded Value Access Token Forgot PW
    Verify Decoded Value ID Token Forgot PW

TST_F9_1_1_002 Verify forgot password with registered Email
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nscope = profile
    [Tags]    Success    On-Hold

TST_F9_0_1_001 Verify forgot password fail
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\nwith Email that have never been registered
    [Tags]    Fail    On-Hold

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
