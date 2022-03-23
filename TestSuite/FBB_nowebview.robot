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
TST_F3_1_1_004 Verify Login No web view for check sevice playbox pending status 0
    Set Content Header Request Email Otp    ${url_request_email_otp}
    ...                                     ${content_type_json}
    Set Body Request Email Otp              ${client_id_PK+WUA}
    ...                                     ${public_id_885}
    ...                                     ${reference}
    Send Post Request Email Otp
    Verify Response Request Email Otp
    Get Value Response Request Email Otp By Key Session Id
    Get Value Response Request Email Otp By Key Transaction Id
    Get Email OTP Password                      ${ACTUAL_VALUE_TRANSACTION_ID}
    Set Content Header Get Token Email Otp      ${url_get_token_email_otp}
    ...                                         ${content_type_x_www}
    Set Body Get Token Email Otp     ${client_id_PK+WUA}
    ...                              ${client_secret_id_PK+WUA}
    ...                              ${grant_type_email_otp}
    ...                              ${public_id_885}
    ...                              ${EMAIL_OTP_PASSWORD}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${ACTUAL_VALUE_SESSION_ID}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp




















































































































































# =================>



