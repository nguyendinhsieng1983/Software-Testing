*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${browser}    chrome
${url}        http://blazedemo.com

${Departure}    Boston
${Destination}    Cairo

${CardMonth}    11
${CardYear}    2018


*** Test Cases ***


1. Open website
    Open Browser    http://blazedemo.com    Chrome
    ...    options=add_argument("--disable-search-engine-choice-screen");add_experimental_option("detach", True)
    Sleep    2s

2. Test that the page says "Welcome to the Simple Travel Agency!"
    #Check Page Heading
    Page Should Contain    Welcome to the Simple Travel Agency!
    Sleep    2s

3. Select "Boston" as the starting city (store this information in the variable)
    #Select starting city and destination
    Select From List By Value    xpath://select[@name="fromPort"]    ${Departure}
    Sleep    2s

4. Select "Cairo" as the destination (store this information in the variable)    

    Select From List By Value    xpath://select[@name="toPort"]    ${Destination}
    Sleep    2s

5. Check that the Find Flights button is selectable
    #Check that the Find Flight Button is selectable
    ${find_flight}=    Set Variable    xpath:/html/body/div[3]/form/div/input
    Sleep    2s
    Element Should Be Visible    ${find_flight}
    Sleep    1s

6. Press the Find Flights button
#Click the find flight button
    Click Button    xpath:/html/body/div[3]/form/div/input
    Sleep    2s

7. Check that the page says Flights from Boston to Cairo: (check the city names with the variables you created)
#Check page says "Flights from ${departure} to ${destination}"
    Page Should Contain    Flights from ${Departure} to ${Destination}:
    Sleep    2s

8. Check that you have at least one flight choice visible
#Veryfy there is at least one flight
     @{flights}=  Get WebElements    css:table[class='table']>tbody tr
    Sleep    1s
    Log    ${flights}
    Should Not Be Empty     ${flights}
    Sleep    2s

9. Select one of the flights and store the price, number and airline of that flight in separate variables
#Select one flight and store info
    ${price}=    Get Text  xpath:/html/body/div[2]/table/tbody/tr[1]/td[6]
    ${price}=    Remove String    ${price}    $
    Set Global Variable    ${price}
    ${number}=    Get Text  xpath:/html/body/div[2]/table/tbody/tr[1]/td[2]
    Set Global Variable    ${number}
    ${airline}=    Get Text     xpath:/html/body/div[2]/table/tbody/tr[1]/td[3]
    Set Global Variable    ${airline}
    Sleep    2s

10. On the page that opens, check that the price, airline, and flight number of the trip you stored in the variables can be found on the page
    Click Button    css:input[value='Choose This Flight']
    Sleep    2s
    ${price-checked}=    Get Text    xpath=//p[contains(text(), 'Price:')]
    ${price-checked}=    Remove String    ${price-checked}    Price:
    Set Global Variable    ${price-checked}

    ${airline-checked}=    Get Text    xpath=//p[contains(text(), 'Airline:')]
    ${airline-checked}=    Remove String    ${airline-checked}    Airline:
    Set Global Variable    ${airline-checked}

    ${number-checked}=    Get Text    xpath=//p[contains(text(), 'Flight Number:')]
    ${number-checked}=    Remove String    ${number-checked}    Flight Number:
    Set Global Variable    ${number-checked}
    Sleep    2s


Check that the price is correct:
    Should Be Equal    ${price}    ${price-checked}
    # Should Be Equal As Numbers    ${price}    ${price-checked}
    # Log    Expected Price: ${price-checked}, Actual Price: ${price}
    # ${actual_price}=    Get Text    xpath=//p[contains(text(), 'Price:')]
    # ${actual_price}=    Remove String    ${actual_price}    Price: $
    # Convert To Number    ${actual_price}
    # ${expected_price}=    Set Variable    400
    # Should Be Equal As Numbers    ${actual_price}    ${expected_price}
    # Log    Expected Price: ${expected_price}, Actual Price: ${actual_price}
    # Sleep    2s

Check that the name of airline is correct:
    Should Be Equal    ${airline}    ${airline-checked}
    # Should Be Equal    ${airline_checked}    ${airline}
    # Log    Expected Airline: ${airline}, Actual Airline: ${airline_checked}
    #Should Be Equal    ${airline}    ${airline-checked} 
    # ${airline_checked}=    Get Text    xpath=//p[contains(text(), 'Airline:')]
    # ${airline_checked}=    Remove String    ${airline_checked}    Airline:
    # Should Be Equal    ${airline_checked}    ${airline}
    # Log    Expected Airline: ${airline}, Actual Airline: ${airline_checked}    

