*** Variables ***
${ssh_user}          serveradm
${ssh_pass}          R3dh@t!@#
${ssh_ip_address}    10.137.30.22

#Url
${url_request_email_otp}     http://10.137.30.22:31191/v3.2/otp/request?tid=ADMD1234
${url_get_token_email_otp}   http://10.137.30.22:31191/v3.2/oauth/token                            

#body
${client_id_PK+WUA}           PK+WUAlHhnhgy9yNCzAk4PBHpmnSUamXM/Wcuomo2pVYgUOjPoOLgg==
${client_secret_id_PK+WUA}    a67dd929a935d9bdd70c0845f7a5dbe5
${public_id}                  gsso@corp.ais900dev.org
${reference}                  1
${body_request_email_otp_schema}      {"client_id": "_client_id_", "public_id": "_public_id_", "reference": "_reference_"}
${body_get_token_email_otp_schema}    {"client_id": "_client_id_", "client_secret": "_client_secret_", "grant_type": "_grant_type_", "username": "_username_", "password": "_password_", "type": "_type_", "scope": "_scope_", "session_id": "_session_id_", "transaction_id": "_transaction_id_"}
${body_get_token_email_otp_no_session_transaction_id_schema}    {"client_id": "_client_id_", "client_secret": "_client_secret_", "grant_type": "_grant_type_", "username": "_username_", "password": "_password_", "type": "_type_", "scope": "_scope_"}

${grant_type_email_otp}                 password
${type_get_token_email_otp}             1
${invalid_type_get_token_email_otp}     0
${scope_get_token_email_otp}            profile
${invalid_session_id}                   aaabbbbccccccdddddd
${invalid_transaction_id}               P2wX4vUiF3Raaaaaaa
${invalid_password}                     418899
${invalid_public_id}                    testais0000000001@gmail.com
${invalid_client_id_ABCDEF}             ABCDEFGHIJKL123456PBHpmnSUamXM/Wcuomo2pVYgUOjPoOLgg==
${invalid_client_secret}                12345679a935d9bdd70c0845f7a5dbe5
${invalid_grant_type_email_otp}                   password12345

#response
${expected_result_code_email_otp}                 20000
${expected_developer_message}                     success
${expected_expires_in_email_otp}                  86400
${expected_refresh_token_expires_in_email_otp}    86400
${expected_invalid_result_code_email_otp}         50300  
${expected_invalid_developer_message}             server_busy
