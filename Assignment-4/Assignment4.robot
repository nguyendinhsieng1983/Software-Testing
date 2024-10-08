*** Settings ***
Library    String
Library    OperatingSystem
Library    Collections
Library    Process

*** Test Cases ***
Get ip address and ping time
    ${path}=    Set Variable    D:/Hamk/Software_Testing/Unit_Testing/Assignment-4/
    ${websites}=    Get File    ${path}webpages.txt
    ${websites}=    Split String    ${websites}
    Log    ${websites}
    ${length}=    Get Length    ${websites}
    Log    ${length}
    Create File    ${path}info.txt
    FOR    ${index}    IN RANGE    ${length}
        #Read info from file
        ${webAddress}=    Set Variable    ${websites}[${index}]
        Log    ${webAddress}
        #ping website
        ${ipString}=    Run And Return Rc And Output    ping ${webAddress}
        Log    ${ipString}
        ${ipString}=    Split String    ${ipString}[1]
        ${index}=    Get Index From List    ${ipString}    from
        Log    ${index}
        ${index}=    Evaluate    ${index}+1
        ${ipAddress}=    Set Variable    ${ipString}[${index}]
        ${ipAddress}=    Remove String    ${ipAddress}    :
        Log    ${ipAddress}
        Append To File    ${path}info.txt    ${webAddress}: ${ipAddress}\n
        #Use RF to capture the IP and ping time of each pinged site. Test that the time taken for Ping is less than 50ms.
        ${index}=    Get Index From List    ${ipString}    from
        ${index}=    Evaluate    ${index}+3
        ${ping-time1}=    Set Variable    ${ipString}[${index}]
        ${ping-time1}=    Remove String    ${ping-time1}    time=    ms
        Log    ${ping-time1}
        Append To File    ${path}info.txt    ping-time: ${ping-time1}\n
        Should Be True    ${ping-time1}<50
        
        ${index}=    Get Index From List    ${ipString}    from    ${index}
        ${index}=    Evaluate    ${index}+3
        ${ping-time2}=    Set Variable    ${ipString}[${index}]
        ${ping-time2}=    Remove String    ${ping-time2}    time=    ms
        Log    ${ping-time2}
        Append To File    ${path}info.txt    ping-time: ${ping-time2}\n
        Should Be True    ${ping-time2}<50

        ${index}=    Get Index From List    ${ipString}    from    ${index}
        ${index}=    Evaluate    ${index}+3
        ${ping-time3}=    Set Variable    ${ipString}[${index}]
        ${ping-time3}=    Remove String    ${ping-time3}    time=    ms
        Log    ${ping-time3}
        Append To File    ${path}info.txt    ping-time: ${ping-time3}\n
        Should Be True    ${ping-time3}<50

        ${index}=    Get Index From List    ${ipString}    from    ${index}
        ${index}=    Evaluate    ${index}+3
        ${ping-time4}=    Set Variable    ${ipString}[${index}]
        ${ping-time4}=    Remove String    ${ping-time4}    time=    ms
        Log    ${ping-time4}
        Append To File    ${path}info.txt    ping-time: ${ping-time4}\n
        Should Be True    ${ping-time4}<50
        #The average ping- time for the site.
        ${ping-average-time}=    Evaluate    (${ping-time1}+${ping-time2}+${ping-time3}+${ping-time4})/4
        Append To File    ${path}info.txt    Average-ping-time: ${ping-average-time}\n\n
    END
        # Sieng Nguyen