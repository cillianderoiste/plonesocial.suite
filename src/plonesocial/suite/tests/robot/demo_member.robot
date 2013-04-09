*** Settings ***
Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot
Resource  plone/app/robotframework/saucelabs.robot
Resource  plone/app/robotframework/annotate.robot
Resource  plone/app/robotframework/speak.robot
Library   Remote  ${PLONE_URL}/RobotRemote

Test Setup     Open SauceLabs test browser
Test Teardown  Run keywords  Report test status  Close all browsers

*** Test Cases ***
    
Demo
    [Tags]  demo
    Log in   clare_presler  secret
    Go to homepage
    Set Selenium Speed  0.5 seconds            
    ${dot} =  Add styled dot  portal-logo  1
    ${note} =  Add styled note  portal-logo  This is a note  position=bottom
    Remove elements  ${dot}  ${note}
    Input Text  css=textarea  This is a microblog status update. With a #demo hashtag.
    Add pointer  form-buttons-statusupdate    
    Click Button  id=form-buttons-statusupdate
    Click Element  xpath=//a[@href="@@stream/tag/demo"]    
    Go to  ${PLONE_URL}/@@profile    
    Go to  ${PLONE_URL}/@@stream    
    Go to  ${PLONE_URL}/@@stream/explore
    Sleep  3s


*** Keywords ***
    
Add styled dot
    [Arguments]  ${locator}  ${number}
    ${dot} =  Add dot  ${locator}  ${number}  display=none
    Update element style  ${dot}  -moz-transform  scale(4)
    Update element style  ${dot}  display  block
    Update element style  ${dot}  -moz-transition  all 1s
    Update element style  ${dot}  -moz-transform  scale(1)
    Sleep  1s
    [return]  ${dot}
    
Add styled note
    [Arguments]  ${locator}  ${message}  ${position}=${EMPTY}
    ${note} =  Add note  ${locator}  ${message}
    ...  display=none  position=${position}
    Update element style  ${note}  opacity  0
    Update element style  ${note}  display  block
    Update element style  ${note}  -moz-transition  opacity 1s
    Update element style  ${note}  opacity  1
    Sleep  2s
    [return]  ${note}

      
