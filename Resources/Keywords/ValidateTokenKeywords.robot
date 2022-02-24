*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content API Header
    [Documentation]    Owner: Nakarin
    [Arguments]    ${key}    ${value}
    ${status}    Run Keyword And Return Status    Variable Should Exist    ${API_HEADER}
    IF  ${status} == True
        ${header}    Set Variable    ${API_HEADER}
    ELSE
        ${header}    Create Dictionary
    END
    Set To Dictionary    ${header}    ${key}=${value}
    Log    ${header}
    Set Test Variable    ${API_HEADER}    ${header}

Set Content API Body
    [Documentation]    Owner: Nakarin
    ${api_json}    OperatingSystem.Get File    ../Schema/ValidateTokenSchema.json
    Set Test Variable    ${API_BODY}    ${api_json}
