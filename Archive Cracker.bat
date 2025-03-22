@echo off
title Archive Cracker 1.0 - Od Jardas
color 4

rem Kontrola, jestli je nainstalovaný 7-Zip
if not exist "C:\Program Files\7-Zip" (
    echo "7-Zip není nainstalován!"
    pause
    exit

)
echo.
echo.
echo.
echo                                        ---------------------------------
echo                                          Archive Cracker - Od Jardas
echo                                        ---------------------------------
echo.
echo.
echo.

rem Dá uživateli na výběr, jestli začít bruteforce nebo ukončit program
choice /C ZU /M "Vyberte Moznost(Z=Zacit, U=Ukoncit):"
if %errorlevel%==2 exit else(
    rem Zeptá se na cestu ke slovníku (wordlistu) a uloží cestu do proměnné slovnik
    set /p slovnik="Zadejte cestu ke slovniku: "

    rem Zkontroluje, zda soubor existuje
    if not exist "%slovnik%" (
        echo Slovnik nebyl nalezen!
        pause
        exit

    )
    rem Zeptá se na cestu k archivu a uloží cestu do proměnné archiv
    set /p archiv="Zadejte cestu k archivu: "

    rem Zkontroluje, zda cesta k archivu existuje
    if not exist "%archiv%" (
        echo Archiv nebyl nalezen!
        pause
        exit

    )
    rem Prochází všecha hesla ve slovníku a používá je k útoku
    for /f %%a in (%slovnik%) do (
        set heslo=%%a
        call :pokus

    )
    title Helso neyblo nalezeno!
    echo.
    echo Heslo nebylo ve slovniku Nalezeno! Mozna zkuste jiny?
    pause
    exit

    :pokus
    "C:\Program Files\7-Zip\7z.exe" x -p%heslo% "%archiv%" -o"cracknute" -y >nul 2>&1
    echo Zkouseni hesla: %heslo%
    if /I %errorlevel%==0 (
        title HESLO NALEZENO!
        color 2
        echo.
        echo Heslo Nalezeno: %heslo%
        pause
        exit

    )