*** Settings ***
Resource    ../../TestSuite/Resource_init.robot


*** Keywords ***
Fill Username And Password Login Page Change Password
    [Documentation]    Owner: sasipen
    ...    Website can detect character while typing
    [Tags]    Keyword_communicate
    Type Text    ${txt_username_change_password}    ${user_login_change_password}    delay=0.1s
    Type Text    ${txt_password_change_password}    ${pass_login_change_password}    delay=0.1s
    Set Test Provisioning Data   Username: ${user_login_change_password}
    Set Test Provisioning Data   Password: ${pass_login_change_password}

Press Login Button In Login Page Change Password
    [Documentation]    Owner: sasipen
    [Tags]    Keyword_communicate
    Click    ${btn_login_change_password}

Set API Header Change Password
    [Documentation]    Owner: sasipen
    ...    Set API Header for send request of Change Password With Msisdn Password
    [Tags]    keyword_communicate
    Set Content API Header    key=${header_content_type}    value=${content_type_x_www}    append=False
    Set Content API Header    key=${header_x_tid}           value=ADMD-200924iJ6cngst8Oa
    Log    ${API_HEADER}

Set API Body Change Password With Msisdn Password
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Change Password With Msisdn Password
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_msisdn} 
    Set Content API Body    $..new_password    ${new_password_msisdn}     
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_misdn}
    Set Content API Body    $..client_id       ${client_id_change_password_FCoRIg}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_msisdn}
    Set Content API Body    $..nonce           ${DATE_TIME}
    
Verify Value Login Subtype By Key
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    ${actual_value_id_token}    Get Value Response On Web Page By Key    $..id_token
    ${jwt_decode}    Jwt Decode      ${actual_value_id_token}
    Verify Value Json By Key    ${jwt_decode}    $..aut.login_subtype    ${expected_value_login_subtype_cp}           

Send Post Request Change Password
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    &{message}    Send Request    POST    url=${url_change_password}    headers=${API_HEADER}    body=${API_BODY}
    Set Test Provisioning Data    Request Change Password With Msisdn Password : ${message}[request]
    Set Test Actual Result        Request Change Password With Msisdn Password : ${message}[response]

Verify Response Change Password With Msisdn Password
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..state    ${state_success_change_password_msisdn} 

Set API Body Change Password With Ldap Content Provider
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Change Password With Ldap Content Provider
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider}    
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_change_password_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Ldap Content Provider
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..state    ${state_success_change_password_ldapcp} 

Set API Body Change Password With Ldap Invalid Old Password
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Change Password Invalid Old Password
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider_invalid}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider}    
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_change_password_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Send Post Request Change Password Invalid
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    [Arguments]        ${status_code}
    &{message}    Send Request    POST    url=${url_change_password}     headers=${API_HEADER}    body=${API_BODY}    expected_status=${status_code}
    Set Test Provisioning Data    Request Change Password Invalid : ${message}[request]
    Set Test Actual Result        Request Change Password Invalid : ${message}[response]

Verify Response Change Password With Ldap Invalid Old Password
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..error    ${error_message_invalid_user_or_password}
    Verify Value Response By Key    $..state    ${state_success_change_password_ldapcp} 

Set API Body Change Password With Ldap Invalid New Password Contains Thai Character
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Change Password Invalid Old Password
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_invalid_th_lang}
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_change_password_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Ldap Invalid New Password Contains Thai Character
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..error    ${error_message_invalid_request} 
    Verify Value Response By Key    $..state    ${state_success_change_password_ldapcp} 

Set API Body Change Password With Ldap Invalid New Password Contains Special Character
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Change Password New Password Contains Special Character
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_invalid_special_character}
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_change_password_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Ldap Invalid New Password Contains Special Character
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..error    ${error_message_invalid_request} 
    Verify Value Response By Key    $..state    ${state_success_change_password_ldapcp} 

