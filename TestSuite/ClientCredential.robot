*** Settings ***
Library    Collections
Library    RequestsLibrary
Resource    ../../arcadia.automate.buffet/APIBuffet/RequestLibrary_APIKeywords.robot
Resource    ../Resource/Keyword/ClientCredentialKeyword.robot    
*** Test Cases ***
TST_F7_1_1_001 ClientCredentials with client id on backend
    [Documentation]     Owner : sasipen
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}     
    ...                            ${client_secret_id_OhFw3u}    
    ...                            ${grant_type}    
    ...                            ${nonce}   
    Send Request Client Credentials      
    Verify Access Token
    # Decode Token To JWT 
TST_F7_1_1_002 ClientCredentail with client id on browser
    [Documentation]     Owner : sasipen
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
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${invalid_client_id_OhFw3u}   
    ...                            ${client_secret_id_OhFw3u}  
    ...                            ${grant_type} 
    ...                            ${nonce} 
    Send Request Client Credentials Invalid    401  
    Verify Response Client Credentials Error   invalid_client
    

TST_F7_0_1_002 Verify ClientCredentail with Invalid client_secret
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}   
    ...                            ${invalid_client_secret_id_OhFw3u}
    ...                            ${grant_type} 
    ...                            ${nonce} 
    Send Request Client Credentials Invalid    401
    Verify Response Client Credentials Error   invalid_client 
    

TST_F7_0_1_003 Verify ClientCredentail with Invalid grant_type
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}     
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${invalid_grant_type}   
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400  
    Verify Response Client Credentials Error   unsupported_grant_type
    

TST_F7_0_1_004 Verify ClientCredentail with No match client_id and client_secret
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u}  
    ...                            ${client_secret_id_another}
    ...                            ${grant_type}  
    ...                            ${nonce}
    Send Request Client Credentials Invalid    401        
    Verify Response Client Credentials Error   invalid_client    
    

TST_F7_0_1_005 Verify ClientCredentail with missing client_id
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials Missing Client Id    ${client_secret_id_OhFw3u}   
    ...                            ${grant_type}   
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400    
    Verify Response Client Credentials Error   invalid_request 
    

TST_F7_0_1_006 Verify ClientCredentail with missing client_secret
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials Missing Client Secret    ${client_id_OhFw3u}  
    ...                            ${grant_type}     
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400
    Verify Response Client Credentials Error   invalid_request
    
TST_F7_0_1_007 Verify ClientCredentail with missing grant_type
    Set Content Header             ${url_client_credentials_dev}
    ...                            ${content_type_x_www}
    Set Body Client Credentials Missing Grant Type    ${client_id_OhFw3u}  
    ...                            ${client_secret_id_OhFw3u}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400    
    Verify Response Client Credentials Error   invalid_request
    

TST_F7_0_1_008 Verify ClientCredentail With Unknow URL
    Set Content Header             ${invalid_url_client_credentials_dev} 
    ...                            ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u} 
    ...                            ${client_secret_id_OhFw3u} 
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials Invalid    400    
    Verify Response Client Credentials Error   invalid_request
    