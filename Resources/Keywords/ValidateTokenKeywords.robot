*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content API Header
    [Documentation]    Owner: Nakarin
    [Arguments]    ${key}    ${value}    ${append}=True
    ${status}    Run Keyword And Return Status    Variable Should Exist    ${API_HEADER}
    IF  ${status} == True and ${append} == True
        ${header}    Set Variable    ${API_HEADER}
    ELSE
        ${header}    Create Dictionary
    END
    Set To Dictionary    ${header}    ${key}=${value}
    Log  ${header}
    Set Test Variable    ${API_HEADER}    ${header}

Set Content API Body
    [Documentation]    Owner: Nakarin
    [Arguments]    ${key}    ${value}    ${append}=True
    ${status}    Run Keyword And Return Status    Variable Should Exist    ${API_BODY}
    IF  ${status} == True and ${append} == True
        ${body}    Set Variable    ${API_BODY}
    ELSE
        ${body}    Create Dictionary
    END
    Set To Dictionary    ${header}    ${key}=${value}
    Log  ${body}
    Set Test Variable    ${API_BODY}    ${header}

Change API Body Value
    [Documentation]    Owner: Nakarin
    [Arguments]    ${key}    ${value}
    Set To Dictionary    ${API_BODY}[token]    ${key}    ${value}
    Set Test Variable    ${API_BODY}

Get Json API Body From File
    [Documentation]    Owner: Nakarin
    [Arguments]    ${path}
    ${json_string}    OperatingSystem.Get File    ${path}
    ${type}    Evaluate    type($json_string)
    Log To Console    ${\n}${type}
    ${json_object}    Convert String to JSON    ${json_string}
    Log    ${json_object}
    Set Test Variable    ${API_BODY}    ${json_object}

Get Access Token ClientCredential
    [Documentation]    Editor: Nakarin
    Set Content Header Client Credentials    ${url_client_credentials_${test_site}}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u_browser}
    ...                            ${client_secret_id_OhFw3u_browser}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Log    ${RESPONSE.json()}[access_token]
    Set Test Variable    ${ACCESS_TOKEN_CLIENTCREDENTIAL}    ${RESPONSE.json()}[access_token]

Set Provisioning Data From Authorization Code
    [Documentation]    Owner: Nakarin
    Set Content API Header    key=Content-Type    value=application/json    append=False
    Set Content API Header    key=X-Tid           value=login by client credentials
    Get Json API Body From File    ../Resources/Schemas/ValidateTokenSchema.json
    Change API Body Value    value    ${ACCESS_TOKEN_CLIENTCREDENTIAL}
    Log    ${API_BODY}
    Send Post Request    http://10.137.30.22:31191/v3.2/token/validateSend    headers=${API_HEADER}    body=${API_BODY}
    