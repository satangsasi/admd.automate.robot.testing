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
    [Tags]    Success    FBB_nowebview    SmokeTest
    Set API Header FBB No Web View
    Set API Body FBB No Web View
    Send Request FBB No Web View
    Verify Response Key FBB No Web View
    Get OTP Password FBB No Web View
    Set API Header Get Token FBB No Web View
    Set API Body Get Token FBB No Web View
    Send Request Get Token FBB No Web View
    Verify Response Key Get Token FBB No Web View

TST_F3_0_1_001 Verify FBB get token with client id and client secret no match 
    [Documentation]    Owner: Atitaya
    [Tags]    Fail      FBB_nowebview     
    Set API Header FBB No Web View
    Set API Body FBB No Web View
    Send Request FBB No Web View
    Verify Response Key FBB No Web View
    Get OTP Password FBB No Web View
    Set API Header Get Token FBB No Web View No Match
    Set API Body Get Token FBB No Web View No Match  
    Send Request Token FBB No Web View No Match        401
    Verify Response Get Token With Client Id And Client Secret No Match

TST_F3_0_1_002 Verify Request OTP with FBB No Contact number
    [Documentation]    Owner: Atitaya
    [Tags]    Fail      FBB_nowebview 
    Set API Header FBB No Web View
    Set API Body FBB No Web View No Contact Number
    Send Request FBB No Web View No Contact Number      500
    Verify Response OTP No Contact Number    
