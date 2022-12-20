*** Settings ***
Documentation        Suite de testes de pedido de ajuda

Resource        ../resources/base.resource

Test Setup        Start App
Test Teardown     Finish App

*** Test Cases ***
Deve poder solicitar ajuda

    ${admin}     Get Fixture    admin    
    ${lilian}    Get Fixture    lilian

    Reset Student        ${lilian}[student][email]

    ${token}               Get service Token    ${admin}
    ${student_id}          POST New Student     ${token}         ${lilian}[student]
    POST New Enroll        ${token}             ${student_id}

    Login With Student Id        ${student_id}
    Confirm Popup
    Go To Help Order
    Submit Help Order            ${lilian}[help]
    Wait Until Page Contains     Recebemos a sua dúvida. Agora é só aguardar até 24 horas para receber o nosso feedback.
    