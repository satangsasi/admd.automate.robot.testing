*** Settings ***
Resource    ./Resource_init.robot


*** Test Cases ***
TST_F4_1_1_001 Verify login with EmailOTP
    [Documentation]     Owner : sasipen
TST_F4_0_1_001 Verify getting token with username is msisdn otp but no input session_id or transaction_id
TST_F4_0_1_002 Verify getting token with username is msisdn otp but incorract session_id or transaction_id
TST_F4_0_1_003 Verify getting token with username is msisdn otp but input wrong type (type = 0)
TST_F4_0_1_004 Verify getting token fail with wrong password
TST_F4_0_1_005 Verify getting token fail with expired password
TST_F4_0_1_006 Verify request OTP with use email that without a profile 
TST_F4_0_1_007 Verify getting token fail
TST_F4_0_1_008 Verify getting token fail with Invalid client_id
TST_F4_0_1_009 Verify getting token fail with Invalid grant_type
TST_F4_0_1_010 Verify getting token fail with Invalid client_Secret