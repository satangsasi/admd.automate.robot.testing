*** Settings ***
Resource    ./Resource_init.robot
Suite Setup       Keyword Suite Setup
Test Teardown     Run Keyword And Ignore Error    Keyword Test Teardown
Suite Teardown    Run Keyword And Ignore Error    Keyword Suite Teardown


*** Test Cases ***
TST_F4_1_1_001 Verify login with EmailOTP
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    Decode Get Token Email Otp Jwt By Key Access Token
    Verify Response Decode Get Token Email Otp By Key Access Token
    Decode Get Token Email Otp Jwt By Key Id Token
    Verify Response Decode Get Token Email Otp By Key Id Token

TST_F4_0_1_001 Verify getting token with username is msisdn otp but no input session_id or transaction_id
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    Verify Response Get Token Email Otp Error        ${error_message_invalid_request}

TST_F4_0_1_002 Verify getting token with username is msisdn otp but incorrect session_id or transaction_id
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    ...                              ${invalid_session_id}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp Invalid    400
    Verify Response Get Token Email Otp Error        ${error_message_invalid_request}

TST_F4_0_1_003 Verify getting token with username is msisdn otp but input wrong type 0
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    ...                              ${invalid_type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${ACTUAL_VALUE_SESSION_ID}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp Invalid    401
    Verify Response Get Token Email Otp Error        ${error_message_invalid_user_or_password}

TST_F4_0_1_004 Verify getting token fail with wrong password
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    ...                              ${invalid_password}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${ACTUAL_VALUE_SESSION_ID}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp Invalid    401
    Verify Response Get Token Email Otp Error        ${error_message_invalid_user_or_password}

TST_F4_0_1_005 Verify getting token fail with expired password
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    Wait For Password Expire
    Send Post Request Get Token Email Otp Invalid    408
    Verify Response Get Token Email Otp Error        ${error_message_request_timeout}

TST_F4_0_1_006 Verify request OTP with use email that without a profile
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
    Set Content Header Request Email Otp    ${url_request_email_otp}
    ...                                     ${content_type_json}
    Set Body Request Email Otp              ${client_id_PK+WUA}
    ...                                     ${invalid_public_id}
    ...                                     ${reference}
    Send Post Request Email Otp Invalid     503
    Verify Response Invalid Request Email Otp

TST_F4_0_1_007 Verify getting token fail
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    ...                              ${invalid_transaction_id}
    Send Post Request Get Token Email Otp Invalid    400
    Verify Response Get Token Email Otp Error        ${error_message_invalid_request}

TST_F4_0_1_008 Verify getting token fail with Invalid client_id
    [Tags]    Email_Otp
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
    Set Body Get Token Email Otp     ${invalid_client_id_ABCDEF}
    ...                              ${client_secret_id_PK+WUA}
    ...                              ${grant_type_email_otp}
    ...                              ${public_id}
    ...                              ${EMAIL_OTP_PASSWORD}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${ACTUAL_VALUE_SESSION_ID}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp Invalid    500
    Verify Response Get Token Email Otp Error        ${error_message_server_error}

TST_F4_0_1_009 Verify getting token fail with Invalid grant_type
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    ...                              ${invalid_grant_type_email_otp}
    ...                              ${public_id}
    ...                              ${EMAIL_OTP_PASSWORD}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${ACTUAL_VALUE_SESSION_ID}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp Invalid    400
    Verify Response Get Token Email Otp Error        ${error_message_unsupported_grant_type}

TST_F4_0_1_010 Verify getting token fail with Invalid client_Secret
    [Documentation]     Owner : sasipen
    [Tags]    Email_Otp
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
    ...                              ${invalid_client_secret}
    ...                              ${grant_type_email_otp}
    ...                              ${public_id}
    ...                              ${EMAIL_OTP_PASSWORD}
    ...                              ${type_get_token_email_otp}
    ...                              ${scope_get_token_email_otp}
    ...                              ${ACTUAL_VALUE_SESSION_ID}
    ...                              ${ACTUAL_VALUE_TRANSACTION_ID}
    Send Post Request Get Token Email Otp Invalid    401
    Verify Response Get Token Email Otp Error        ${error_message_invalid_client}