Set API Body Change Password With Ldap Invalid Access Token Expired
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Change Password Invalid Access Token Expired
    [Tags]    keyword_communicate
    Get Time Nonce
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_ldap_content_provider}
    Set Content API Body    $..new_password    ${new_password_ldap_content_provider} 
    Set Content API Body    $..access_token    ${expired_access_token_change_password}  
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_change_password_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_ldapcp}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Ldap Invalid Access Token Expired
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..error    ${error_message_invalid_grant}
    Verify Value Response By Key    $..state    ${state_success_change_password_ldapcp} 

Set API Body Change Password With Msisdn Invalid Old Password
    [Documentation]    Owner: sasipen
    ...    Set API Body for send request of Change Password With Msisdn Invalid Old Password 
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_msisdn_invalid}
    Set Content API Body    $..new_password    ${new_password_msisdn}     
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_misdn}
    Set Content API Body    $..client_id       ${client_id_change_password_FCoRIg}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_msisdn}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Msisdn Invalid Old Password
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..error    ${error_message_invalid_user_or_password}
    Verify Value Response By Key    $..state    ${state_success_change_password_msisdn}

Set API Body Change Password With Msisdn Invalid New Password Contains Thai Character
    [Documentation]    Owner: Nakarin
    ...    Set API Body for send request of Change Password With Msisdn Invalid New Password Contains Thai Character
    [Tags]    keyword_communicate
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body     ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_msisdn_invalid}
    Set Content API Body    $..new_password    ${new_password_invalid_th_lang}  
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_misdn}
    Set Content API Body    $..client_id       ${client_id_change_password_FCoRIg}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password} 
    Set Content API Body    $..state           ${state_success_change_password_msisdn}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Msisdn Invalid New Password Contains Thai Character
    [Documentation]    Owner: sasipen
    [Tags]    keyword_communicate
    Verify Value Response By Key    $..error    ${error_message_invalid_request}
    Verify Value Response By Key    $..state    ${state_success_change_password_msisdn}

Set API Body Change Password With Msisdn New Password Contains Special Character
    [Documentation]     Owner: Atitaya
    [Tags]
    Get Time Nonce
    ${actual_value_access_token}    Get Value Response On Web Page By Key    $..access_token
    Set Schema API Body        ${body_change_password_schema}
    Set Content API Body    $..old_password    ${old_password_msisdn}
    Set Content API Body    $..new_password    ${new_password_invalid_special_character} 
    Set Content API Body    $..access_token    ${actual_value_access_token}
    Set Content API Body    $..type            ${type_ldap}
    Set Content API Body    $..client_id       ${client_id_change_password_X6jpUV}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password}
    Set Content API Body    $..state           ${state_success_change_password_msisdn}
    Set Content API Body    $..nonce           ${DATE_TIME}   

Verify Response Change Password With Msisdn Invalid New Password Contains Special Character
    [Documentation]     Owner: Atitaya
    [Tags]
    Verify Value Response By Key    $..error    ${error_message_invalid_request} 
    Verify Value Response By Key    $..state    ${state_success_change_password_msisdn}        

Set API Body Change Password With Msisdn Invalid Access Token Expired    
    [Documentation]     Owner: Atitaya
    [Tags]
    Get Time Nonce
    Set Schema API Body        ${body_change_password_schema}  
    Set Content API Body    $..old_password    ${old_password_msisdn}
    Set Content API Body    $..new_password    ${new_password_msisdn}
    Set Content API Body    $..access_token    ${expired_access_token_change_password}  
    Set Content API Body    $..type            ${type_misdn} 
    Set Content API Body    $..client_id       ${client_id_change_password_FCoRIg}
    Set Content API Body    $..redirect_uri    ${redirect_uri_change_password}
    Set Content API Body    $..state           ${state_success_change_password_msisdn}
    Set Content API Body    $..nonce           ${DATE_TIME}

Verify Response Change Password With Msisdn Invalid Access Token Expired
    [Documentation]     Owner: Atitaya
    [Tags]
    Verify Value Response By Key    $..error    ${error_message_invalid_grant}
    Verify Value Response By Key    $..state    ${state_success_change_password_msisdn}    