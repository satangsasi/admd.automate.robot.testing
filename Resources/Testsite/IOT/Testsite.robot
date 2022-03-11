*** Variables ***
#ClientCredential
${url_client_credentials}                         https://iot-apivr.ais.co.th/auth/v3.2/oauth/token
${url_client_credentials_invalid}                 https://iot-apivr.ais.co.th/auth/v3.2/oauth/tokennnnnn

#EmailOTP


#ValidateToken
${url_login_by_fbb}                          https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_for_token_validate_token}              https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&client_secret=adfea93d79e56e5219eccd63cc884ae3&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&lang=eng&code=_code_


#ChangePassword
${url_login_changepassword}                   https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_changepassword_schema}        https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&code=_code_&redirect_uri=https://www.ais.co.th/
${url_changepassword}                         https://iot-apivr.ais.co.th/auth/v3.2/changepassword


#LDAPallOU
#Url Content Provider
${url_auth_ldap}                          https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_auth_miss_parameter_ldap_dev}       https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_client_secret_no_match_ldap_dev}    https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=51R98t28kK1JJs1iFOXvy2l5jj0dVBWqCeGPmpFDCICk
${url_invalid_client_secret_ldap_dev}     https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientt&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=sUzaI0YmAtQM60qG7152o51X3ji0o30RpvdR018u5e5W
${url_get_token_schema}                   https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=_code_
${url_auth_ldap_scope_profile}            https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/&scope=profile 
${url_auth_ldap_no_scope_profile}         https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_get_refresh_token_schema}           https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=refresh_token&redirect_uri=https://www.ais.co.th/&code=_code_
${url_ldap_logout}                        https://iot-apivr.ais.co.th/auth/v3.2/logout
#Url Employee                                    
${url_auth_ldap_employee_dev}                 https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&redirect_uri=https://www.ais.co.th/   
${url_auth_ldap_employee_no_scope_profile}    https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&redirect_uri=https://www.ais.co.th/


#FBBOTP
${url_auth_fbb}         https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_fbb}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&client_secret=adfea93d79e56e5219eccd63cc884ae3&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&lang=eng&code=_code_