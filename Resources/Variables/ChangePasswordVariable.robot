*** Variables ***
#url
${url_login_change_password}                   https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_change_password_schema}        https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=FCoRIgzYc6qyWBdO8kC8roohCF7NMYMfwcTays%2BmTxG9%2FxpwVZQ%2BEg%3D%3D&client_secret=cbf628414349cdb3f98fcf3edf19d21f&grant_type=authorization_code&code=_code_&redirect_uri=https://www.ais.co.th/

#data
${user_login_change_password}       0981721044
${pass_login_change_password}       12345678
