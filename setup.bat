@echo off
title CHAT ONLINE  ^|^|  Programmazione Time ~ Installazione Chat
mode con: cols=77 lines=22

setlocal
call :setESC



:: ############################################
:: ------- VARIABILI PERCORSI DIRECTORY -------
:: ############################################

cd\
set mypath=%cd%
set chat_batch=%mypath%chat_batch
set chat=%chat_batch%\chat
set config=%chat_batch%\config
set server=%chat_batch%\server


:: ####################################
:: ------- CONTROLLO Chat_Batch -------
:: ####################################

if not exist chat_batch (
    mkdir chat_batch
)
cd chat_batch



:: ########################################
:: ------- INSTALLAZIONE DELLA CHAT -------
:: ########################################

cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Creazione della cartella %ESC%[43;97m chat_batch %ESC%[0m %ESC%[101;93m[!]%ESC%[0m
echo:
echo:  %ESC%[32mProcesso:%ESC%[0m 20%% %ESC%[107;30m^[^|^|^|^|                ^]%ESC%[0m
echo:
mkdir server
mkdir config
mkdir chat
timeout /t 2 /nobreak > nul

cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Creazione sottocartella %ESC%[43;97m server %ESC%[0m %ESC%[101;93m[!]%ESC%[0m
echo:
echo:  %ESC%[32mProcesso:%ESC%[0m 40%% ^[^|^|^|^|^|^|^|^|            ^]%ESC%[0m
echo:_____________________________________________________________________________
echo:
echo:   %ESC%[4mInserisci i seguenti dati%ESC%[0m:
echo:
:host
set/p "host=%ESC%[32mChatBox:~$ %ESC%[96mHost: %ESC%[0m"
if '%host%' == '' echo:%ESC%[31mNome host non valido.%ESC%[0m && goto host
:nome
set/p "utente=%ESC%[32mChatBox:~$ %ESC%[96mUtente: %ESC%[0m"
if '%utente%' == '' echo:%ESC%[31mUtente non valido.%ESC%[0m && cd %server% && goto nome
:psw
set/p "psw=%ESC%[32mChatBox:~$ %ESC%[96mPassword: %ESC%[0m"
if '%psw%' == '' echo:%ESC%[31mPassword non valida.%ESC%[0m && cd %server% && goto psw
echo:
echo:  Server impostato correttamente!
echo:
echo:
timeout /t 2 /nobreak > nul

cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Attendi la configurazione del server %ESC%[101;93m[!]%ESC%[0m
echo:
echo:  %ESC%[32mProcesso:%ESC%[0m 60%% ^[^|^|^|^|^|^|^|^|^|^|^|^|        ^]%ESC%[0m
echo:
echo:
cd %server%
(echo:%host%)>%utente%.txt
(echo:%utente%)>>%utente%.txt
(echo:%psw%)>>%utente%.txt
cd %chat%
mkdir %utente%
cd %utente%
(echo:open %host%)>avvia_%utente%.txt
(echo:%utente%)>>avvia_%utente%.txt
(echo:%psw%)>>avvia_%utente%.txt
timeout /t 2 /nobreak > nul

:link
cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Inserisci l'indirizzo del Server %ESC%[101;93m[!]%ESC%[0m
echo:
echo:  %ESC%[32mProcesso:%ESC%[0m 80%% ^[^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|    ^]%ESC%[0m
echo:
set /p "link=%ESC%[32mChatBox:~$ %ESC%[96mIndirizzo: %ESC%[0m"
if '%link%' == '' echo:%ESC%[31mIndirizzo non valido.%ESC%[0m && pause && goto username
(echo:%link%)>link.txt
echo:
echo:
timeout /t 2 /nobreak > nul

:username
cls
echo:
echo:
echo:  %ESC%[101;93m[!]%ESC%[0m Crea il tuo personale Username %ESC%[101;93m[!]%ESC%[0m
echo:
echo:  %ESC%[32mProcesso:%ESC%[0m 100%% ^[^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|^|^]%ESC%[0m
echo:
set/p "user=%ESC%[32mChatBox:~$ %ESC%[96mUsername: %ESC%[0m"
if '%user%' == '' echo:%ESC%[31mUsername non valido.%ESC%[0m && pause && goto username
cd %config%
(echo:%user%)>username.txt
(echo:Si)>comandi.txt
(echo:%utente%)>config.txt
echo:
echo:
pause
exit

:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
exit /B 0