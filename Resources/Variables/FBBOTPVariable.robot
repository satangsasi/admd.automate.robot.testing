*** Variables ***
# URL
${url_auth_fbb}         https://iot-apivr.ais.co.th/authtest/v3.2/oauth/authorize?response_type=code&client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&scope=profile&redirect_uri=https://www.ais.co.th/&lang=eng
${url_get_token_fbb}    https://iot-apivr.ais.co.th/authtest/v3.2/oauth/token?client_id=OhFw3uAQgMdMCbco8D4MAO0HNSI7VuX%2Fw5SmiwOO7UU%3D&client_secret=adfea93d79e56e5219eccd63cc884ae3&grant_type=authorization_code&redirect_uri=https://www.ais.co.th/&lang=eng&code=_code_

# Variables
${fbb_otp_user}    0930455569
