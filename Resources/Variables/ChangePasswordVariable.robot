*** Variables ***
#url
${url_login_changepassword}                   https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_changepassword_schema}        https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&code=_code_&redirect_uri=https://www.ais.co.th/
${url_changepassword}                         https://iot-apivr.ais.co.th/authtest/v3.2/changepassword

#data
${user_login_changepassword}       0981721044
${pass_login_changepassword}       12345678
${redirect_uri_changepassword}     https://www.ais.co.th/
${old_password_msisdn}             12345678
${new_password_msisdn}             12345678
${old_password_ldap_content_provider}    password1
${new_password_ldap_content_provider}    password1
${type_misdn}                            msisdn
${type_ldap}                             ldap
${client_id_changepassword_FCoRIg}                        FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays+mTxG9/xpwVZQ+Eg==
${client_id_changepassword_X6jpUV}                        X6jpUVHVBdszLACYucu+mkslzsMyXhwQNG/p1jO1KXg=
${state_success_changepassword_msisdn}                    Changepassword_success_Msisdn
${state_success_changepassword_ldapcp}                    Changepassword_success_LdapCp
${old_password_ldap_content_provider_invalid}             password111
${new_password_ldap_content_provider_invalid_th_lang}     passwordทดสอบ
${new_password_ldap_content_provider_invalid_&}           password&&&&
${expired_access_token_changepassword}                    eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImNDajd1RjVpTm8ifQ.eyJpc3MiOiJzcmYuYWlzLmNvLnRoL2FkbWQiLCJzdWIiOiJ0b2tlbl9hdXRoZW50aWNhdGlvbl9jb2RlIiwiYXVkIjoiMGh1VUZOeEtJUEZNQ2JjbzhENE1BTzBITlNJN1Z1WC9tT1FCMlo4ZC8rbz0iLCJleHAiOjE2MjkzNzI1NDYsImlhdCI6MTYyOTMzNjU0NiwianRpIjoiVVcxbGQ2cm13NnNHZEE5dk16M1E1NSIsInBpZCI6IlBRbGRwJlIyUmtlVGwxU2xGcVJYSmlPR0l4TVMxQlJFMUVMVzlzV1hKQk5UQWtMYlJyemRITUhFdlUwRkdXRlozU2xRMVNGRTlQUT09aE8xaz0mMDUiLCJjbGllbnQiOiJNekF5TXpNc1ZWTk5RVkIyTXpKOFFuSnZkM05sY253eExqQXVNQT09Iiwic3NpZCI6ImIxZ1VCRGNIeDVVRGFZYjExTjUyM3giLCJ1aWQiOiI0MjUiLCJhdXQiOnsidHlwZSI6InVzZXJuYW1lIiwiYWN0aW9uIjoibG9naW4iLCJsb2dpbl9jaGFubmVsIjoibGRhcCIsIm5ldHdvcmsiOiJhbm9ueW1vdXMiLCJsb2dpbl9zdWJ0eXBlIjoibGRhcENwIn0sImlkcCI6ImxkYXAifQ.cQovBq5bNQ9aH13Wgn7LXAF4uR06cEjhbm1mcwsQBLCWdzxM1GJnB-zuLPoTeO05tR-e9t_jtF0QlYSMdL2gRVjNmGWZfz8D04S-vZcIWRQ8DIBRT-OBZQYKYSrTABGMzkVoEneyYjMftYaRTdYlbuV20C9duCPJK7uuyuv8nnU



#bodyschema
${body_change_password_schema}                ${CURDIR}/../Schemas/BodyChangePasswordSchema.json
