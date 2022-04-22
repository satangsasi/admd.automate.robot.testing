*** Settings ***
Resource          ./Resource_init.robot
Suite Setup       Keyword Suite Setup
Test Teardown     Run Keyword And Ignore Error    Keyword Test Teardown
Suite Teardown    Run Keyword And Ignore Error    Keyword Suite Teardown
   

*** Test Cases ***
TST_F13_1_1_001 Verify Registered with Email Password and scope profile
    [Documentation]    Owner:sasipen
    ...    \r\n*** Conditions ***
    ...    \r\ntemplate 3.1 > token 3.2
    [Tags]    Success    Logout_pushnotify 
    Create Browser Session    ${url_registered_logout_pushnotify}
    Click Sign Up Button      ${llb_sign_up}
    Fill Information For Register
    Click Accept Term And Condition
    Click Sign Up Button      ${btn_sign_up_page_register}
    Verify Page Sing Up Success
    Get Link Confirm Register Form Server
    New Page    ${URL_CONFIRM_REGISTER}
    Create URL For Get Token    ${url_get_token_logout_pushnotify}
    New Page                    ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response On Webpage Logout Pushnotify
    Decoded Access Token
    Verify Decoded Value Access Token Logout Pushnotify
    Decoded ID Token
    Verify Decoded Value Id Token Logout Pushnotify

TST_F13_1_1_002 Verify Login with Email Password and scope profile
    [Documentation]    Owner:sasipen
    ...    \r\n*** Conditions ***
    ...    \r\ntemplate 3.1 > token 3.2
    [Tags]    Success    Logout_pushnotify 

TST_F13_1_1_003 Verify sso with Email Password and scope profile
    [Documentation]    Owner:sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nlogin template 3.1 > login token 3.2 > sso template 3.1 > sso token 3.2
    [Tags]    Success    Logout_pushnotify

TST_F13_1_1_004 Verify Refresh Token with app Learndi and scope : profile
    [Documentation]    Owner:
    ...    \r\n*** Conditions ***
    ...    \r\ntemplate 3.1 > token 3.2 > refresh_token 3.2
    [Tags]    Success    Logout_pushnotify    On-Hold 

TST_F13_1_1_004 Verify Logout with Push Noti
    [Documentation]    Owner:
    [Tags]    Success    Logout_pushnotify    On-Hold 
