*** Settings ***
Resource    ./Resource_init.robot
Suite Setup       Keyword Suite Setup
Test Teardown     Run Keyword And Ignore Error    Keyword Test Teardown
Suite Teardown    Run Keyword And Ignore Error    Keyword Suite Teardown


*** Test Cases ***
TST_F2_1_1_001 Verify LoginOTP
    [Documentation]    Owner: Nakarin
    [Tags]    Success    SmokeTest
    Create Browser Session    ${url_auth_fbb}
    Fill Username FBB OTP
    Click Request OTP Button
    Get OTP Password FBB
    Fill OTP Password FBB
    Press Login Button In FBB OTP
    Create URL For Get Token    ${url_for_token_validate_token}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Verify Response Key FBB OTP
    Verify Decoded Value Access Token FBB OTP
    Verify Decoded Value ID Token FBB OTP

TST_F2_0_1_002 Verify FBB get token fail with authcode expire
    [Documentation]    Owner: Nakarin
    [Tags]    Fail    auth_expire
    Create Browser Session    ${url_auth_fbb}
    Fill Username FBB OTP
    Click Request OTP Button
    Get OTP Password FBB
    Fill OTP Password FBB
    Press Login Button In FBB OTP
    Create URL For Get Token     ${url_for_token_validate_token}
    Wait For Authentication Code Expire
    New Page    ${URL_GET_TOKEN}
    Verify Invalid Grant On Webpage
    
TST_F2_0_1_003 Verify FBB get token with client_id and client_secret no match
    [Documentation]    Owner:sasipen  
    [Tags]    Fail    FBB_OTP   
    Create Browser Session    ${url_auth_fbb}
    Fill Username FBB OTP
    Click Request OTP Button
    Get OTP Password FBB
    Fill OTP Password FBB
    Press Login Button In FBB OTP
    Create URL For Get Token     ${url_get_token_fbb_client_no_match}
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Verify Response Client Id And Client Secret No Match

TST_F2_0_1_004 Verify FBB get token with FBB No Contact number 8858980011
    [Documentation]    Owner:sasipen
    [Tags]    Fail    FBB_OTP    
    Create Browser Session    ${url_auth_fbb}
    Fill Username FBB OTP Number No Contact
    Verify Page Can Not Click Request Otp   
