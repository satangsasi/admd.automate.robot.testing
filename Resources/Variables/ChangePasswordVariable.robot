*** Variables ***
#data
${user_login_change_password}       0981721044
${pass_login_change_password}       12345678
${redirect_uri_change_password}     https://www.ais.co.th/
${old_password_msisdn}             12345678
${new_password_msisdn}             12345678
${old_password_ldap_content_provider}    password1
${new_password_ldap_content_provider}    password1
${type_misdn}                            msisdn
${type_ldap}                             ldap
${client_id_change_password_FCoRIg}                        FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays+mTxG9/xpwVZQ+Eg==
${client_id_change_password_X6jpUV}                        X6jpUVHVBdszLACYucu+mkslzsMyXhwQNG/p1jO1KXg=
${state_success_change_password_msisdn}                    changepassword_success_Msisdn
${state_success_change_password_ldapcp}                    changepassword_success_LdapCp
${old_password_ldap_content_provider_invalid}             password111
${new_password_ldap_content_provider_invalid_th_lang}     passwordทดสอบ
${new_password_ldap_content_provider_invalid_&}           password&&&&
${expired_access_token_change_password}                   eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImNDajd1RjVpTm8ifQ.eyJpc3MiOiJzcmYuYWlzLmNvLnRoL2FkbWQiLCJzdWIiOiJ0b2tlbl9hdXRoZW50aWNhdGlvbl9jb2RlIiwiYXVkIjoiMGh1VUZOeEtJUEZNQ2JjbzhENE1BTzBITlNJN1Z1WC9tT1FCMlo4ZC8rbz0iLCJleHAiOjE2MjkzNzI1NDYsImlhdCI6MTYyOTMzNjU0NiwianRpIjoiVVcxbGQ2cm13NnNHZEE5dk16M1E1NSIsInBpZCI6IlBRbGRwJlIyUmtlVGwxU2xGcVJYSmlPR0l4TVMxQlJFMUVMVzlzV1hKQk5UQWtMYlJyemRITUhFdlUwRkdXRlozU2xRMVNGRTlQUT09aE8xaz0mMDUiLCJjbGllbnQiOiJNekF5TXpNc1ZWTk5RVkIyTXpKOFFuSnZkM05sY253eExqQXVNQT09Iiwic3NpZCI6ImIxZ1VCRGNIeDVVRGFZYjExTjUyM3giLCJ1aWQiOiI0MjUiLCJhdXQiOnsidHlwZSI6InVzZXJuYW1lIiwiYWN0aW9uIjoibG9naW4iLCJsb2dpbl9jaGFubmVsIjoibGRhcCIsIm5ldHdvcmsiOiJhbm9ueW1vdXMiLCJsb2dpbl9zdWJ0eXBlIjoibGRhcENwIn0sImlkcCI6ImxkYXAifQ.cQovBq5bNQ9aH13Wgn7LXAF4uR06cEjhbm1mcwsQBLCWdzxM1GJnB-zuLPoTeO05tR-e9t_jtF0QlYSMdL2gRVjNmGWZfz8D04S-vZcIWRQ8DIBRT-OBZQYKYSrTABGMzkVoEneyYjMftYaRTdYlbuV20C9duCPJK7uuyuv8nnU
${old_password_msisdn_invalid}                            12345678uyy                              


#bodyschema
${body_change_password_schema}                ${CURDIR}/../Schemas/ChangePasswordSchemas/BodyChangePasswordSchema.json
