*** Variables ***
#url
${url_login_changepassword}                   https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_changepassword_schema}        https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&code=_code_&redirect_uri=https://www.ais.co.th/
${url_changepassword}                         https://iot-apivr.ais.co.th/authtest/v3.2/changepassword
${redirect_uri_changepassword}                https://www.ais.co.th/
#data
${user_login_changepassword}       0981721044
${pass_login_changepassword}       12345678
${old_password_msisdn}             12345678
${new_password_msisdn}             12345678
${old_password_ldap_content_provider}    password1
${new_password_ldap_content_provider}    password1
${type_misdn}                            msisdn
${type_ldap}                             ldap
${client_id_changepassword_FCoRIg}       FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays+mTxG9/xpwVZQ+Eg==
${client_id_changepassword_X6jpUV}       X6jpUVHVBdszLACYucu+mkslzsMyXhwQNG/p1jO1KXg=
${state_success_changepassword_msisdn}   Changepassword_success_Msisdn
${state_success_changepassword_ldapcp}   Changepassword_success_LdapCp
${old_password_ldap_content_provider_invalid}    password111
${new_password_ldap_content_provider_invalid_th_lang}     passwordทดสอบ




#bodyschema
${body_change_password_schema}                ${CURDIR}/../Schemas/BodyChangePasswordSchema.json
