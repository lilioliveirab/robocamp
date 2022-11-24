*** Settings ***
Documentation        Gerenciando a massa de testes através do banco de dados

Library                DatabaseLibrary

*** Keywords ***
Connect To Postgres
        Connect To Database    psycopg2    
        ...                    oedfezjk
        ...                    oedfezjk
        ...                    AJO5-6rWIniLN7QvMN-R6qD4S85tU3w-
        ...                    babar.db.elephantsql.com
        ...                    5432


Select Student Where Email
    [Arguments]        ${email}
    
    ${query}        Set Variable
    ...             SELECT * FROM public.students WhERE email = '${email}';

    ${result}      Query           ${query}

    [return]       ${result}[0]

Delete Enroll By Email
    [Arguments]        ${email}

    ${user}        Select Student Where Email        ${email}

    ${query}        Set Variable
    ...             DELETE FROM public.enrollments WhERE student_id = '${user}[0]';

    Execute Sql String        ${query}

# Helpers 
Reset Student Enroll
    [Arguments]            ${email}
    Connect To Postgres  
    Delete Enroll By Email          ${email}
    Disconnect From Database