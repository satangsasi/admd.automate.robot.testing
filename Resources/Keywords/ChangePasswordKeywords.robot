*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Fill Username And Password Login Page Change Password
    [Documentation]    Owner: sasipen
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text    ${txt_username_changepassword}    ${user_login_changepassword}    delay=0.1s
    Type Text    ${txt_password_changepassword}    ${pass_login_changepassword}    delay=0.1s
    Set Test Provisioning Data   Username: ${user_login_changepassword}
    Set Test Provisioning Data   Password: ${pass_login_changepassword}

Click Login Button In Login Page Change Password
    [Documentation]    Owner: sasipen
    [Tags]    Keyword_communicate
    Click    ${btn_login_changepassword} 
    [Arguments]

Set API Header Change Password
    [Documentation]    Owner: sasipen
    ...    Set API Header for send request of Change Password With Msisdn Password
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_x_www}    append=False
    Set Content API Header    key=${header_x_tid}           value=ADMD-200924iJ6cngst8Oa
    Log    ${API_HEADER}

Set API Body Change Password With Msisdn Password
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Change Password With Msisdn Password
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    access_token
    Set Schema API Body        ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_msisdn} 
    Set Content API Body    $..new_password    ${new_password_msisdn}     
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_misdn}
    Set Content API Body    $..client_id       ${client_id_changepassword_FCoRIg}
    Set Content API Body    $..redirect_uri    ${redirect_uri_changepassword} 
    Set Content API Body    $..state           ${state_success_changepassword_msisdn}
    Set Content API Body    $..nonce           ${DATE_TIME}

Send Post Request Change Password
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    url=${url_changepassword}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    Request Change Password With Msisdn Password : ${message}[request]
    Set Test Actual Result        Request Change Password With Msisdn Password : ${message}[response]

Verify Response Change Password With Msisdn Password
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    state    ${state_success_changepassword_msisdn} 

Set API Body Change Password With Ldap Content Provider
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Change Password With Ldap Content Provider
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    access_token
    Set Schema API Body        ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider}    
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_changepassword_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_changepassword} 
    Set Content API Body    $..state           ${state_success_changepassword_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Ldap Content Provider
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    state    ${state_success_changepassword_ldapcp} 

Set API Body Change Password Invalid Old Password
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Change Password Invalid Old Password
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    access_token
    Set Schema API Body        ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider_invalid}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider}    
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_changepassword_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_changepassword} 
    Set Content API Body    $..state           ${state_success_changepassword_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Send Post Request Change Password Invalid
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
     [Arguments]        ${status_code}
    &{message}    Send Request    POST    url=${url_changepassword}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Request Change Password Invalid Old Password : ${message}[request]
    Set Test Actual Result        Request Change Password Invalid Old Password : ${message}[response]

Verify Response Change Password Invalid Old Password
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    error    ${error_message_invalid_user_or_password}
    Verify Value Response By Key    state    ${state_success_changepassword_ldapcp} 

Set API Body Change Password Invalid New Password Contains Thai character
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Change Password Invalid Old Password
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    access_token
    Set Schema API Body        ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider_invalid_th_lang}
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_changepassword_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_changepassword} 
    Set Content API Body    $..state           ${state_success_changepassword_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password Invalid New Password Contains Thai character
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    error    ${error_message_invalid_request} 
    Verify Value Response By Key    state    ${state_success_changepassword_ldapcp} 

Set API Body Change Password Invalid New Password Contains Special Character
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Change Password Invalid Old Password
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    access_token
    Set Schema API Body        ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider_invalid_&}
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_changepassword_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_changepassword} 
    Set Content API Body    $..state           ${state_success_changepassword_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password Invalid New Password Contains Special Character
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    error    ${error_message_invalid_request} 
    Verify Value Response By Key    state    ${state_success_changepassword_ldapcp} 

Set API Body Change Password Invalid Access Toekn Expired
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Change Password Invalid Access Toekn Expired
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body        ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider} 
    Set Content API Body    $..access_token    ${expired_access_token_changepassword}  
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_changepassword_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_changepassword} 
    Set Content API Body    $..state           ${state_success_changepassword_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password Invalid Access Toekn Expired
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    error    ${error_message_invalid_grant}
    Verify Value Response By Key    state    ${state_success_changepassword_ldapcp} 