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
    [Tags]    Success    On-Hold

TST_F3_1_1_003 Verify Login No web view for check
    [Documentation]    Owner: Nakarin
    ...    *** Condition ***
    ...    \r\ndevice status : stolen
    ...    \r\nPhoneNumber type : FBB
    [Tags]    Success     On-Hold















































































































































# =================>
TST_F3_1_1_004 Verify Login No web view for check sevice playbox pending status 0
    [Documentation]    Owner: sasipen
    ...    \r\n*** Condition ***
    ...    \r\nhave service playbox
    [Tags]    Success    On-Hold
    
TST_F3_1_1_005 Verify Login No web view for check sevice playbox pending status 1
    [Documentation]    Owner: sasipen
    ...    \r\n*** Condition ***
    ...    \r\ndon't have service playbox
    [Tags]    Success    On-Hold

TST_F3_1_1_006 Verify Login No web view for check status profile active
    [Documentation]    Owner: sasipen
    [Tags]    Success    On-Hold

TST_F3_1_1_007 Verify Login No web view for check status profile suspendDebt1way
    [Documentation]    Owner: sasipen
    [Tags]    Success    On-Hold

TST_F3_1_1_008 Verify Login No web view for check status profile creditLimitted1way
    [Documentation]    Owner: sasipen
    [Tags]    Success    On-Hold

















































































































































# =================>



