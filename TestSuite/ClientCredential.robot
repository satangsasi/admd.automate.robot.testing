*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Append To Document Teardown


*** Test Cases ***
TST_F7_1_1_001 ClientCredentials with client id on backend
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can loginB2B success and  received Access Token.
    [Tags]    Client_Credentials    SmokeTest
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Verify Response Client Credentials    ${expected_expires_in_client_credentials_backend}
    Decode Token To Jwt Client Credentials
    Verify Response Jwt Decode

TST_F7_1_1_002 ClientCredentials with client id on browser
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can loginB2B success and  received Access Token.
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u_browser}
    ...                            ${client_secret_id_OhFw3u_browser}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Verify Response Client Credentials    ${expected_expires_in_client_credentials_browser}
    Decode Token To Jwt Client Credentials 
    Verify Response Jwt Decode

TST_F7_0_1_001 Verify ClientCredentials with Invalid client_id
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u_invalid}
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    401
    Verify Response Client Credentials Error   ${error_message_invalid_client}
    
TST_F7_0_1_002 Verify ClientCredentials with Invalid client_secret
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}
    ...                            ${client_secret_id_OhFw3u_invalid}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    401
    Verify Response Client Credentials Error   ${error_message_invalid_client}

TST_F7_0_1_003 Verify ClientCredentials with Invalid grant_type
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${grant_type_invalid_}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400
    Verify Response Client Credentials Error   ${error_message_unsupported_grant_type}

TST_F7_0_1_004 Verify ClientCredentials with No match client_id and client_secret
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}
    ...                            ${client_secret_id_another}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    401
    Verify Response Client Credentials Error   ${error_message_invalid_client}

TST_F7_0_1_005 Verify ClientCredentials with missing client_id
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials Missing Client Id    ${client_secret_id_OhFw3u}
    ...                                              ${grant_type}
    ...                                              ${nonce}
    Send Request Client Credentials Invalid    400
    Verify Response Client Credentials Error   ${error_message_invalid_request}

TST_F7_0_1_006 Verify ClientCredentials with missing client_secret
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials Missing Client Secret    ${client_id_OhFw3u}  
    ...                                                  ${grant_type}     
    ...                                                  ${nonce}
    Send Request Client Credentials Invalid    400
    Verify Response Client Credentials Error   ${error_message_invalid_request}
    
TST_F7_0_1_007 Verify ClientCredentials with missing grant_type
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials Missing Grant Type    ${client_id_OhFw3u}
    ...                                               ${client_secret_id_OhFw3u}
    ...                                               ${nonce}
    Send Request Client Credentials Invalid    400
    Verify Response Client Credentials Error   ${error_message_invalid_request}
    
TST_F7_0_1_008 Verify ClientCredentials With Unknow URL
    [Documentation]     Owner : sasipen
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    [Tags]    Client_Credentials
    Set Content Header Client Credentials    ${url_client_credentials_invalid}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u} 
    ...                            ${client_secret_id_OhFw3u} 
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400    
    Verify Response Client Credentials Error   ${error_message_invalid_request}
    