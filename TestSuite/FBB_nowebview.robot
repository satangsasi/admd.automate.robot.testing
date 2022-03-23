*** Settings ***
Resource    ./Resource_init.robot
Suite Setup       Keyword Suite Setup
Test Teardown     Keyword Test Teardown
Suite Teardown    Keyword Suite Teardown


*** Test Cases ***
TST_F3_1_1_001 Verify Login No web view
    [Documentation]    Owner: Nakarin
    ...    \r\n*** Condition ***
    ...    \r\ngrant_type : Password มี ial + aal
    [Tags]    Success    Sprint4
    Set API Header FBB No Web View
    Set API Body FBB No Web View
    Send Request FBB No Web View
    Verify Response Key FBB No Web View
    Get OTP Password FBB No Web View
    Set API Header Get Token FBB No Web View
    Set API Body Get Token FBB No Web View
    Send Request Get Token FBB No Web View
    Verify Response Key Get Token FBB No Web View

TST_F3_1_1_002 Verify Login No web view for check 
    [Documentation]    Owner: Nakarin
    ...    \r\n*** Condition ***
    ...    \r\ndevice status : sold 
    ...    \r\nPhoneNumber type : FBB
    [Tags]    Success    Sprint4    On-Hold

TST_F3_1_1_003 Verify Login No web view for check
    [Documentation]    Owner: Nakarin
    ...    *** Condition ***
    ...    \r\ndevice status : stolen
    ...    \r\nPhoneNumber type : FBB
    [Tags]    Success    Sprint4    On-Hold















































































































































# =================>





















































































































































# =================>



