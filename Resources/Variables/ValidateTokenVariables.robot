*** Variables ***
#Body
${clientid_validate_token}                   OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX/w5SmiwOO7UU=
${clientid_validate_token_invalid}           PK+WUAlHhnhgy9yNCzAk4PBHpmnSUamXM/Wcuomo2pVYgUOj
${clientid_request_otp_validate_token}       PK+WUAlHhnhgy9yNCzAk4PBHpmnSUamXM/Wcuomo2pVYgUOjPoOLgg==
${public_id_request_otp_validate_token}      66981721044
${client_secret_get_token_validate_token}    a67dd929a935d9bdd70c0845f7a5dbe5
${grant_type_validate_token}                 password
${grant_type_nowebview_validate_token}       password (nowebview)
${type_get_token_validate_token}             1
${scope_get_token_validate_token}            profile

${expired_access_token_validate_token}       eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImZmTXVMUXdZME8ifQ.eyJpc3MiOiJzcmYuYWlzLmNvLnRoL2FkbWQiLCJzdWIiOiJ0b2tlbl9wYXNzd29yZCIsImF1ZCI6IlBLK1dVQWxIaG5oZ3k5eU5DekFrNFBCSHBtblNVYW1YTS9XY3VvbW8ycFZZZ1VPalBvT0xnZz09IiwiZXhwIjoxNjM1MjE4NTE4LCJpYXQiOjE2MzUxMzIxMTgsImp0aSI6ImZTZXJma0NqREFqWkJBb2lzT0NMVWoiLCJwaWQiOiIzZWZPS2RFbDRMYVBuZ2dpalVwOW5FbXdOY3k0RUNXaEdHNjI3cTFTaU40PSIsImNsaWVudCI6Ik16QXlNemdzY205aWIzUnViM2RsWW5acFpYZDhRbkp2ZDNObGNud3hMakF1TUE9PSIsInNzaWQiOiJaTlpVaEIxcjZNUVJIMDI5Q3N0dDNsIiwiYXV0Ijp7InR5cGUiOiJtc2lzZG4iLCJhY3Rpb24iOiJsb2dpbiIsImxvZ2luX2NoYW5uZWwiOiJvdHAiLCJuZXR3b3JrIjoiYW5vbnltb3VzIn0sInVpZCI6IjY2MTYzMDAxODQ0Mjc0MyIsImlhbCI6IjEuMSIsImFhbCI6IjEifQ.RwynspwpJBA9TGIsaaBaAQg67kmD_nLrtrH3-FDxh-vu5aXaxC6owivVUw8k7lof7eVYk42SzU3kgykqtkGmvGfVEXTbPUwJYkQRqOmE8R89mjMBTf8SQhkX2acq6KtP1TLl1EwWPfpCf2DjjygeMv9UBkO9s0xb4HBiMlmzrFs

#Respone
${expected_result_code_40402}    40402
${expected_result_code_40106}    40106
${expected_result_code_40001}    40001
${expected_result_code_40000}    40000
${expected_result_code_40401}    40401

#Body_schema
${body_validate_token_schema}                ${CURDIR}/../Schemas/ValidateTokenSchemas/ValidateTokenSchema.json
${body_request_otp_validate_token_schema}    ${CURDIR}/../Schemas/ValidateTokenSchemas/BodyRequestOtpValidateTokenSchema.json
${body_get_token_validate_token_schema}      ${CURDIR}/../Schemas/ValidateTokenSchemas/BodyGetTokenValidateTokenSchema.json
${body_delete_sub_scriber_schema}            ${CURDIR}/../Schemas/ValidateTokenSchemas/BodyDeleteSubScriber.json
