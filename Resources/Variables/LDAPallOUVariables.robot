*** Variables ***
${url_authentication}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${user_provider}         425
${pass_provider}         password
${user_employee}         nopparar
${pass_employee}         Nop#3246@Stg!

${url_get_token_schema}         https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&code=_code_
${url_get refresh_token_schema}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&client_secret=clientSecret&grant_type=refresh_token&redirect_uri=https://www.ais.co.th/&code=_code_

# Error Message
${error_title}           Wrong Username or Password
${error_message}         Please check your Username or Password.

