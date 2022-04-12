*** Variables ***
# Label
${lbl_forgot_password}              //*[@id="lforgot_link"]
${lbl_error_email_wrong}            //*[@id='swal2-content']/labal[1]       
${lbl_error_check_email}            //*[@id='swal2-content']/labal[2]  
${lbl_succeeds}                     //*[@id="form-sign"]/div[2]/label
${lbl_succeeds_check_your_email}    //*[@id="form-sign"]/div[3]/label
${lbl_error_somthing_wrong}         //*[@id='swal2-title']
${lbl_error_please_try_again}       //*[@id='swal2-content']

# Text box
${txt_username_forgot_pw}            //*[@id="fforgot_input"]
${txt_otp_password_forgot_pw}        //*[@id="fotp1"]
${txt_question1_forget_pw}           //*[@id="fquestion_input0"]
${txt_question2_forget_pw}           //*[@id="fquestion_input1"]
${txt_reset_password_forget_pw}      //*[@id="fre_password_input"]
${txt_confirm_password_forget_pw}    //*[@id="fre_conf_password_input"]
${txt_new_password}                  //*[@id="new_password"]
${txt_confirm_new_password}          //*[@id="confirm_password"]

# Button
${btn_submit_request_otp}       //*[@id="fbtn_req_otp"]
${btn_submit_confirm_otp}       //*[@id="fbtn_conf"]
${btn_submit_done_question}     //*[@id="fbtn_done_q"]
${btn_submit_done_forgot_pw}    //*[@id="fbtn_done_forgot"]
${btn_close_error_box}          //*[@class='swal2-confirm button-modal swal2-styled']
${btn_submit_new_password}      //*[@id="btnSummit"]  


${img_send_succeeds}    //*[@id="form-sign"]/div[1]/div/img
${img_send_Fail}        //*[@class="swal2-icon swal2-error swal2-animate-error-icon"]