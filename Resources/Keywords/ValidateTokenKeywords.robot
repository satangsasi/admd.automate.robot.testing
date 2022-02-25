*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Set Content API Header
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_command
    [Arguments]    ${key}    ${value}    ${append}=True    ${schema_path}=${null}
    # IF    ${append} == False and ${schema_path} != ${null}
    #     ${API_HEADER}    OperatingSystem.Get File    ${schema_path}
    # END
    ${status}    Run Keyword And Return Status    Variable Should Exist    ${API_HEADER}
    IF  ${status} == True and ${append} == True
        ${header}    Set Variable    ${API_HEADER}
    ELSE
        ${header}    Create Dictionary
    END
    Set To Dictionary    ${header}    ${key}=${value}
    Log  ${header}
    Set Test Variable    ${API_HEADER}    ${header}

Get API Body From Json File 
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_command
    [Arguments]    ${path}
    ${json_string}    OperatingSystem.Get File             ${path}
    ${json_object}    Convert Variable Type To Dot Dict    ${json_string}
    Check Variable Type    ${json_object}
    Log    ${json_object}
    [Return]    ${json_object}

Set API Header Login By Client Credential
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Set Content API Header    key=Content-Type    value=application/json    append=False
    Set Content API Header    key=X-Tid           value=login by client credentials
    Log    ${API_HEADER}
    Check Variable Type    ${API_HEADER}

Set API Body Login By Client Credential
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    ${json}    Get API Body From Json File        ${body_validate_token_schema}
    Set To Dictionary    ${json}        client_id=${clientid_validate_token}
    Set To Dictionary    ${json.token}      value=${ACCESS_TOKEN_CLIENTCREDENTIAL}
    Log    ${json}
    ${json_string}    Convert To String    ${json}
    ${string}    Remove String    ${json_string}    ${\n}
    Log    ${string}
    # Set Test Variable    ${API_BODY}    ${json}
    Set Test Variable    ${API_BODY}    ${string}
    Check Variable Type  ${API_BODY}

Send Post Request Validate Token
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_communicate
    Send Post Request    ${url_validate_token}    headers=${API_HEADER}    body=${API_BODY}

Check Variable Type
    [Documentation]    Owner: Nakarin
    [Tags]    keyword_action
    [Arguments]    ${var}
    ${type}    Evaluate    type($var)
    Log    ${type}

Get Access Token ClientCredential
    [Documentation]    Editor: Nakarin
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