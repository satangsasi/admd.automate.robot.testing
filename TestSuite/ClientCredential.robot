*** Settings ***
Resource    ./Resource_init.robot
# Test Teardown    Set Document Actual Result    ${ACTUAL_RESULT}
*** Test Cases ***
TST_F7_1_1_001 ClientCredentials with client id on backend
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can loginB2B success and  recieved Access Token.
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Verify Access Token
    # Append Response Data    ${RESPONSE.headers}    ${RESPONSE.json()}
    [Teardown]    Set Document Actual Result    ${RESPONSE.json}

TST_F7_1_1_002 ClientCredentail with client id on browser
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can loginB2B success and  recieved Access Token.
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u_browser}
    ...                            ${client_secret_id_OhFw3u_browser}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Verify Access Token
    # Decode Token To JWT

TST_F7_0_1_001 Verify ClientCredentail with Invalid client_id
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${invalid_client_id_OhFw3u}   
    ...                            ${client_secret_id_OhFw3u}  
    ...                            ${grant_type} 
    ...                            ${nonce} 
    Send Request Client Credentials Invalid    401  
    Verify Response Client Credentials Error   invalid_client
    

TST_F7_0_1_002 Verify ClientCredentail with Invalid client_secret
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}   
    ...                            ${invalid_client_secret_id_OhFw3u}
    ...                            ${grant_type} 
    ...                            ${nonce} 
    Send Request Client Credentials Invalid    401
    Verify Response Client Credentials Error   invalid_client 
    

TST_F7_0_1_003 Verify ClientCredentail with Invalid grant_type
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}     
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${invalid_grant_type}   
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400  
    Verify Response Client Credentials Error   unsupported_grant_type
    

TST_F7_0_1_004 Verify ClientCredentail with No match client_id and client_secret
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}  
    ...                            ${client_secret_id_another}
    ...                            ${grant_type}  
    ...                            ${nonce}
    Send Request Client Credentials Invalid    401        
    Verify Response Client Credentials Error   invalid_client    
    

TST_F7_0_1_005 Verify ClientCredentail with missing client_id
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials Missing Client Id    ${client_secret_id_OhFw3u}   
    ...                            ${grant_type}   
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400    
    Verify Response Client Credentials Error   invalid_request 
    

TST_F7_0_1_006 Verify ClientCredentail with missing client_secret
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials Missing Client Secret    ${client_id_OhFw3u}  
    ...                            ${grant_type}     
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400
    Verify Response Client Credentials Error   invalid_request
    
TST_F7_0_1_007 Verify ClientCredentail with missing grant_type
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials Missing Grant Type    ${client_id_OhFw3u}  
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400    
    Verify Response Client Credentials Error   invalid_request
    
TST_F7_0_1_008 Verify ClientCredentail With Unknow URL
    [Documentation]     Owner : sasipen
    ...
    ...    ***Condition***
    ...
    ...    ***Expected Result***
    ...    \r\n User can't loginB2B
    ...
    ...    ***Provisioning data***
    Set Content Header             ${invalid_url_client_credentials_dev} 
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u} 
    ...                            ${client_secret_id_OhFw3u} 
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400    
    Verify Response Client Credentials Error   invalid_request
    