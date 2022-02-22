*** Variables ***
${verify_timeout}        20s
${default_browser}       chromium
${test_site}             dev
${content_type_x_www}    application/x-www-form-urlencoded  
${expected_token_type}   bearer
${content_type_json}     application/json

#error message
${error_message_invalid_user_or_password}    invalid_user_or_password
${error_message_invalid_request}             invalid_request
${error_message_invalid_client}              invalid_client
${error_message_unsupported_grant_type}      unsupported_grant_type
${error_message_request_timeout}             request_timeout
${error_message_server_error}                server_error

