*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Append To Document Teardown

*** Test Cases ***
TST_F4_1_1_001 Verify login with EmailOTP
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp    Test
    Set Content Header Request Email Otp    ${url_request_email_otp}
    ...                                     ${content_type_json}
    Set Body Request Email Otp              ${client_id_PK+WUA}    
    ...                                     ${public_id} 
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
    ...                              ${public_id}
    ...                              ${EMAIL_OTP_PASSWORD}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${ACTUAL_VALUE_SESSION_ID}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp
    Verify Response Get Token Email Otp

TST_F4_0_1_001 Verify getting token with username is msisdn otp but no input session_id or transaction_id
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp    Test
    Set Content Header Request Email Otp    ${url_request_email_otp}
    ...                                     ${content_type_json}
    Set Body Request Email Otp              ${client_id_PK+WUA}    
    ...                                     ${public_id} 
    ...                                     ${reference}
    Send Post Request Email Otp
    Verify Response Request Email Otp
    Get Value Response Request Email Otp By Key Session Id
    Get Value Response Request Email Otp By Key Transaction Id 
    Get Email OTP Password                      ${ACTUAL_VALUE_TRANSACTION_ID}
    Set Content Header Get Token Email Otp      ${url_get_token_email_otp}    
    ...                                         ${content_type_x_www}
    Set Body Get Token Email Otp No Session And Transaction Id     ${client_id_PK+WUA}    
    ...                              ${client_secret_id_PK+WUA}
    ...                              ${grant_type_email_otp}
    ...                              ${public_id}
    ...                              ${EMAIL_OTP_PASSWORD}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    Send Post Request Get Token Email Otp Invalid    400
    Verify Response Get Token Email Otp Error        invalid_request
TST_F4_0_1_002 Verify getting token with username is msisdn otp but incorract session_id or transaction_id
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp    Test
    Set Content Header Request Email Otp    ${url_request_email_otp}
    ...                                     ${content_type_json}
    Set Body Request Email Otp              ${client_id_PK+WUA}    
    ...                                     ${public_id} 
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
    ...                              ${public_id}
    ...                              ${EMAIL_OTP_PASSWORD}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${session_id_invalid}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp Invalid    400
    Verify Response Get Token Email Otp Error        invalid_request
TST_F4_0_1_003 Verify getting token with username is msisdn otp but input wrong type (type = 0)
TST_F4_0_1_004 Verify getting token fail with wrong password
TST_F4_0_1_005 Verify getting token fail with expired password
TST_F4_0_1_006 Verify request OTP with use email that without a profile 
TST_F4_0_1_007 Verify getting token fail
TST_F4_0_1_008 Verify getting token fail with Invalid client_id
TST_F4_0_1_009 Verify getting token fail with Invalid grant_type
TST_F4_0_1_010 Verify getting token fail with Invalid client_Secret