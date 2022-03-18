@ECHO OFF
TITLE AIS Andromeda regression test
robot -d "Regression" -v "HEAD_LESS:True" -v "LANG:EN" -v "TEST_SITE:DEV" -e "On-Hold" TestSuite
rundll32 user32.dll,MessageBeep
PAUSE