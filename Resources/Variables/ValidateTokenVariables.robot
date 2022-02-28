*** Variables ***
${url_validate_token}                       http://10.137.30.22:31191/v3.2/token/validate
${body_validate_token_schema}               ../Resources/Schemas/ValidateTokenSchema.json
${clientid_validate_token}                  OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX/w5SmiwOO7UU=

#url
${url_request_otp_validate_token}            http://10.137.30.22:31191/v3.2/otp/request?tid=ADMD1234
${clientid_request_otp_validate_token}       PK+WUAlHhnhgy9yNCzAk4PBHpmnSUamXM/Wcuomo2pVYgUOjPoOLgg==
${public_id_request_otp_validate_token}      66981721044
${client_secret_get_token_validate_token}    a67dd929a935d9bdd70c0845f7a5dbe5
${url_login_by_fbb}                          https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng


${grant_type_validate_token}         password
${type_get_token_validate_token}     1
${scope_get_token_validate_token}    profile
${fbb_user}                          0930455569