*** Variables ***
${url_client_credentials_dev}                         https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token
${url_client_credentials_dev_invalid}                 https://iot-apivr.ais.co.th/authtest/v3.2/oauth/tokennnnnn
${content_type_x_www}                                 application/x-www-form-urlencoded  
${header_client_credentials_schema}                   {"Content-Type": "_Content-Type_"}
${body_client_credentials_schema}                     {"client_id": "_client_id_", "client_secret": "_client_secret_", "grant_type": "_grant_type_", "nonce": "_nonce_" }
${body_client_credentials_missing_id_schema}          {"client_secret": "_client_secret_", "grant_type": "_grant_type_", "nonce": "_nonce_" }
${body_client_credentials_missing_secret_schema}      {"client_id": "_client_id_", "grant_type": "_grant_type_", "nonce": "_nonce_" }
${body_client_credentials_missing_grant_type_schema}  {"client_id": "_client_id_", "client_secret": "_client_secret_", "nonce": "_nonce_" }
${client_id_OhFw3u}                                   OhFw3uAQgMeBUD8IOxYZRO0HNSI7VuX/w5SmiwOO7UU=
${client_id_OhFw3u_browser}                           OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX/w5SmiwOO7UU=
${client_secret_id_OhFw3u}                            cb32b1d1e0f1361881aadb0cc175778e 
${client_secret_id_OhFw3u_browser}                    adfea93d79e56e5219eccd63cc884ae3  
${grant_type}                                         client_credentials        
${nonce}                                              robototp_20210322
${client_id_OhFw3u_invalid}                           OhFw3uAQgMeBUD8IOxYZRO0HNSI7VuX/w5SmiwO 
${client_secret_id_OhFw3u_invalid}                    cb32b1d1e0f1361881aadb 
${grant_type_invalid}                                 client_creden   
${client_secret_id_another}                           4e95a86d1a09e69365de19ddd5692035