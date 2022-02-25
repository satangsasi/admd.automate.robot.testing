*** Variables ***
${url_validate_token}         http://10.137.30.22:31191/v3.2/token/validate
${body_validate_token_schema}    ../Resources/Schemas/ValidateTokenSchema.json
${clientid_validate_token}    OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX/w5SmiwOO7UU=
${json_string_var}    {"client_id": "_client_id_", "token": {"type": "access_token","value": "_value_"}, "nonce": "123456789"}