*** Variables ***
# Label
${lbl_forgot_password}    //*[@id="lforgot_link"]

# Text box
${txt_username_forgot_pw}            //*[@id="fforgot_input"]
${txt_otp_password_forgot_pw}        //*[@id="fotp1"]
${txt_question1_forget_pw}           //*[@id="fquestion_input0"]
${txt_question2_forget_pw}           //*[@id="fquestion_input1"]
${txt_reset_password_forget_pw}      //*[@id="rpassword2"]
${txt_confirm_password_forget_pw}    //*[@id="rconfirm_password2"]

# Button
${btn_submit_request_otp}    //*[@id="fbtn_req_otp"]
${btn_next2_forgot_pw}    //*[@id="next_forgotMobilePage1"]
${btn_next3_forgot_pw}    //*[@id="next_forgotMobilePage2"]
${btn_next4_forgot_pw}    //*[@id="btn-next2"]

${lbl_error_email_wrong}                  //*[@id='swal2-content']/labal[1]       
${lbl_error_check_email}                  //*[@id='swal2-content']/labal[2]     
${btn_close_error_box}                    //*[@class='swal2-confirm button-modal swal2-styled']

${txt_email_number_gmail}        //*[@id='identifierId']
${btn_next_gmail}                //*[@id='identifierNext']/div/button
${txt_password_gmail}            //*[@id='password']/div/div/div/input
${btn_try_again}                 //*[@id='next']/div/button
${btn_password_next_gmail}       //*[@id='password']/div/div/input

${txt_new_password}                 //*[@id="new_password"]
${txt_confirm_new_password}         //*[@id="confirm_password"]
${btn_submit_new_password}          //*[@id="btnSummit"]  
${img_send_succeeds}                //*[@id="form-sign"]/div[1]/div/img
${lbl_succeeds}                     //*[@id="form-sign"]/div[2]/label
${lbl_succeeds_check_your_email}    //*[@id="form-sign"]/div[3]/label
