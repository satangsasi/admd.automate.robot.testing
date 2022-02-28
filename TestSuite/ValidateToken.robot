*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Append To Document Teardown


*** Test Cases ***
TST_F6_1_1_001 verify validate success B2C
    [Documentation]    Owner: Nakarin
    ...    login by FBB OTP
    [Tags]    Success
    
TST_F6_1_1_002 verify validate success CURL
    [Documentation]    Owner: Nakarin
    ...    login by auto FBB
    [Tags]    Success

TST_F6_1_1_003 verify validate success login by client credentials
    [Documentation]    Owner: Nakarin
    [Tags]    Success
    Get Access Token ClientCredential
    Set API Header Login By Client Credential
    Set API Body Login By Client Credential
    Send Post Request Validate Token

TST_F6_1_1_004 verify validate success with profile have gupimpi more than one object 
    [Documentation]    Owner: Nakarin
    ...    - config gupcommon is multi-sequence
    ...    ** ใช้โปรไฟล์ที่ Dup มาจาก Prod by SI and TS**"
    [Tags]    Success    On-Hold

TST_F6_0_1_001 erify validate fail with no access token received from loging by msisdn which is no profile
    [Documentation]    Owner: Sasipen
    [Tags]    Fail
    Set API Header Request Otp Validate Token
    Set API Body Request Otp Validate Token
    Send Post Request Otp Validate Token

TST_F6_0_1_002 verify validate fail with incorrect client id
    [Documentation]    Owner:
    [Tags]    Fail

TST_F6_0_1_003 verify validate fail with incorrect access token
    [Documentation]    Owner:
    [Tags]    Fail

TST_F6_0_1_004 verify validate fail with expired access token
    [Documentation]    Owner:
    [Tags]    Fail

TST_F6_0_1_005 verify validate fail with missing client id
    [Documentation]    Owner:
    [Tags]    Fail

TST_F6_0_1_006 verify validate fail with missing access token
    [Documentation]    Owner:
    [Tags]    Fail
