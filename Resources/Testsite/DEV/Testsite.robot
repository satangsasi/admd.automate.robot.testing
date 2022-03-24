*** Variables ***
&{proxy_api}   http=http://10.137.18.77:80    https=http://10.137.18.77:80
${proxy_ui}    {'server': 'http://10.137.18.77:80'}
# ClientCredential
${url_client_credentials}                     ${url_iot_apivr}/authtest/v3.2/oauth/token
${url_client_credentials_invalid}             ${url_iot_apivr}/authtest/v3.2/oauth/tokennnnnn

# EmailOTP
${url_request_email_otp}          http://10.137.30.22:31191/v3.2/otp/request?tid=ADMD1234
${url_get_token_email_otp}        http://10.137.30.22:31191/v3.2/oauth/token   


# ValidateToken
${url_login_by_fbb}                          ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_for_token_validate_token}              ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&client_secret=adfea93d79e56e5219eccd63cc884ae3&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&lang=eng&code=_code_

${url_validate_token}                        http://10.137.30.22:31191/v3.2/token/validate
${url_request_otp_validate_token}            http://10.137.30.22:31191/v3.2/otp/request?tid=ADMD1234
${url_get_token_validate_token}              http://10.137.30.22:31191/v3.2/oauth/token
${url_delete_sub_scriber}                    http://10.138.36.227:9600/v1/method/deleteSubscriber.json

# ChangePassword
${url_login_change_password}                   ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_change_password_schema}        ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&code=_code_&redirect_uri=https://www.ais.co.th/
${url_change_password}                         ${url_iot_apivr}/authtest/v3.2/changepassword


# LDAPallOU
# Url Content Provider
${url_auth_ldap}                          ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_auth_miss_parameter_ldap}       ${url_iot_apivr}/authtest/v3.2/oauth/authorize?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_client_secret_no_match_ldap}    ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=51R98t28kK1JJs1iFOXvy2l5jj0dVBWqCeGPmpFDCICk
${url_invalid_client_secret_ldap}     ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientt&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=sUzaI0YmAtQM60qG7152o51X3ji0o30RpvdR018u5e5W
${url_get_token_schema}                   ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=_code_
${url_auth_ldap_scope_profile}            ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/&scope=profile 
${url_auth_ldap_no_scope_profile}         ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_get_refresh_token_schema}           ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=refresh_token&redirect_uri=https://www.ais.co.th/&code=_code_
${url_ldap_logout}                        ${url_iot_apivr}/authtest/v3.2/logout
${url_decrypted_ldap_content_provider_snake_case}    http://10.137.30.22:31191/v3.2/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELW9sWXJBNAYq+94RTdHMHEvU0FGWFZ3SlQ1SFE9PQ==gvH4=&05
${url_decrypted_ldap_content_provider_camel_case}    http://10.137.30.22:31191/v3.1/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELW9sWXJBNAYq+94RTdHMHEvU0FGWFZ3SlQ1SFE9PQ==gvH4=&05

# Url Employee                                    
${url_auth_ldap_employee}                 ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&redirect_uri=https://www.ais.co.th/   
${url_auth_ldap_employee_no_scope_profile}    ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&redirect_uri=https://www.ais.co.th/
${url_decrypted_ldap_employee_snake_case}     http://10.137.30.22:31191/v3.2/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELUtoNXhuMAYq+94RlhGdmFEd0FJdTRVNjVJQVE9PQ==gvH4=&05
${url_decrypted_ldap_employee_camel_case}     http://10.137.30.22:31191/v3.1/partnerSpecificPrivateIds/PQnds4&R2RkeTl1SlFqRXJiOGIxMS1BRE1ELUtoNXhuMAYq+94RlhGdmFEd0FJdTRVNjVJQVE9PQ==gvH4=&05
${url_for_logout_ldap_employee}               http://10.137.30.22:31191/v3.2/logout

# FBBOTP
${url_auth_fbb}                         ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_fbb_client_no_match}    ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&client_secret=a67dd929a935d9bdd70c0845f7a5dbe5&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&lang=eng&code=_code_

# Forgot password
${url_auth_forgot_pw_email}         ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=WtAQw3cFTOCkQ3xTqRQTMhI4AzthwoT67oTPgwM7oUU%3D&lang=eng&redirect_uri=https://www.ais.co.th/
${url_get_token_forgot_pw_email}    ${url_iot_apivr}/authtest/v3.2/oauth/token?client_id=WtAQw3cFTOCkQ3xTqRQTMhI4AzthwoT67oTPgwM7oUU%3D&client_secret=clientSecret&grant_type=authorization_code&code=_code_&redirect_uri=https://www.ais.co.th/&scope=profile
${url_forgot_pw}                    ${url_iot_apivr}/authtest/v3.2/oauth/authorize?response_type=code&client_id=WtAQw3cFTOCkQ3xTqRQTMhI4AzthwoT67oTPgwM7oUU%3D&redirect_uri=https://www.ais.co.th/&lang=eng

# FBB_nowebview
${url_fbb_nowebview}              http://10.137.30.22:31191/v3.2/otp/request?tid=ADMD1234
${url_get_token_fbb_nowebview}    http://10.137.30.22:31191/v3.2/oauth/token