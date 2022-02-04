*** Variables ***
${url_authentication}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=X6jpUVHVBdszLACYucu%2BmkslzsMyXhwQNG%2Fp1jO1KXg%3D&scope=profile&template_name=index_ldap_cp&redirect_uri=https://www.ais.co.th/
${user_provider}         425
${pass_provider}         password
${user_employee}         nopparar
${pass_employee}         Nop#3246@Stg!
# Error Message
${error_title}           Wrong Username or Password
${error_message}         Please check your Username or Password.