*** Variables ***
# User Provider
${user_ldap_provider}            425
${pass_ldap_provider}            password
${invalid_user_ldap_provider}    426
${invalid_pass_ldap_provider}    password425

# User Employee 
${user_ldap_employee}            nopparar
${pass_ldap_employee}            Nop#3246@Stg!
${invalid_user_ldap_employee}    noppararhhh
${invalid_pass_ldap_employee}    Nop#3246@Stg!sss

# Url Content Provider
${url_auth_ldap_dev}                      https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_auth_ldap_iot}                      https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_auth_miss_parameter_ldap_dev}       https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_client_secret_no_match_ldap_dev}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=51R98t28kK1JJs1iFOXvy2l5jj0dVBWqCeGPmpFDCICk
${url_invalid_client_secret_ldap_dev}     https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientt&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=sUzaI0YmAtQM60qG7152o51X3ji0o30RpvdR018u5e5W
${url_get_token_schema}                   https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=_code_

${url_auth_ldap_scope_profile}            https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/&scope=profile 
${url_auth_ldap_no_scope_profile}         https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_get_refresh_token_schema_dev}       https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=refresh_token&redirect_uri=https://www.ais.co.th/&code=_code_
${url_get_refresh_token_schema_iot}       https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=refresh_token&redirect_uri=https://www.ais.co.th/&code=_code_
${url_ldap_logout_dev}                    https://iot-apivr.ais.co.th/authtest/v3.2/logout
${url_ldap_logout_iot}                    https://iot-apivr.ais.co.th/auth/v3.2/logout
${url_decrypted_ldap_content_provider_snake_case}    http://10.137.30.22:31191/v3.2/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELW9sWXJBNAYq+94RTdHMHEvU0FGWFZ3SlQ1SFE9PQ==gvH4=&05
${url_decrypted_ldap_content_provider_camel_case}    http://10.137.30.22:31191/v3.1/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELW9sWXJBNAYq+94RTdHMHEvU0FGWFZ3SlQ1SFE9PQ==gvH4=&05
                                               
#Url Employee                                    
${url_auth_ldap_employee_dev}                 https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&redirect_uri=https://www.ais.co.th/   
${url_auth_ldap_employee_iot}                 https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&redirect_uri=https://www.ais.co.th/   
${url_auth_ldap_employee_no_scope_profile}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&redirect_uri=https://www.ais.co.th/
${url_decrypted_ldap_employee_snake_case}     http://10.137.30.22:31191/v3.2/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELUtoNXhuMAYq+94RlhGdmFEd0FJdTRVNjVJQVE9PQ==gvH4=&05
${url_decrypted_ldap_employee_camel_case}     http://10.137.30.22:31191/v3.1/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELUtoNXhuMAYq+94RlhGdmFEd0FJdTRVNjVJQVE9PQ==gvH4=&05




# Header
${header_ldap_schema}    {"Content-Type": "_Content-Type_"}

# Body
${body_ldap_schema}            {"access_token": "_access_token_", "state": "_state_"} 
${state_logout_ldap_cp}        Logout with Ldap CP (1.9)
${state_logout_ldap_cp_sso}    Logout with Ldap CP (1.9) (SSO)   

# Error Message
${error_title}                           Wrong Username or Password
${error_message}                         Please check your Username or Password.
${json_error_message_invalid_grant}      {"error":"invalid_grant"}
${json_error_message_invalid_request}    {"error":"invalid_request"}

# Response
${expected_expires_in_ldap}                           86400
${expected_refresh_token_expires_in_ldap}             86400
${expected_action_refresh}                            refresh
${expected_value_login_subtype_cp}                    ldapCp
${expected_value_login_subtype_employee}              ldapEmployee
${expected_action_login}                              login
${expected_action_sso}                                sso
${expected_result_code_pass}                          20000
${expected_develope_messagee_pass}                    success
${expected_private_id_pass}                           PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELUtoNXhuMlhGdmFEd0FJdTRVNjVJQVE9PQ==1111111111111
${expected_partner_id_pass}                           30238
${expected_public_id_emp_pass}                        nopparar
${expected_public_id_cp_pass}                         425

