*** Variables ***
#Url
${url_validate_token}                       http://10.137.30.22:31191/v3.2/token/validate
${url_request_otp_validate_token}            http://10.137.30.22:31191/v3.2/otp/request?tid=ADMD1234
${url_login_by_fbb}                          https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_validate_token}              http://10.137.30.22:31191/v3.2/oauth/token
${url_delete_sub_scriber}                    http://10.138.36.227:9600/v1/method/deleteSubscriber.json


#Body
${clientid_validate_token}                   OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX/w5SmiwOO7UU=
${clientid_validate_token_invalid}           PK+WUAlHhnhgy9yNCzAk4PBHpmnSUamXM/Wcuomo2pVYgUOj
${clientid_request_otp_validate_token}       PK+WUAlHhnhgy9yNCzAk4PBHpmnSUamXM/Wcuomo2pVYgUOjPoOLgg==
${public_id_request_otp_validate_token}      66981721044
${client_secret_get_token_validate_token}    a67dd929a935d9bdd70c0845f7a5dbe5
${grant_type_validate_token}                 password
${type_get_token_validate_token}             1
${scope_get_token_validate_token}            profile
${fbb_user}                                  0930455569

#Respone
${expected_result_code_no_profile}              40402
${expected_result_code_invalid_client_id}       40106
${expected_result_code_invalid_access_token}    40001

${test}        eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImZmTXVMUXdZME8ifQ.eyJpc3MiOiJzcmYuYWlzLmNvLnRoL2FkbWQiLCJzdWIiOiJ0b2tlbl9wYXNzd29yZCIsImF1ZCI6IlBLK1dVQWxIaG5oZ3k5eU5DekFrNFBCSHBtblNVYW1YTS9XY3VvbW8ycFZZZ1VPalBvT0xnZz09IiwiZXhwIjoxNjM1MjE4NTE4LCJpYXQiOjE2MzUxMzIxMTgsImp0aSI6ImZTZXJma0NqREFqWkJBb2lzT0NMVWoiLCJwaWQiOiIzZWZPS2RFbDRMYVBuZ2dpalVwOW5FbXdOY3k0RUNXaEdHNjI3cTFTaU40PSIsImNsaWVudCI6Ik16QXlNemdzY205aWIzUnViM2RsWW5acFpYZDhRbkp2ZDNObGNud3hMakF1TUE9PSIsInNzaWQiOiJaTlpVaEIxcjZNUVJIMDI5Q3N0dDNsIiwiYXV0Ijp7InR5cGUiOiJtc2lzZG4iLCJhY3Rpb24iOiJsb2dpbiIsImxvZ2luX2NoYW5uZWwiOiJvdHAiLCJuZXR3b3JrIjoiYW5vbnltb3VzIn0sInVpZCI6IjY2MTYzMDAxODQ0Mjc0MyIsImlhbCI6IjEuMSIsImFhbCI6IjEifQ.RwynspwpJBA9TGIsaaBaAQg67kmD_nLrtrH3-FDxh-vu5aXaxC6owivVUw8k7lof7eVYk42SzU3kgykqtkGmvGfVEXTbPUwJYkQRqOmE8R89mjMBTf8SQhkX2acq6KtP1TLl1EwWPfpCf2DjjygeMv9UBkO9s0xb4HBiMlmzrFs




























































































































































































































































































${body_validate_token_schema}               ../Resources/Schemas/ValidateTokenSchema.json
${body_request_otp_validate_token_schema}    ../Resources/Schemas/BodyRequestOtpValidateTokenSchema.json
${body_get_token_validate_token_schema}      ../Resources/Schemas/ฺBodyGetTokenValidateTokenSchema.json
${body_delete_sub_scriber_schema}            ../Resources/Schemas/ฺBodyDeleteSubScriber.json