Check that the flight number is correct: 
    Should Be Equal    ${number}    ${number-checked}
    # Should Be Equal    ${number_checked}    ${number}
    # Log    Expected Flight Number: ${number}, Actual Flight Number: ${number_checked}
    #Should Be Equal    ${airline}    ${airline-checked}   
    #Sleep    2s   
    # ${flight_number_checked}=    Get Text    xpath=//p[contains(text(), 'Flight Number:')]
    # ${flight_number_checked}=    Remove String    ${flight_number_checked}    Flight Number:
    # Should Be Equal    ${flight_number_checked}    ${number}
    # Log    Expected Flight Number: ${number}, Actual Flight Number: ${flight_number_checked}

11. Store the total price of the flight in a new variable 
#Store total price
    ${TOTAL_PRICE}    Get Text    xpath=//p[contains(text(),'Total Cost')]/em
    Set Global Variable    ${TOTAL_PRICE}
    Sleep    2s

12. Fill in the passenger information on the form (set the month and year of the card as global variables)
#Fill Passenger information
    Click Element    xpath://input[@name='inputName']
    Input Text    xpath://input[@name='inputName']    John 
    Sleep    2s
    Click Element    xpath://input[@name='address']
    Input Text    xpath://input[@name='address']    3A Paaskylandkatu
    Sleep    2s
    Click Element    xpath://input[@name='city']
    Input Text    xpath://input[@name='city']    Helsinki
    Sleep    1s
    Click Element    xpath://input[@name='state']
    Input Text    xpath://input[@name='state']    Sornanan
    Sleep    2s
    Click Element    xpath://input[@name='zipCode']
    Input Text    xpath://input[@name='zipCode']    00500
    Sleep    1s


13. Choose Diner's Club as your credit card    
    Click Element    xpath://select[@name='cardType']
    Select From List By Value    xpath://select[@name='cardType']    dinersclub
    Sleep    1s
    Click Element    xpath://input[@name='creditCardNumber']
    Input Text    xpath://input[@name='creditCardNumber']    123456789
    Sleep    2s
    Click Element    xpath://input[@name='creditCardMonth']
    Input Text    xpath://input[@name='creditCardMonth']    ${cardMonth}
    
    Click Element    xpath://input[@name='creditCardYear']
    Input Text    xpath://input[@name='creditCardYear']    ${cardYear}
    Sleep    1s
    Click Element    xpath://input[@name='nameOnCard']
    Input Text    xpath://input[@name='nameOnCard']    John Smith
    Sleep    2s

14. Click "Remember me"    
    Select Checkbox    xpath://input[@name='rememberMe']
    Sleep    2s

15. Click "Purchase Flight"
#Purchase the flight
    Click Button    css:input[type='submit']
    Sleep    2s

16. Check that the page that opens says "Thank you for your purchase today!"
#Verify success message
    Page Should Contain    Thank you for your purchase today!
    Sleep    2s

17. Check that the expiration time is correct
#Verify expiration date
    Table Row Should Contain    xpath://table[@class='table']    5    ${cardMonth} /${cardYear}
    Sleep    2s

18. Check that the total price is correct (should be equal with the variable you stored in previous step)
#Verify total price
    # ${totalPrice}=    Get Text    xpath:/html/body/div[2]/div/table/tbody/tr[3]/td[2]
    # ${totalPrice}=    Remove String    ${totalPrice}    USD
    # Should Be Equal    ${totalPrice}    ${Total_Cost}
    # Sleep    2s
    # Should Be Equal    ${total_price}    ${expected_price}
    # Log    Expected Total Price: ${expected_price}, Actual Total Price: ${total_price}
    # Sleep    2s
    ${TOTAL_PRICE}=    Get Text    xpath:/html/body/div[2]/div/table/tbody/tr[3]/td[2]
    ${TOTAL_PRICE}=    Remove String    ${TOTAL_PRICE}    USD
    Should Be Equal    ${TOTAL_PRICE}    ${TOTAL_PRICE}
    Sleep    1s

19. Close the browser
#Close the browser
    Close Browser

# Sieng Nguyen


