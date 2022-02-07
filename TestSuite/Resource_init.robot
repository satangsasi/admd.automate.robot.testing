*** Settings ***
Library    Browser    timeout=0:00:20    run_on_failure=Take Screenshot Failure Specific Name
Library    Collections
Library    RequestsLibrary
Library    String
Library    JSONLibrary
# Buffets
Resource    ../../arcadia.automate.buffet/UIBuffet/BrowserLibrary_UICommonKeywords.robot
Resource    ../../arcadia.automate.buffet/APIBuffet/RequestLibrary_APIKeywords.robot
# Keywords
Resource    ../Resources/Keywords/ClientCredentialKeywords.robot
Resource    ../Resources/Keywords/LDAPallOUKeywords.robot
Resource    ../Resources/Keywords/Commonkeywords.robot
# Variables
Resource    ../Resources/Variables/CommonVariable.robot
Resource    ../Resources/Variables/ClientCredentialVariables.robot
Resource    ../Resources/Variables/LDAPallOUVariables.robot
# Repositories
Resource    ../Resources/Repositories/LDAPallOURepository.robot