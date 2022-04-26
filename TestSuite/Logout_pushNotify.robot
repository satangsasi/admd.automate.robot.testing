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
    [Tags]    Success    Logout_pushnotify     action_delay    SmokeTest
    [Setup]    Run Keyword And Ignore Error    Keyword Test Set Up Delete Email Register
    Create Browser Session    ${url_registered_logout_pushnotify}
    Click Sign Up      ${llb_sign_up}
    Fill Information For Register
    Click Accept Term And Condition
    Click Sign Up      ${btn_sign_up_page_register}
    Verify Page Sing Up Success
    Get Link Confirm Register Form Server
    New Page    ${URL_CONFIRM_REGISTER}
    Create URL For Get Token    ${url_get_token_logout_pushnotify}
    New Page                    ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response On Webpage Logout Pushnotify
    Decoded Access Token
    Verify Decoded Value Access Token Register Email Logout Pushnotify
    Decoded ID Token
    Verify Decoded Value Id Token Register Email Logout Pushnotify

TST_F13_1_1_002 Verify Login with Email Password and scope profile
    [Documentation]    Owner:sasipen
    ...    \r\n*** Conditions ***
    ...    \r\ntemplate 3.1 > token 3.2
    [Tags]    Success    Logout_pushnotify    action_delay
    Create Browser Session    ${url_registered_logout_pushnotify}
    Fill Email And Password For Sing In
    Click Sing In
    Create URL For Get Token    ${url_get_token_logout_pushnotify}
    New Page                    ${URL_GET_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response On Webpage Logout Pushnotify
    Decoded Access Token
    Verify Decoded Value Access Token Sing In Logout Pushnotify
    Decoded ID Token
    Verify Decoded Value Id Token Sing In Logout Pushnotify

TST_F13_1_1_003 Verify sso with Email Password and scope profile
    [Documentation]    Owner:sasipen
    ...    \r\n*** Conditions ***
    ...    \r\nlogin template 3.1 > login token 3.2 > sso template 3.1 > sso token 3.2
    [Tags]    Success    Logout_pushnotify    action_delay
    Sing In And Open Link Get Token
    New Page                    ${url_registered_logout_pushnotify}
    Create URL For Get Token    ${url_get_token_logout_pushnotify}
    New Page                    ${URL_GET_TOKEN}           
    Set Response On Webpage To Json    ${set_test_actual_result}     
    Verify Response On Webpage Logout Pushnotify
    Decoded Access Token
    Verify Decoded Value Access Token Sso Logout Pushnotify
    Decoded ID Token
    Verify Decoded Value Id Token Sso Logout Pushnotify
    
TST_F13_1_1_004 Verify Refresh Token with app Learndi and scope : profile
    [Documentation]    Owner:sasipen
    ...    \r\n*** Conditions ***
    ...    \r\ntemplate 3.1 > token 3.2 > refresh_token 3.2
    [Tags]    Success    Logout_pushnotify    action_delay
    Create Browser Session      ${url_registered_logout_pushnotify}
    Fill Email And Password For Sing In
    Click Sing In
    Create URL For Get Token    ${url_get_token_logout_pushnotify}
    New Page                    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Create URL For Get Refresh Token Logout Pushnotify
    New Page                    ${URL_GET_REFRESH_TOKEN}
    Set Response On Webpage To Json    ${set_test_actual_result}
    Verify Response On Webpage Refresh Token Logout Pushnotify
    Decoded Access Token
    Verify Decoded Value Access Token Refresh Token Logout Pushnotify

TST_F13_1_1_005 Verify Logout with Push Noti
    [Documentation]    Owner:sasipen
    [Tags]    Success    Logout_pushnotify    action_delay
    Create Browser Session      ${url_registered_logout_pushnotify}
    Fill Email And Password For Sing In
    Click Sing In
    Create URL For Get Token    ${url_get_token_logout_pushnotify}
    New Page                    ${URL_GET_TOKEN}
    Set Response On Webpage To Json 
    Set API Header Logout Pushnotify
    Set API Body Logout Pushnotify
    Send Post Request Logout Pushnotify
    Verify Response Logout Pushnotify
