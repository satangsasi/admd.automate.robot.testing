*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Set Test Documentation Detail


*** Test Cases ***
TST_F2_1_1_001 Verify LoginOTP
    [Documentation]    Owner: Nakarin
    [Tags]    Success    vpn    Sprint3    Test
    Create Browser Session    ${url_auth_fbb}
    Fill Username FBB OTP
    Click Request OTP Button
    Get OTP Password FBB
    Fill OTP Password FBB
    Click Login Button In FBB OTP
    Create URL For Get Token FBB OTP
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Verify Decoded Value Access Token
    Verify Decoded Value ID Token
    # Decode Access Token
    # Decoded ID Token
    # Set API Header B2C
    # Set API Body B2C
    # Send Post Request Validate Token
    # Verify Response Success Validate Token

TST_F2_1_1_002 Verify LoginOTP for check device status sold
    [Documentation]    Owner:
    [Tags]    Success    On-Hold

TST_F2_1_1_003 Verify LoginOTP for check device status stolen
    [Documentation]    Owner: 
    [Tags]    Success    On-Hold

TST_F2_1_1_006 Verify LoginOTP for check status profile active
    [Documentation]    Owner: 
    [Tags]    Success    On-Hold

TST_F2_1_1_007 Verify LoginOTP for check status profile suspendDebt1way
    [Documentation]    Owner:
    [Tags]    Success    On-Hold

TST_F2_1_1_008 Verify LoginOTP for check status profile creditLimited1way
    [Documentation]    Owner:
    [Tags]    Success    On-Hold

TST_F2_0_1_001 Verify FBB with invalid ip ais fbb
    [Documentation]    Owner:
    [Tags]    Fail    On-Hold
    
TST_F2_0_1_002 Verify FBB get token fail with authcode expire
    [Documentation]    Owner:
    [Tags]    Fail    vpn    Sprint3
    Create Browser Session    ${url_auth_fbb}
    Fill Username FBB OTP
    Click Request OTP Button
    Get OTP Password FBB
    Fill OTP Password FBB
    Click Login Button In FBB OTP
    Create URL For Get Token FBB OTP
    Wait For Authentication Code Expire
    New Page    ${URL_GET_TOKEN}
    Verify Invalid Grant On Webpage
    # Verify Decoded Value Access Token
    # Verify Decoded Value ID Token
    
TST_F2_0_1_003 Verify FBB get token with client_id and client_secret no match
    [Documentation]    Owner: 
    [Tags]    Fail    On-Hold
    
TST_F2_0_1_004 Verify FBB get token with FBB No Contact number 8858980011
    [Documentation]    Owner:
    [Tags]    Fail    On-Hold
    