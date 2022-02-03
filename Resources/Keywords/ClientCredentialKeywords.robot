*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content Header
    [Documentation]     Owner : sasipen
    [Arguments]          ${url}    ${content_type}
    ${headers}           Replace String        ${header_client_credentials_schema}    _Content-Type_    ${content_type}            
    Set Test Variable    ${HEADER_CLIENT_CREDENTIALS}    ${headers}
    Set Test Variable    ${URL}    ${url}

Set Body Client Credentials 
    [Documentation]     Owner : sasipen
    [Arguments]        ${client_id}    ${client_secret}    ${grant_type}    ${nonce}
    ${body_client_id}        Replace String    ${body_client_credentials_schema}   _client_id_         ${client_id}
    ${body_client_secret}    Replace String    ${body_client_id}                   _client_secret_     ${client_secret}    
    ${body_grant_type}       Replace String    ${body_client_secret}               _grant_type_        ${grant_type} 
    ${body_nonce}            Replace String    ${body_grant_type}                  _nonce_             ${nonce}        
    Set Test Variable        ${BODY_CLIENT_CREDENTIALS}         ${body_nonce}      

Set Body Client Credentials Missing Client Id 
    [Documentation]     Owner : sasipen
    [Arguments]        ${client_secret}    ${grant_type}    ${nonce}
    ${body_client_secret}    Replace String    ${body_client_credentials_missing_id_schema}    _client_secret_     ${client_secret}    
    ${body_grant_type}       Replace String    ${body_client_secret}                           _grant_type_        ${grant_type} 
    ${body_nonce}            Replace String    ${body_grant_type}                              _nonce_             ${nonce}        
    Set Test Variable        ${BODY_CLIENT_CREDENTIALS}         ${body_nonce}    

Set Body Client Credentials Missing Client Secret
    [Documentation]     Owner : sasipen
    [Arguments]        ${client_id}    ${grant_type}    ${nonce}
    ${body_client_id}        Replace String    ${body_client_credentials_missing_secret_schema}   _client_id_         ${client_id}
    ${body_grant_type}       Replace String    ${body_client_id}                                  _grant_type_        ${grant_type} 
    ${body_nonce}            Replace String    ${body_grant_type}                                 _nonce_             ${nonce}        
    Set Test Variable        ${BODY_CLIENT_CREDENTIALS}         ${body_nonce}      

Set Body Client Credentials Missing Grant Type
    [Documentation]     Owner : sasipen
    [Arguments]        ${client_id}    ${client_secret}    ${nonce}
    ${body_client_id}        Replace String    ${body_client_credentials_missing_grant_type_schema}   _client_id_         ${client_id}
    ${body_client_secret}    Replace String    ${body_client_id}                                      _client_secret_     ${client_secret}    
    ${body_nonce}            Replace String    ${body_client_secret}                                  _nonce_             ${nonce}        
    Set Test Variable        ${BODY_CLIENT_CREDENTIALS}         ${body_nonce} 

Send Request Client Credentials
    [Documentation]     Owner : sasipen 
    Send Post Request    url=${URL}      headers=${HEADER_CLIENT_CREDENTIALS}    body=${BODY_CLIENT_CREDENTIALS}    

Send Request Client Credentials Invalid
    [Arguments]        ${statuscode}    
    Send Post Request    url=${URL}      headers=${HEADER_CLIENT_CREDENTIALS}    body=${BODY_CLIENT_CREDENTIALS}   expected_status=${statuscode}    

Verify Access Token
    ${token}    Get Value Response By Key     access_token
    Should Match Regexp          ${token}       .+  
    Log     ${token} 
    
Verify Response Client Credentials Error
    [Arguments]        ${error_message}
    Verify Value Response By Key    error        ${error_message}  
# Decode Token To JWT 
#     Set Test Documentation    doc



Set Documentation Test
    [Arguments]    ${condition_message}=${EMPTY}        ${expected_result_message}=${EMPTY}    ${type_request}=POST   ${url}=${EMPTY}                 
    #Set Test Documentation    Owner : sasipen\r\n***Condition***\r\n${condition_message}\r\n***Expected Result***\r\n${expected_result_message}\r\n***Provisioning data***\r\n request ${type_request} ${url}
    Set Test Documentation    \r\n request ${type_request} ${url}          Append=***Provisioning data***

Set Documentation Test Header
    Set Test Documentation    \r\n header ${HEADER_CLIENT_CREDENTIALS}      Append=ture    