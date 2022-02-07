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
    [Arguments]    ${actual_result}
    Set Test Documentation    \r\n ***Actual Result***      Append=True
    Set Test Documentation    \r\n${actual_result}          Append=True
    
Append Response Data
    [Documentation]    Owner: Nakarin
    [Arguments]     ${header}=${EMPTY}    ${body_response}=${EMPTY}
    ${response}    Convert To String    ${header}\r\n${body}
    Set Test Variable    ${RESPONSE_DATA}    ${response}
