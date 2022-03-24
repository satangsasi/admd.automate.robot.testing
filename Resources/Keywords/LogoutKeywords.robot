*** Settings ***
Resource    ../../TestSuite/Resource_init.robot

*** Keywords ***
Set Body Ldap Logout With Client Id
    [Documentation]     Owner : sasipen
    ...   Append value By Key access token to set body schema state logout 
    ...   Set url to global for create provisioning data
    Set Content API Body    $..access_token       ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}    append=False
    Set Content API Body    $..client_id          ${client_id_X6jpU}     
    Set Content API Body    $..state              ${state_logout_ldap_employee}

Set Body Ldap Logout With Invalid Client Id
    [Documentation]     Owner : sasipen
    ...   Append value By Key access token to set body schema state logout 
    ...   Set url to global for create provisioning data
    Set Content API Body    $..access_token       ${VALUE_ACCESS_TOKEN_FOR_LOGOUT}    append=False
    Set Content API Body    $..client_id          ${invalid_client_id_PK+WUA}     
    Set Content API Body    $..state              ${state_logout_ldap_employee}