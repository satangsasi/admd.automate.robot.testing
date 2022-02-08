*** Variables ***
# Webpage
${txt_username_ldap}         //*[@id='susername']
${txt_password_ldap}         //*[@id='spassword']
${btn_login_ldap}            //*[@id='bsing_in']

# Login Error Message
${lbl_error_title}          //*[@id='swal2-title']
${lbl_error_message}        //*[@id='swal2-content']

# JSON
${lbl_json_response_on_webpage}    xpath=//pre