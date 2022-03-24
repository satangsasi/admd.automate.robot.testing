*** Variables ***
# User Provider
${user_ldap_provider}            425
${pass_ldap_provider}            password1
${invalid_user_ldap_provider}    426
${invalid_pass_ldap_provider}    password425

# User Employee 
${user_ldap_employee}            nopparar
${pass_ldap_employee}            Nop#3246@Stg!
${invalid_user_ldap_employee}    noppararhhh
${invalid_pass_ldap_employee}    Nop#3246@Stg!sss

# Header
${header_ldap_schema}    {"Content-Type": "_Content-Type_"}

# Body
${body_ldap_schema}            {"access_token": "_access_token_", "state": "_state_"} 
${state_logout_ldap_cp}        Logout with Ldap CP (1.9)
${state_logout_ldap_cp_sso}    Logout with Ldap CP (1.9) (SSO)   
${state_logout_ldap_employee}        Logout with Ldap Employee (1.9)
${state_logout_ldap_employee_sso}    Logout with Ldap Employee (1.9) (SSO)
# Response
${expected_expires_in_ldap}                           86400
${expected_refresh_token_expires_in_ldap}             86400
${expected_action_refresh}                            refresh
${expected_value_login_subtype_cp}                    ldapCp
${expected_value_login_subtype_employee}              ldapEmployee
${expected_action_login}                              login
${expected_action_sso}                                sso
${expected_result_code_pass}                          20000
${expected_develope_message_pass}                     success
${expected_private_id_cp_pass}                        PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELW9sWXJBNTdHMHEvU0FGWFZ3SlQ1SFE9PQ==1111111111111
${expected_private_id_emp_pass}                       PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELUtoNXhuMlhGdmFEd0FJdTRVNjVJQVE9PQ==1111111111111
${expected_partner_id_pass}                           30238
${expected_public_id_emp_pass}                        nopparar
${expected_public_id_cp_pass}                         425
