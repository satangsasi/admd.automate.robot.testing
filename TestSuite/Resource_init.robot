*** Settings ***
Library    Browser    timeout=0:00:20    run_on_failure=Take Screenshot Failure Specific Name
Library    Collections
Library    RequestsLibrary
Library    String
# Buffets
Resource    ../../arcadia.automate.buffet/UIBuffet/BrowserLibrary_UICommonKeywords.robot
Resource    ../../arcadia.automate.buffet/APIBuffet/RequestLibrary_APIKeywords.robot
# Keywords
Resource    ../Resources/Keyword/ClientCredentialKeyword.robot
Resource    ../Resources/Keyword/LDAPallOUKeyword.robot
# Variables
Resource    ../Resources/Variable/CommonVariable.robot
Resource    ../Resources/Variable/ClientCredentialVariable.robot
Resource    ../Resources/Variable/LDAPallOUVariable.robot
# Repositories
Resource    ../Resources/Repositories/LDAPallOURepository.robot