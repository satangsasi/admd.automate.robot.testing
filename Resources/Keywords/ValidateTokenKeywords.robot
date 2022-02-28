*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content API Header
    [Documentation]    Owner: Nakarin
    ...    Receive [Argument] key and value or append=True to Used in ${API_HEADER}
    ...    append Use for append new key and value in to ${API_HEADER} 
    [Tags]    keyword_command
    [Arguments]    ${key}    ${value}    ${append}=True
    ${status}    Run Keyword And Return Status    Variable Should Exist    ${API_HEADER}
    IF  ${status} == True and ${append} == True
        ${header}    Set Variable    ${API_HEADER}
    ELSE
        ${header}    Create Dictionary
    END
    Set To Dictionary    ${header}    ${key}=${value}
    Log    ${header}
    Set Test Variable    ${API_HEADER}    ${header}

Get API Body From Json File 
    [Documentation]    Owner: Nakarin
    ...    Get json file and convert in to object type then return ${json_object}
    [Tags]    keyword_command
    [Arguments]    ${path}
    ${json_string}    OperatingSystem.Get File             ${path}
    ${json_object}    Convert Variable Type To Dot Dict    ${json_string}
    # Check Variable Type    ${json_object}
    Log    ${json_object}
    [Return]    ${json_object}

Set API Header Login By Client Credential
    [Documentation]    Owner: Nakarin
    ...    Set API Header for send request of Client Credential
    [Tags]    keyword_communicate
    Set Content API Header    key=Content-Type    value=application/json    append=False
    Set Content API Header    key=X-Tid           value=login by client credentials
    Log    ${API_HEADER}
    # Check Variable Type    ${API_HEADER}

Set API Body Login By Client Credential
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Client Credential
    [Tags]    keyword_communicate
    ${json}    Get API Body From Json File        ${body_validate_token_schema}
    Set To Dictionary    ${json}        client_id=${client_id_OhFw3u_browser}
    Set To Dictionary    ${json.token}      value=${ACCESS_TOKEN_CLIENTCREDENTIAL}
    Log    ${json}
    ${json_string}    Convert To String    ${json}
    ${json_string}    Replace String       ${json_string}    '    "
    ${json_string}    Remove String        ${json_string}    \n
    Log    ${json_string}
    Set Test Variable    ${API_BODY}    ${json_string}
    # ${json_string}    OperatingSystem.Get File    ${body_validate_token_schema}
    # ${json_string}    Remove String    ${json_string}    \n
    # Check Variable Type    ${json_string}
    # Set Test Variable    ${API_BODY}    ${json_string}
    # Set Test Variable    ${API_BODY}    ${json_string_var}
    # Set Body Validate Token Test    client_id=${client_id_OhFw3u_browser}    value=${ACCESS_TOKEN_CLIENTCREDENTIAL}    nonce=1234567890
    # ${json_string}    Convert To String    ${json}
    # ${string}    Remove String    ${json_string}    ${\n}
    # Set Test Variable    ${API_BODY}    ${json}

Send Post Request Validate Token
    [Documentation]    Owner: Nakarin
    ...    Send Post request 
    [Tags]    keyword_communicate
    Send Post Request    ${url_validate_token}    headers=${API_HEADER}    body=${API_BODY}

Check Variable Type
    [Documentation]    Owner: Nakarin
    ...    Receive [Argument] for check type of Variable then return type of Variable as Sting
    [Tags]    keyword_action
    [Arguments]    ${var}
    ${type}    Evaluate    type($var)
    Log    ${type}
    [Return]    ${type}

Get Access Token ClientCredential
    [Documentation]    Editor: Nakarin
    ...    Get Access Token of Client Credential then Set Test Variable ${ACCESS_TOKEN_CLIENTCREENTIAL}
    [Tags]    keyword_communicate
    Set Content Header Client Credentials    ${url_client_credentials_${test_site}}
    ...                                      ${content_type_x_www}
    Set Body Client Credentials    ${client_id_OhFw3u_browser}
    ...                            ${client_secret_id_OhFw3u_browser}
    ...                            ${grant_type}
    ...                            ${nonce}
    Send Request Client Credentials
    Log    ${RESPONSE.json()}[access_token]
    Set Test Variable    ${ACCESS_TOKEN_CLIENTCREDENTIAL}    ${RESPONSE.json()}[access_token]

Set Body Validate Token Test
    [Documentation]     Owner : sasipen
    ...    Set client id,grant type, nonce to formate body
    [Arguments]              ${client_id}      ${value}    ${nonce}
    ${body_client_id}        Replace String    ${API_BODY}          _client_id_    ${client_id}
    ${body_value}            Replace String    ${body_client_id}    _value_        ${value}
    ${body_api}              Replace String    ${body_value}        _nonce_        ${nonce}
    Log    ${body_api}
    Set Test Variable        ${API_BODY}       ${body_api}