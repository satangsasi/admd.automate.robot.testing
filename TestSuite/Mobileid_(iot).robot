*** Settings ***
Library    ./Resource_init.robot
Test Teardown    Run Keyword And Ignore Error    Append To Document Teardown


*** Test Cases ***
TST_F11_1_1_001 authorize without redirect_uri with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_002 token with redirect_uri (https) with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_003 authorize without redirect_uri with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_004 token with redirect_uri (deep link) with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_005 authorize without redirect_uri with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_006 token with redirect_uri (https) with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_007 authorize without redirect_uri with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_008 token with redirect_uri (deep link) with scope profile_kyc
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_009 authorize without redirect_uri with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_010 token with redirect_uri (https) with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_011 authorize without redirect_uri with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_012 token with redirect_uri (deep link) with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_013 authorize without redirect_uri with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold
    
TST_F11_1_1_014 token with redirect_uri (https) with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_015 authorize without redirect_uri with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_016 token with redirect_uri (deep link) with scope profile
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_017 authorize without redirect_uri with scope openId
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_018 token with redirect_uri (https) with scope openId
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_019 authorize without redirect_uri with scope openId
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_020 token with redirect_uri (deep link) with scope openId
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_021 authorize without redirect_uri with scope openId (2.2)
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_022 token with redirect_uri (https) with scope openId (2.2)
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_1_1_023 authorize without redirect_uri with scope openId (2.2)
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case    On-Hold

TST_F11_1_1_024 token with redirect_uri (deep link) with scope openId (2.2)
    [Documentation]    Owner: Nakarin
    [Tags]    Success-Case

TST_F11_0_1_001 Validate fail with unknow URL
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_002 Validate fail with missing parameter
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_003 Validate fail with invalid content-type
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_004 Validate fail with invalid client_id
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_005 Validate fail with invalid client_secret
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_006 Validate fail with invalid grant_type
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_007 Request authorize with redirect_uri not match in ptsListOfRedirectURL
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_008 Request authorize with x-msisdn is non-ais
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_009 Request authorize without x-msisdn
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_010 Request token with authCode has expired
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case

TST_F11_0_1_011 Request token with redirect_uri not match in ptsListOfRedirectURL
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case
    
TST_F11_0_1_012 Request API with access_token has expired
    [Documentation]     Owner : sasipen
    [Tags]    Fail-Case
