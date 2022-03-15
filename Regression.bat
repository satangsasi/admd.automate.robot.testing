@ECHO OFF
TITLE AIS Andromeda regression test
robot -d "Regression" -v "headless:True" -e "On-Hold" TestSuite
PAUSE