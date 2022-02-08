*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Documentation Test Request
    [Arguments]    ${type_request}    ${url}            
    Set Test Documentation    \r\n request ${type_request} ${url}         Append=True

Set Documentation Test Header
    [Arguments]    ${data_header}
    Set Test Documentation    \r\n header ${data_header}    Append=True        

Set Documentation Test Body
    [Arguments]    ${data_body}
    Set Test Documentation    \r\n body ${data_body}        Append=True

Set Document Actual Result
    [Documentation]    Owner: Nakarin
    [Arguments]    ${actual_result}=${EMPTY}
    Set Test Documentation    ${DOC_PROVISIONING_DATA}     Append=True
    Set Test Documentation    \r\n***Actual Result***      Append=True
    Set Test Documentation    \r\n${actual_result}         Append=True

Set Documentation Test User
    [Arguments]    ${username}=${EMPTY} 
    Set Test Variable    ${PRO_USER}    \r\n User : ${username}    Append=True

Set Documentation Test Password
    [Arguments]    ${password}=${EMPTY} 
    Set Test Variable    ${PRO_PASSWD}    \r\n Password : ${password}    Append=True
    
Set Documentation Test Url Authentication
    [Arguments]    ${url}=${EMPTY} 
    Set Test Variable    ${PRO_URL_AUTHENTICATION}    \r\n URL for authentication : ${url}    Append=True

Set Documentation Test Url Get Token
    [Arguments]    ${url}=${EMPTY} 
    Set Test Variable    ${PRO_URL_GET_TOKEN}    \r\n URL for get token : ${url}    Append=True

Set Documentation Test Url Get Refresh Token
    [Arguments]    ${url}=${EMPTY} 
    Set Test Variable    ${PRO_URL_GET_REFRESH_TOKEN}    \r\n URL for get refresh token : ${url}    Append=True

# Set Documentation Test Provisioning Data 
#     Set Test Variable    ${PROVISIONING_DATA}    \r\n${PRO_USER}\r\n$${PRO_PASSWD}

Set Test Provisioning Data 
    [Arguments]    ${data}  
    ${status}    Run Keyword And Return Status    Variable Should Exist    ${DOC_PROVISIONING_DATA}
    ${DOC_PROVISIONING_DATA}    Set Variable If    ${status}==False    ${EMPTY}   
    ${provisioning_data}    Set Variable    ${DOC_PROVISIONING_DATA}\r\n${data}
    Set Test Variable    ${DOC_PROVISIONING_DATA}    ${provisioning_data}               
