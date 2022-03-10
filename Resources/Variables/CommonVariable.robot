*** Variables ***
${verify_timeout}        40s
${default_browser}       chromium
${test_site}             dev
${content_type_x_www}    application/x-www-form-urlencoded  
${expected_token_type}   bearer
${content_type_json}     application/json
${reference}             1
${header_content_type}          Content-Type
${header_x_tid}                 X-Tid
${header_only_content_type_schema}    {"Content-Type": "_Content-Type_"}

# error message
${error_message_invalid_user_or_password}    invalid_user_or_password
${error_message_invalid_request}             invalid_request
${error_message_invalid_client}              invalid_client
${error_message_invalid_code}                invalid_code
${error_message_unsupported_grant_type}      unsupported_grant_type
${error_message_request_timeout}             request_timeout
${error_message_server_error}                server_error
${error_message_subscriber_not_found}        subscriber_not_found
${error_message_missing_invalid_parameter}   missing_or_invalid_parameter
${error_message_data_not_found}              data_not_found

# Json Message
${json_error_message_invalid_grant}          {"error":"invalid_grant"}
${json_error_message_invalid_request}        {"error":"invalid_request"}
