*** Settings ***
Library    Collections
Library    String
Library    DateTime
Library    OperatingSystem
Library    RequestsLibrary
Library    JSONLibrary
Library    SSHLibrary    20s
Library    Browser    timeout=00:00:20   run_on_failure=Take Screenshot Failure Specific Name
# Buffets
Resource    ../../arcadia.automate.buffet/UIBuffet/BrowserLibrary_UICommonKeywords.robot
Resource    ../../arcadia.automate.buffet/APIBuffet/RequestLibrary_APICommonKeywords.robot
Resource    ../../arcadia.automate.buffet/RobotBuffet/BuiltinLibrary_CommonKeywords.robot
Library     ../../arcadia.automate.buffet/Library/decode_data.py
# Keywords
Resource    ../Resources/Keywords/EmailOTPKeywords.robot
Resource    ../Resources/Keywords/ClientCredentialKeywords.robot
Resource    ../Resources/Keywords/LDAPallOUKeywords.robot
Resource    ../Resources/Keywords/Commonkeywords.robot
Resource    ../Resources/Keywords/Mobileid_(iot)Keywords.robot
Resource    ../Resources/Keywords/ValidateTokenKeywords.robot
Resource    ../Resources/Keywords/FBBOTPKeyword.robot
# Variables
Resource    ../Resources/Variables/EmailOTPVariables.robot
Resource    ../Resources/Variables/CommonVariable.robot
Resource    ../Resources/Variables/ClientCredentialVariables.robot
Resource    ../Resources/Variables/LDAPallOUVariables.robot
Resource    ../Resources/Variables/Mobileid_(iot)Variable.robot
Resource    ../Resources/Variables/ValidateTokenVariables.robot
Resource    ../Resources/Variables/FBBOTPVariable.robot
# Repositories
Resource    ../Resources/Repositories/LDAPallOURepository.robot
