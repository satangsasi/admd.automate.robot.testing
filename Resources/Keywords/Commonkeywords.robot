*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Append To Document Teardown
    [Documentation]    Owner: Nakarin
    ...    Create Document of Provisioning Data(in order list) and Actual Result
    [Tags]    keyword_communicate
    # Set Test Provisioning Data    Request ${TYPE_REQUEST} : ${API_URL}
    # Set Test Provisioning Data    Header : ${API_HEADER}
    # Set Test Provisioning Data    Body : ${API_BODY}
    Set Test Provisioning Data    User : ${USER}
    Set Test Provisioning Data    Password : ${PASS}
    # Set Test Provisioning Data    Authentication URL : ${URL_AUTH}
    Set Test Provisioning Data    Get Token URL : ${URL_GET_TOKEN}
    Set Test Provisioning Data    Get Refresh Token URL : ${URL_GET_REFRESH_TOKEN}
    Set Test Documentation Detail
    
SSH Connect To Server Log
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...    Connected to 10.137.30.22
    ...    *** Variables ***
    ...    ${ssh_ip_address}    10.137.30.22
    ...    ${ssh_user}          serveradm
    ...    ${ssh_pass}          R3dh@t!@#
    [Tags]    keyword_action
    Open Connection    ${ssh_ip_address}    prompt=$    timeout=30
    ${login_log}    Login    ${ssh_user}     ${ssh_pass}
    Log    ${login_log}
    
Change Directory Path To Get Log
    [Documentation]    Owner: Nakarin
    ...    Change to get log directory although old path was change - (deployed)
    ...    [Return] the admd path to get log with grep
    [Tags]    keyword_action
    Write    kubectl get pod -n admd
    ${output}          Read    delay=1s
    Log    ${output}
    @{output_line}     Split To Lines        ${output}
    @{kubectl_path}    Get Regexp Matches    ${output_line}[-2]    (\\w\\S+)
    Log Many    @{kubectl_path}
    Should Contain    ${kubectl_path}[0]    admd    msg=Can't get any item with 'kubectl get pod -n admd' command    values=False
    # Write    reset
    # Read     delay=1s    # Wait for screen reset
    Write    kubectl exec -it ${kubectl_path}[0] -n admd sh
    Write    cd logs/detail/
    Write    ls -lrt | tail
    ${output}      Read    delay=2s
    Log    ${output}
    @{output_line}    Split To Lines        ${output}
    @{cat_path}       Get Regexp Matches    ${output_line}[-2]    (\\w\\S+)
    # Write    reset
    # Read     delay=1s    # Wait for screen reset
    Log Many    @{cat_path}
    Should Contain    ${cat_path}[-1]    admd.0.detail    msg=Can't get "${kubectl_path}[0].admd.0.detail" with 'kubectl exec -it ${kubectl_path}[0] -n admd sh' command    values=False
    [Return]    ${cat_path}[-1]

Get OTP Password From Json
    [Documentation]    Owner: Nakarin    Editor: Sasipen
    ...     Get OTP Value from Json that return from SSH Command
    [Tags]    keyword_action
    [Arguments]    ${json_log}
    ${otp_password}        Get Value Json By Key    ${json_log}    custom.Input[0].Data.Body.sendOneTimePWResponse.oneTimePassword
    Should Match Regexp    ${otp_password}    \\d+    msg=Can't get OTP Password
    Log         ${otp_password}
    [Return]    ${otp_password}

Create Browser Session
    [Documentation]     Owner : sasipen
    ...    Setting browser and open url 
    ...    Set url to global for create provisioning data
    [Arguments]    ${url}
    Set Up Browser Fullscreen    browser=chromium    headless=False
    New Page       ${url}
    Set Test Provisioning Data    Authentication URL : ${url}
    Wait Until Network Is Idle

Verify Dictionary Value By Key
    [Documentation]    Owner: Nakarin
    ...    Support both variable type of dot.dict and dict
    ...    $dictionary is dictionary variable
    ...    $key is key to find value in dictionary
    ...    $expected_value is value that used for verify value in key
    ...    $msg is the name of dictionary/object
    [Arguments]    ${dictionary}    ${key}    ${expected_value}    ${msg}=$..
    [Tags]    keyword_command
    ${type}    Check Variable Type    ${dictionary}
    IF    "${type}" != "<class 'robot.utils.dotdict.DotDict'>"
        &{dict}    Convert Variable Type To Dot Dict    ${dictionary}
    ELSE
        &{dict}    Set Variable    ${dictionary}
    END
    ${key}        Remove String      ${key}    $..
    ${value}      Set Variable       ${dict.${key}}
    ${message}    Set Variable If   '${msg}' != '$..'    '${msg}':{'${key}':'${value}'}    ${msg}{'${key}':'${value}'}
    ${keyword_compare}    Check Compare Type    ${value}    ${expected_value}
    Run Keyword    ${keyword_compare}    ${value}    ${expected_value}    values=False
    ...    msg=Actual Value '${value}' of key '$..${key}' was not match expect value '${expected_value}'
    Log   ${message}

Create URL For Get Token
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Append Token(get from Auth Url) to get Token(API) Url
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    [Arguments]    ${url_for_get_token}
    Get Code From Authentication
    ${url_get_token}     Replace String      ${url_for_get_token}    _code_    ${CODE}
    Set Test Variable    ${URL_GET_TOKEN}    ${url_get_token}
    Set Test Provisioning Data    Get Token URL: ${url_get_token}
    
Get Code From Authentication
    [Documentation]     Owner : sasipen    Editor: Nakarin
    ...    Get Code Token From Url Then Return to Set Test Variable ${CODE}
    ...    ***Editor Note***
    ...    - Add Set Test Variable (Provisioning Data)
    ...    - Add Set Test Provisioning Data   
    ${url_auth_access}    Wait Until Keyword Succeeds    ${verify_timeout}      10ms    Get Url    matches    .*code=
    ${code}    Split String         ${url_auth_access}    =
    ${code}    Set Variable         ${code}[1]
    Set Test Provisioning Data    Authenticate URL: ${url_auth_access}
    Set Test Provisioning Data    Authentication Code: ${code}
    Set Test Variable    ${CODE}    ${code}

Set Response On Webpage To Json
    [Documentation]     Owner : sasipen
    ...    Get text form webpage and change it to json message Then Return to &{RESPONSE_JSON_MESSAGE}
    ${message}           Get Text    ${lbl_json_response_on_webpage}
    &{json_message}      Evaluate    json.loads('''${message}''')    json
    Log Many             &{json_message}
    Set Test Variable    &{RESPONSE_JSON_MESSAGE}    &{json_message}
    Take Screenshot Verify Success Scene
    Set Test Provisioning Data    Access Token: ${RESPONSE_JSON_MESSAGE.access_token}
    Set Test Provisioning Data    ID Token: ${RESPONSE_JSON_MESSAGE.id_token}

Get Value Response On Web Page By Key
    [Documentation]     Owner : sasipen
    ...    Get value from key in &{RESPONSE_JSON_MESSAGE} Then Return to value
    [Arguments]    ${response_key}
    ${value}       Set Variable    ${RESPONSE_JSON_MESSAGE.${response_key}}
    [Return]       ${value}