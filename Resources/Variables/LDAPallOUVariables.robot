*** Variables ***
${user_ldap_provider}         425
${pass_ldap_provider}         password
${user_ldap_employee}         nopparar
${pass_ldap_employee}         Nop#3246@Stg!
&{authentication_ldap}        user=425

# Url
${url_authentication_ldap_dev}                    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_authentication_ldap_iot}                    https://iot-apivr.ais.co.th/auth/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_authentication_miss_parameter_ldap_dev}     https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_get_token_schema}                       https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=_code_
${url_authentication_ldap_scope_profile}      https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/&scope=profile 
${url_authentication_ldap_no_scope_profile}   https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${url_get_refresh_token_schema_iot}    https://iot-apivr.ais.co.th/auth/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=refresh_token&redirect_uri=https://www.ais.co.th/&code=_code_
${url_get_refresh_token_schema_dev}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=refresh_token&redirect_uri=https://www.ais.co.th/&code=_code_
${url_ldap_logout_dev}                https://iot-apivr.ais.co.th/authtest/v3.2/logout
${url_ldap_logout_iot}                https://iot-apivr.ais.co.th/auth/v3.2/logout

# header
${header_ldap_schema}                   {"Content-Type": "_Content-Type_"}

# body
${body_ldap_schema}                     {"access_token": "_access_token_", "state": "_state_"} 
${state_logout_ldap_cp}                 Logout with Ldap CP (1.9)
${state_logout_ldap_cp_sso}             Logout with Ldap CP (1.9) (SSO)   


# Error Message
${error_title}           Wrong Username or Password
${error_message}         Please check your Username or Password.
