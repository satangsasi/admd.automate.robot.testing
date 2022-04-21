*** Settings ***
Library    Collections
Library    String
Library    DateTime
Library    OperatingSystem
Library    RequestsLibrary
Library    JSONLibrary
Library    SSHLibrary
Library    Browser       timeout=00:00:20   run_on_failure=Take Screenshot Failure Specific Name

# Buffets
Resource    ../../arcadia.automate.buffet/UIBuffet/BrowserLibrary_UICommonKeywords.robot
Resource    ../../arcadia.automate.buffet/APIBuffet/RequestLibrary_APICommonKeywords.robot
Resource    ../../arcadia.automate.buffet/RobotBuffet/BuiltinLibrary_CommonKeywords.robot
Library     ../../arcadia.automate.buffet/Library/decode_data.py

# Keywords
Resource    ../Resources/Keywords/ChangePasswordKeywords.robot
Resource    ../Resources/Keywords/ClientCredentialKeywords.robot
Resource    ../Resources/Keywords/CommonKeywords.robot
Resource    ../Resources/Keywords/EmailOTPKeywords.robot
Resource    ../Resources/Keywords/FBBOTPKeyword.robot
Resource    ../Resources/Keywords/ForgotPWKeywords.robot
Resource    ../Resources/Keywords/LDAPallOUKeywords.robot
Resource    ../Resources/Keywords/ValidateTokenKeywords.robot
Resource    ../Resources/Keywords/FBB_nowebviewKeywords.robot
Resource    ../Resources/Keywords/LogoutKeywords.robot
Resource    ../Resources/Keywords/Logout_pushNotifyKeywords.robot

# Localized
Resource    ../Resources/Localized/${LANG}/LDAPallOULocalized.robot
Resource    ../Resources/Localized/${LANG}/ForgotPWLocalized.robot

# Repositories
Resource    ../Resources/Repositories/ChangePasswordRepositories.robot
Resource    ../Resources/Repositories/FBBOTPRepositories.robot
Resource    ../Resources/Repositories/ForgotPWRepositories.robot
Resource    ../Resources/Repositories/LDAPallOURepositories.robot
Resource    ../Resources/Repositories/CommonRepositories.robot
Resource    ../Resources/Repositories/Logout_pushNotifyRepositories.robot

# Test Site
Resource    ../Resources/Testsite/${TEST_SITE}/Testsite.robot
Resource    ../Resources/Testsite/${DOMAIN}.robot

# Variables
Resource    ../Resources/Variables/ChangePasswordVariables.robot
Resource    ../Resources/Variables/ClientCredentialVariables.robot
Resource    ../Resources/Variables/CommonVariables.robot
Resource    ../Resources/Variables/EmailOTPVariables.robot
Resource    ../Resources/Variables/FBBOTPVariables.robot
Resource    ../Resources/Variables/ForgotPWVariables.robot
Resource    ../Resources/Variables/LDAPallOUVariables.robot
Resource    ../Resources/Variables/ValidateTokenVariables.robot
Resource    ../Resources/Variables/FBB_nowebviewVariables.robot
Resource    ../Resources/Variables/LogoutVariables.robot
Resource    ../Resources/Variables/Logout_pushNotifyVariables.robot


*** Variables ***
${LANG}         EN
${TEST_SITE}    DEV
${DOMAIN}       Public
${REGRESSION}   False
