@echo off
title CHAT ONLINE  ^|^|  Programmazione Time
mode con: cols=77 lines=22
setlocal
call :setESC



:: ############################################
:: ------- VARIABILI PERCORSI DIRECTORY -------
:: ############################################

cd\
if not exist chat_batch (
    echo:
    echo:
    echo:  %ESC%[31m[!!!] Mancano tutti i file per procedere, avvia setup.bat [!!!]%ESC%[0m
    echo:
    echo:_____________________________________________________________________________
    echo:
    echo:
    pause
    exit
)
cd chat_batch
set chat=%cd%\chat
set config=%cd%\config
set server=%cd%\server
set posizione=%userprofile%\desktop



:: #############################################
:: ------- PRENDI INFORMAZIONI DA config -------
:: #############################################

:prendi
title CHAT ONLINE  ^|^|  Programmazione Time ~ Menu'
mode con: cols=77 lines=22
cd %config%
set/p utente=<config.txt
set/p comandi=<comandi.txt
set/p user=<username.txt
cls
if "%utente%" == "##vuoto##" (
    echo:
    echo:
    echo:  %ESC%[101;93m[!]%ESC%[0m %ESC%[31mManca il Server dove chattare... Ti rimando alle impostazioni.%ESC%[0m %ESC%[101;93m[!]%ESC%[0m
    echo:_____________________________________________________________________________
    echo:
    echo:
    pause
    goto impostazioni
)



:: ################################
:: ------- MENU' DELLA CHAT -------
:: ################################

:main
title CHAT ONLINE  ^|^|  Programmazione Time ~ Menu'
mode con: cols=77 lines=22
cls
cd %config%
echo:%ESC%[0m
echo:    _____________________________________________________________________
echo:   ^|                                                                     ^|
echo:   ^|                                                                     ^|
echo:      Bentornato %ESC%[105;97m %user% %ESC%[0m
echo:      Server attuale: %ESC%[43;97m %utente% %ESC%[0m 
echo:   ^|                                                                     ^|
echo:   ^|_____________________________________________________________________^|
echo:   \                                                                     /
echo:   /  %ESC%[101;93m[1]%ESC%[0m Crea una chat                                                  \
echo:   \  %ESC%[101;93m[2]%ESC%[0m Accedi a una chat                                              /
echo:   /  %ESC%[101;93m[3]%ESC%[0m Impostazioni                                                   \
echo:   \  %ESC%[101;93m[4]%ESC%[0m Informazioni                                                   /
echo:   /                                                                     \
echo:   \  %ESC%[101;93m[0]%ESC%[0m Esci                                                           /
echo:   /                                                                     \
echo:   \_____________________________________________________________________/
echo:
echo:%ESC%[32m
choice /c 01234 /n /m "ChatBox@%user%:~$ "
if %errorlevel% == 1 exit
if %errorlevel% == 2 echo:%ESC%[0m && goto crea
if %errorlevel% == 3 echo:%ESC%[0m && goto accedi 
if %errorlevel% == 4 echo:%ESC%[0m && goto impostazioni
if %errorlevel% == 5 echo:%ESC%[0m && goto informazioni



:: ###################################################
:: ------- CREAZIONE, ACCESSO E USO DELLA CHAT -------
:: ###################################################

:: CREAZIONE CHAT CHIAVE
:crea
title CHAT ONLINE  ^|^|  Programmazione Time ~ Creazione Chat
mode con: cols=77 lines=22
cd %chat%\%utente%
set /p ind=<link.txt
set chiave=%random%
cls
if exist chat_%chiave% goto crea
call :crea_file
cls
echo:
echo:
echo:  %ESC%[32mChat creata in%ESC%[0m %ESC%[43;97m %utente% %ESC%[0m %ESC%[32mcon successo!%ESC%[0m
echo:  Chiave numerica da condividere: %ESC%[101;93m %chiave% %ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:
fsutil file createNew chat_%chiave%.txt 0 > nul
timeout /T 1 > nul
pause
goto inizio


:: ACCESSO A CHAT ESISTENTE
:accedi
title CHAT ONLINE  ^|^|  Programmazione Time ~ Accedi alla Chat
mode con: cols=77 lines=22
cd %chat%\%utente%
set /p ind=<link.txt
cls
echo:
echo:
echo:  %ESC%[101;93m [!] Accedi alla Chat tramite il codice numerico [!] %ESC%[0m
echo:
echo:
:accedi2
set/p "chiave=%ESC%[32mChatBox@%user%:~$ %ESC%[96mCodice numerico: %ESC%[0m"
if '%chiave%' == '' echo:%ESC%[31mChiave non valida.%ESC%[0m && pause && goto accedi2
if not exist chat_%chiave (
  call :crea_file
) else (
  cd chat_%chiave%
)
curl http://%ind%/chat_%chiave%.txt --output chat_%chiave%.txt
goto inizio


:: CREA FILE
:crea_file
mkdir chat_%chiave%
:: CREAZIONE AVVIA.TXT
copy /b avvia_%utente%.txt chat_%chiave%\stampo.txt > nul
cd chat_%chiave%
copy /b stampo.txt avvia.txt > nul
(echo:lcd %chat%\%utente%\chat_%chiave%)>>avvia.txt
(echo:put chat_%chiave%.txt)>>avvia.txt
(echo:quit)>>avvia.txt
::  CREAZIONE LIVE.BAT
(echo:@echo off)>live.bat
(echo:mode con: cols=77 lines=22)>>live.bat
(echo:title LiveChat  -  Server: %utente%, Chiave Chat: %chiave%)>>live.bat
(echo:set chiave=%%1)>>live.bat
(echo:setlocal)>>live.bat
(echo:call :setESC)>>live.bat
(echo:if not exist confronta.bat goto crea)>>live.bat
(echo:)>>live.bat
(echo::ripeti)>>live.bat
(echo:if exist esci.txt exit)>>live.bat
(echo:start /MIN scarica.bat)>>live.bat
(echo:start /MIN confronta.bat)>>live.bat
(echo:cls)>>live.bat
(echo:type chat_%chiave%.txt)>>live.bat
(echo:echo:)>>live.bat
(echo:timeout /t 1 ^> nul)>>live.bat
(echo:goto ripeti)>>live.bat
(echo:)>>live.bat
(echo::crea)>>live.bat
(echo:(echo:@echo off^)^>confronta.bat)>>live.bat
(echo:(echo:comp /M chat1.txt chat2.txt^)^>^>confronta.bat)>>live.bat
(echo:(echo:if %%%%errorlevel%%%% equ 1 (^)^>^>confronta.bat)>>live.bat
(echo:(echo:copy /b chat2.txt chat1.txt^)^>^>confronta.bat)>>live.bat
(echo:(echo:copy /b chat1.txt chat_%%chiave%%.txt^)^>^>confronta.bat)>>live.bat
(echo:(echo:^^^)^)^>^>confronta.bat)>>live.bat
(echo:(echo:exit^)^>^>confronta.bat)>>live.bat
(echo:goto ripeti)>>live.bat
(echo:)>>live.bat
(echo::setESC)>>live.bat
(echo:for /F "tokens=1,2 delims=#" %%%%a in ^('"prompt #$H#$E# & echo on & for %%b in (1) do rem"'^) do ^()>>live.bat
(echo:  set ESC=%%%%b)>>live.bat
(echo:  exit /B 0)>>live.bat
(echo:^))>>live.bat
(echo:exit /B 0)>>live.bat

::  CREAZIONE INVIA.BAT
(echo:@echo off)>invia.bat
(echo:ftp -s:avvia.txt)>>invia.bat
(echo:exit)>>invia.bat
:: CREAZIONE DEL FILE scarica.bat
(echo:@echo off)>scarica.bat
(echo:curl http://%ind%/chat_%chiave%.txt --output chat2.txt)>>scarica.bat
(echo:exit)>>scarica.bat
goto :EOF

:: INIZIO DELLA CHAT CON SALUTO
:inizio
call :unisciti
:mex
cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Per prima cosa saluta in chat. %ESC%[101;93m[!]%ESC%[0m
echo:_____________________________________________________________________________
echo:
set/p "str=%ESC%[32mChatBox@%user%:~$ %ESC%[96mSaluta: %ESC%[0m"
if '%str%' == '' goto mex
if "%str%" == "bye" goto esci
echo %user%: %str%>>chat_%chiave%.txt
timeout /t 2 > nul
start /MIN invia.bat
copy /b chat_%chiave%.txt chat1.txt > nul
cls
timeout /t 1 > nul
start live.bat %chiave%

:chat
title CHAT ONLINE  ^|^|  Programmazione Time ~ ChatBox
mode con: cols=77 lines=22
cd %chat%\chat_%chiave%
cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Per uscire dalla chat scrivi: %ESC%[31mbye%ESC%[0m %ESC%[101;93m[!]%ESC%[0m
echo:_____________________________________________________________________________
echo:
set/p "str=%ESC%[32mChatBox@%user%:~$ %ESC%[96mMessaggio: %ESC%[0m"
if "%str%" == "bye" goto esci
::SPAZIO PER I COMANDI
(echo:%user%: %str%)>>chat_%chiave%.txt
timeout /t 1 > nul
start /MIN invia.bat
goto chat


:: USCITA
:esci
(echo:"%user%" ha appena lasciato la chat)>>chat_%chiave%.txt
timeout /t 1 > nul
fsutil file createNew esci.txt 0 > nul
start /MIN invia.bat
timeout /t 3 > nul
del /q esci.txt
exit

:: AVVISO D'UNIONE ALLA CHAT
:unisciti
title CHAT ONLINE  ^|^|  Programmazione Time ~ Unisciti in Chat
mode con: cols=77 lines=22
cls
(echo:"%user%" si e' appena unito alla chat)>>chat_%chiave%.txt
timeout /T 1 > nul
start /MIN invia.bat
goto :EOF



:: #######################################
:: ------- IMPOSTAZIONI DELLA CHAT -------
:: #######################################

:impostazioni
title CHAT ONLINE  ^|^|  Programmazione Time ~ Impostazioni
mode con: cols=77 lines=20
cd %server%
set x=0
for %%a in (*.*) do set /a x+=1
cd %config%
cls
echo:%ESC%[0m
echo:    _____________________________________________________________________
echo:   ^|                                                                     ^|
echo:   ^|                                                                     ^|
echo:   ^|                  %ESC%[101;93m [!] IMPOSTAZIONI DELLA CHATBOX [!] %ESC%[0m               ^|
echo:   ^|                                                                     ^|
echo:   ^|_____________________________________________________________________^|
echo:
echo:
echo:      %ESC%[101;93m[1]%ESC%[0m Cambia Username (attuale: %ESC%[105;97m %user% %ESC%[0m)
echo:      %ESC%[101;93m[2]%ESC%[0m %ESC%[92mAbilita%ESC%[0m/%ESC%[31mdisabilita%ESC%[0m comandi (comandi attivi:%ESC%[43;97m %comandi% %ESC%[0m)
echo:      %ESC%[101;93m[3]%ESC%[0m Cambia Server (impostato su: %ESC%[103;30m %utente% %ESC%[0m)
echo:      %ESC%[101;93m[4]%ESC%[0m %ESC%[92mAggiungi%ESC%[0m Server (numero attuale:%ESC%[46;97m %x% %ESC%[0m)
echo:      %ESC%[101;93m[5]%ESC%[0m %ESC%[31mElimina%ESC%[0m Server (numero attuale:%ESC%[46;97m %x% %ESC%[0m)
echo:
echo:      %ESC%[101;93m[0]%ESC%[0m Torna indietro
echo:
echo:%ESC%[32m
choice /c 012345 /n /m "ChatBox@%user%:~$ "
if %errorlevel% == 1 echo:%ESC%[0m && goto prendi
if %errorlevel% == 2 echo:%ESC%[0m && goto cambia_username
if %errorlevel% == 3 echo:%ESC%[0m && goto cambia_comandi
if %errorlevel% == 4 echo:%ESC%[0m && goto cambia_server
if %errorlevel% == 5 echo:%ESC%[0m && goto aggiungi_server
if %errorlevel% == 6 echo:%ESC%[0m && goto elimina_server



:: ###############################
:: ------- CAMBIA USERNAME -------
:: ###############################

:cambia_username
title CHAT ONLINE  ^|^|  Programmazione Time ~ Impostazioni: Cambia Username
mode con: cols=77 lines=20
cls
echo:%ESC%[0m
echo:
echo:  [!] Attuale username: %ESC%[105;97m %user% %ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:
:cambia_username2
set/p "usr=%ESC%[32mChatBox@%user%:~$ %ESC%[96mNuovo Username: %ESC%[0m"
if '%usr%' == '' echo: %ESC%[31mUsername non valido.%ESC%[0m && goto cambia_username2
echo:%usr:~0,18%>username.txt
set user=%usr:~0,18%
echo:
echo:
echo:%ESC%[92mUsername cambiato con successo!%ESC%[0m
echo:
pause
goto impostazioni



:: ##########################################
:: ------- ABILITA/DISABILITA COMANDI -------
:: ##########################################

:cambia_comandi
title CHAT ONLINE  ^|^|  Programmazione Time ~ Impostazioni: Abilita/Disabilita Comandi
mode con: cols=77 lines=20
cls
echo:%ESC%[0m
echo:
echo:  [!] Comandi attivi: %ESC%[43;97m %comandi% %ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:%ESC%[32m
choice /c SN /m "ChatBox@%user%:~$ "
if %errorlevel% == 1 (echo:Si)>comandi.txt && set "comandi=Si" && echo:%ESC%[0mComandi abilitati correttamente!
if %errorlevel% == 2 (echo:No)>comandi.txt && set "comandi=No" && echo:%ESC%[0mComandi disabilitati correttamente!
goto impostazioni



:: ###############################
:: ------- CAMBIA SERVER -------
:: ###############################

:cambia_server
title CHAT ONLINE  ^|^|  Programmazione Time ~ Impostazioni: Cambia Server
mode con: cols=77 lines=20
cd %server%
cls
echo:%ESC%[0m
echo:
echo:  [!] Attuale Server impostato: %ESC%[103;30m %utente% %ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:  %ESC%[101;93mServer disponibili:%ESC%[0m
echo:
echo:-----------------------------------------------------------------------------
for %%a in (*.*) do echo:  - %%a
echo:-----------------------------------------------------------------------------
echo:
:cambia_server2
set/p "passa=%ESC%[32mChatBox@%user%:~$ %ESC%[96mNome Server [nome.txt]: %ESC%[0m"
if '%passa%' == '' echo:%ESC%[31mServer non valido.%ESC%[0m && goto cambia_server2

:: PASSA A UN ALTRO SERVER
if not exist %passa% echo:%ESC%[31mServer inesistente.%ESC%[0m && goto cambia_server2
cd %config%
echo:%passa:~0,-4%>config.txt
set utente=%passa:~0,-4%
cls
echo:
echo:
echo:  %ESC%[92mPassaggio al Server %ESC%[103;30m %utente% %ESC%[0m %ESC%[92mcompletato!%ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:
pause
goto impostazioni



:: #######################################
:: ------- AGGIUNGI/RIMUOVI SERVER -------
:: ######################################

:: AGGIUNGI SERVER
:aggiungi_server
title CHAT ONLINE  ^|^|  Programmazione Time ~ Impostazioni: Aggiungi Server
mode con: cols=77 lines=20
cd %server%
cls
echo:%ESC%[0m
echo:
echo:  %ESC%[101;93mInserisci i seguenti dati:%ESC%[0m
echo:_____________________________________________________________________________
echo:
:host
set/p "host=%ESC%[32mChatBox@%user%:~$ %ESC%[96mHost--> %ESC%[0m"
if '%host%' == '' echo:%ESC%[31mHost non valido.%ESC%[0m && goto host
:nome
set/p "nome=%ESC%[32mChatBox@%user%:~$ %ESC%[96mUtente--> %ESC%[0m"
if '%nome%' == '' echo:%ESC%[31mUtente non valido.%ESC%[0m && goto nome
:psw
set/p "psw=%ESC%[32mChatBox@%user%:~$ %ESC%[96mPassword--> %ESC%[0m"
if '%psw%' == '' echo:%ESC%[31mPassword non valida.%ESC%[0m && goto psw
(echo:%host%)>%nome%.txt
(echo:%nome%)>>%nome%.txt
(echo:%psw%)>>%nome%.txt
cd %chat%
mkdir %nome%
cd %nome%
(echo:open %host%)>avvia_%nome%.txt
(echo:%nome%)>>avvia_%nome%.txt
(echo:%psw%)>>avvia_%nome%.txt
:indirizzo
cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Inserisci l'indirizzo del Server %ESC%[101;93m[!]%ESC%[0m
echo:
set /p "link=%ESC%[32mChatBox:~$ %ESC%[96mIndirizzo: %ESC%[0m"
if '%link%' == '' echo:%ESC%[31mIndirizzo non valido.%ESC%[0m && pause && goto indirizzo
(echo:%link%)>link.txt
echo:
echo:
echo:  %ESC%[92mServer%ESC%[0m %ESC%[103;30m %nome% %ESC%[0m %ESC%[92maggiunto correttamente!%ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:
pause
if %utente% == ##vuoto## set "utente=%nome%" && cd %config% && (echo:%nome%)>config.txt
goto impostazioni


:: ELIMINA SERVER
:elimina_server
title CHAT ONLINE  ^|^|  Programmazione Time ~ Impostazioni: Elimina Server
mode con: cols=84 lines=20
cd %server%
cls
echo:%ESC%[0m
echo:
echo:  %ESC%[101;93mServer esistenti:%ESC%[0m
echo:-----------------------------------------------------------------------------
for %%a in (*.*) do echo:  - %%a
echo:-----------------------------------------------------------------------------
echo:
:elimina_server2
set/p "svr=%ESC%[32mChatBox@%user%:~$ %ESC%[96mNome Server [nome.txt]: %ESC%[0m"
if '%svr%' == '' echo:%ESC%[31mServer non valido.%ESC%[0m && goto elimina_server2
if not exist %svr% echo:%ESC%[31mServer inesistente.%ESC%[0m && goto elimina_server2
del /q %svr%
cd %chat%
rd /q /s %svr:~0,-4%
cls
if not exist %utente% (
if not %utente% == ##vuoto## call :cambia_config
)
echo:  %ESC%[92mServer%ESC%[0m %ESC%[103;30m %svr:~0,-4% %ESC%[0m %ESC%[92meliminato correttamente! %ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:
pause
goto impostazioni

:cambia_config
cd %config%
cls
echo:##vuoto##>config.txt
set utente=##vuoto##
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m %ESC%[31mAttento che hai rimosso il server che usavi attualmente.%ESC%[0m %ESC%[101;93m[!]%ESC%[0m
echo:  %ESC%[101;93m[!]%ESC%[0m %ESC%[31mPer usare la ChatBox devi avere un server impostato esistente in lista.%ESC%[0m %ESC%[101;93m[!]%ESC%[0m
echo:
echo:
goto :EOF




:: ####################################
:: ------- INFORMAZIONI CHATBOX -------
:: ####################################

:informazioni
title CHAT ONLINE  ^|^|  Programmazione Time ~ Informazioni
mode con: cols=77 lines=22
cls
echo:%ESC%[0m
echo:    _____________________________________________________________________
echo:   ^|                                                                     ^|
echo:   ^|                                                                     ^|
echo:                   %ESC%[44;97m[ Chat creata da Programmazione Time ]%ESC%[0m
echo:                        %ESC%[44;97m[ Versione ChatBox 2.0.0 ]%ESC%[0m
echo:   ^|                                                                     ^|
echo:   ^|_____________________________________________________________________^|
echo:   \                                                                     /
echo:   /  %ESC%[101;93m[1]%ESC%[0m Vai al mio canale %ESC%[41;97mYouTube%ESC%[0m                                      \
echo:   \  %ESC%[101;93m[2]%ESC%[0m Vai al mio canale %ESC%[46;97mTelegram%ESC%[0m                                     /
echo:   /  %ESC%[101;93m[3]%ESC%[0m Vai al mio profilo %ESC%[105;97mInstagram%ESC%[0m                                   \
echo:   \  %ESC%[101;93m[4]%ESC%[0m Vai al mio profilo %ESC%[42;97mGitHub%ESC%[0m                                      /
echo:   /  %ESC%[101;93m[5]%ESC%[0m Controlla aggiornamenti                                        \
echo:   \                                                                     /
echo:   /  %ESC%[101;93m[0]%ESC%[0m Torna indietro                                                 \
echo:   \                                                                     /
echo:   /_____________________________________________________________________\
echo:%ESC%[32m
choice /c 012345 /n /m "ChatBox@%user%:~$ "
if %errorlevel% == 1 goto main
if %errorlevel% == 2 start https://www.youtube.com/channel/UCDq9FlqxaAZmgoLBgf5KtYA && goto informazioni
if %errorlevel% == 3 start https://t.me/programmazionetime && goto informazioni
if %errorlevel% == 4 start https://www.instagram.com/programmazionetime_official && goto informazioni
if %errorlevel% == 5 start https://github.com/ProgrammazioneTime && goto informazioni
if %errorlevel% == 6 goto novita

:novita
cls
goto informazioni





:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
exit /B 0
