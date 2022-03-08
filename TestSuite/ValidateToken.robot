*** Settings ***
Resource    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Set Test Documentation Detail


*** Test Cases ***
TST_F6_1_1_001 verify validate success B2C
    [Documentation]    Owner: Nakarin
    ...    login by FBB OTP
    [Tags]    Success    vpn    Sprint3
    Create Browser Session    ${url_login_by_fbb}
    Fill Username FBB OTP
    Click Request OTP
    Get OTP Password FBB
    Fill OTP Password FBB
    Press Login Button In FBB OTP
    Create URL For Get Token Validate Token
    New Page    ${URL_GET_TOKEN}
    Set Response On Webpage To Json
    Set API Header B2C
    Set API Body B2C
    Send Post Request Validate Token
    Verify Response Success Validate Token

TST_F6_1_1_002 verify validate success CURL
    [Documentation]    Owner: Nakarin
    ...    login by auto FBB
    [Tags]    Success    On-Hold

TST_F6_1_1_003 verify validate success login by client credentials
    [Documentation]    Owner: Nakarin
    [Tags]    Success    vpn    Sprint2
    Get Access Token ClientCredential
    Set API Header Login By Client Credential
    Set API Body Login By Client Credential
    Send Post Request Validate Token
    Verify Response Success Validate Token

TST_F6_1_1_004 verify validate success with profile have gupimpi more than one object 
    [Documentation]    Owner: Nakarin
    ...    - config gupcommon is multi-sequence
    ...    ** ใช้โปรไฟล์ที่ Dup มาจาก Prod by SI and TS**"
    [Tags]    Success    On-Hold

TST_F6_0_1_001 Verify validate fail with no access token received from loging by msisdn which is no profile
    [Documentation]    Owner: Sasipen
    ...
    [Tags]    Fail    demo
    Set API Header Request Otp Validate Token
    Set API Body Request Otp Validate Token
    Send Post Request Otp Validate Token
    Get Value Response Request Email Otp By Key Session Id 
    Get Value Response Request Email Otp By Key Transaction Id
    Get Email OTP Password    ${ACTUAL_VALUE_TRANSACTION_ID}
    Set API Header Get Token Validate Token
    Set API Body Get Token Validate Token
    Send Post Request Get Token Validate Token
    Get Value Response Get Token By Key Access Token
    Set API Header Delete Sub Scriber
    Set API Body Delete Sub Scriber
    Send Post Request Delete Sub Scriber
    Set API Header Validate Token
    Set API Body Validate Token
    Send Post Request Validate Token No Profile    404
    Verify Response Validate Token No Profile

TST_F6_0_1_002 verify validate fail with incorrect client id
    [Documentation]    Owner: sasipen
    ...
    [Tags]    Fail    demo
    Set API Header Request Otp Validate Token
    Set API Body Request Otp Validate Token
    Send Post Request Otp Validate Token
    Get Value Response Request Email Otp By Key Session Id
    Get Value Response Request Email Otp By Key Transaction Id
    Get Email OTP Password    ${ACTUAL_VALUE_TRANSACTION_ID}
    Set API Header Get Token Validate Token
    Set API Body Get Token Validate Token
    Send Post Request Get Token Validate Token
    Get Value Response Get Token By Key Access Token
    Set API Header Validate Token Invalid Client Id
    Set API Body Validate Token Invalid Client Id
    Send Post Request Validate Token Invalid Client Id    401
    Verify Response Validate Token Invalid Client Id
TST_F6_0_1_003 verify validate fail with incorrect access token
    [Documentation]    Owner:sasipen
    ...
    [Tags]    Fail    demosprint3   
    Set API Header Request Otp Validate Token
    Set API Body Request Otp Validate Token
    Send Post Request Otp Validate Token
    Get Value Response Request Email Otp By Key Session Id 
    Get Value Response Request Email Otp By Key Transaction Id
    Get Email OTP Password    ${ACTUAL_VALUE_TRANSACTION_ID}
    Set API Header Get Token Validate Token
    Set API Body Get Token Validate Token
    Send Post Request Get Token Validate Token
    Get Value Response Get Token By Key Access Token
    Set API Header Validate Token Invalid Access Token
    Set API Body Validate Token Invalid Access Token
    Send Post Request Validate Token Invalid Access Token    400
    Verify Response Validate Token Invalid Access Token

TST_F6_0_1_004 verify validate fail with expired access token
    [Documentation]    Owner:
    [Tags]    Fail    demosprint3      
    Set API Header Request Otp Validate Token
    Set API Body Request Otp Validate Token
    Send Post Request Otp Validate Token
    Get Value Response Request Email Otp By Key Session Id 
    Get Value Response Request Email Otp By Key Transaction Id
    Get Email OTP Password    ${ACTUAL_VALUE_TRANSACTION_ID}
    Set API Header Get Token Validate Token
    Set API Body Get Token Validate Token
    Send Post Request Get Token Validate Token
    Get Value Response Get Token By Key Access Token
    Set API Header Validate Token Expired Access Token
    Set API Body Validate Token Expired Access Token          
    Send Post Request Validate Token Expired Access Token    404
    Verify Response Validate Token Expired Access Token

TST_F6_0_1_005 verify validate fail with missing client id
    [Documentation]    Owner:sasipen
    ...
    [Tags]    Fail    demosprint3     
    Set API Header Request Otp Validate Token
    Set API Body Request Otp Validate Token
    Send Post Request Otp Validate Token
    Get Value Response Request Email Otp By Key Session Id 
    Get Value Response Request Email Otp By Key Transaction Id
    Get Email OTP Password    ${ACTUAL_VALUE_TRANSACTION_ID}
    Set API Header Get Token Validate Token
    Set API Body Get Token Validate Token
    Send Post Request Get Token Validate Token
    Get Value Response Get Token By Key Access Token
    Set API Header Validate Token Missing Client Id
    Set API Body Validate Token Missing Client Id
    Send Post Request Validate Token Missing Client Id    400
    Verify Response Validate Token Missing Client Id

TST_F6_0_1_006 verify validate fail with missing access token
    [Documentation]    Owner:sasipen
    ...
    [Tags]    Fail    demosprint3     
    Set API Header Request Otp Validate Token
    Set API Body Request Otp Validate Token
    Send Post Request Otp Validate Token
    Get Value Response Request Email Otp By Key Session Id 
    Get Value Response Request Email Otp By Key Transaction Id
    Get Email OTP Password    ${ACTUAL_VALUE_TRANSACTION_ID}
    Set API Header Get Token Validate Token
    Set API Body Get Token Validate Token
    Send Post Request Get Token Validate Token
    Get Value Response Get Token By Key Access Token
    Set API Header Validate Token Missing Access Token
    Set API Body Validate Token Missing Access Token
    Send Post Request Validate Token Missing Access Token    400
    Verify Response Validate Token Missing Access Token
