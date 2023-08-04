; Author: Kay Vogelgesang for ApacheFriends XAMPP win32

;---------------------
;Include Modern UI
   ;!include "MUI.nsh"
   !include "MUI2.nsh"
;--------------------------------


  SetCompressor /solid lzma
  ;;;XPStyle on
  ; HM NIS Edit Wizard helper defines
  !define PRODUCT_NAME "XAMPP School"
  !define PRODUCT_VERSION "1.0.1"
  !define PRODUCT_PUBLISHER "Mohamed Anis MANI, ApacheFriends"
  !define PRODUCT_WEB_SITE "http://www.apachefriends.org"
  !define WORK_DIR "D:\xampp-portable"
  !define WORK_XAMPP_DIR "${WORK_DIR}\xampp-8.2.4"
  Caption "${PRODUCT_NAME} ${PRODUCT_VERSION} Win64"
  InstallDirRegKey HKLM "Software\xampp-school" "Install_Dir"
  Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
  OutFile "${WORK_DIR}\installer\xampp-school-portable-win64-${PRODUCT_VERSION}-VC16-installer.exe"
  RequestExecutionLevel admin
  ;;;BGGradient f87820 FFFFFF FFFFFF
  InstallColors FF8080 000030
  CheckBitmap "${WORK_DIR}\xampp-nsi-installer\icons\classic-cross.bmp"

;--------------------------------

;Remember the installer language
  ;!define MUI_LANGDLL_REGISTRY_ROOT "HKLM"
  ;!define MUI_LANGDLL_REGISTRY_KEY "Software\xampp"
  ;!define MUI_LANGDLL_REGISTRY_VALUENAME "lang"

  !define MUI_ABORTWARNING
  !define MUI_ICON "${WORK_DIR}\xampp-nsi-installer\icons\xampp-icon.ico"
  !define MUI_WELCOMEPAGE
  !define MUI_CUSTOMPAGECOMMANDS
  !define MUI_COMPONENTSPAGE
  !define MUI_COMPONENTSPAGE_NODESC

;Pages
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  ;!insertmacro MUI_UNPAGE_WELCOME
  ;!insertmacro MUI_UNPAGE_CONFIRM
  ;!insertmacro MUI_UNPAGE_INSTFILES
  ;!insertmacro MUI_UNPAGE_FINISH

;Languages
  !insertmacro MUI_LANGUAGE "English" # first language is the default language
  !insertmacro MUI_LANGUAGE "French"

;--------------------------------
;Variables
  Var OPT_MYSQL
  Var OPT_PMA

InstallDir "c:\xampp-school"
Icon "${WORK_DIR}\xampp-nsi-installer\icons\xampp-icon.ico"
; UninstallIcon "${WORK_DIR}\xampp-nsi-installer\icons\xampp-icon-uninstall.ico"
ShowInstDetails show
; ShowUninstDetails show

;Fuctions
Function .onInit
!insertmacro MUI_LANGDLL_DISPLAY

; Missing MS C++ 2008 runtime library warning here
  ReadRegStr $R2 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{FF66E9F6-83E7-3A3E-AF14-8DE9A809A6A4}' DisplayVersion
  ReadRegStr $R3 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{350AA351-21FA-3270-8B7A-835434E766AD}' DisplayVersion
  ReadRegStr $R4 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{2B547B43-DB50-3139-9EBE-37D419E0F5FA}' DisplayVersion

  ReadRegStr $R5 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{9A25302D-30C0-39D9-BD6F-21E6EC160475}' DisplayVersion
  ReadRegStr $R6 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{8220EEFE-38CD-377E-8595-13398D740ACE}' DisplayVersion
  ReadRegStr $R7 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{5827ECE1-AEB0-328E-B813-6FC68622C1F9}' DisplayVersion

  ReadRegStr $R8 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{1F1C2DFC-2D24-3E06-BCB8-725134ADF989}' DisplayVersion
  ReadRegStr $R9 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{4B6C7001-C7D6-3710-913E-5BC23FCE91E6}' DisplayVersion
  ReadRegStr $R0 HKLM 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{977AD349-C2A8-39DD-9273-285C08987C7B}' DisplayVersion

  StrCmp $R2 "" vc16_test2
  GOTO init_end
  vc16_test2:
  StrCmp $R3 "" vc16_test3
  GOTO init_end
  vc16_test3:
  StrCmp $R4 "" vc16_test4
  GOTO init_end
  vc16_test4:
  StrCmp $R5 "" vc16_test5
  GOTO init_end
  vc16_test5:
  StrCmp $R6 "" vc16_test6
  GOTO init_end
  vc16_test6:
  StrCmp $R7 "" vc16_test7
  GOTO init_end
  vc16_test7:
  StrCmp $R8 "" vc16_test8
  GOTO init_end
  vc16_test8:
  StrCmp $R9 "" vc16_test9
  GOTO init_end
  vc16_test9:
  StrCmp $R0 "" no_vc16
  GOTO init_end

  no_vc16:
        StrCmp $LANGUAGE "1031" lang_de
               MessageBox MB_YESNO "Warning: XAMPP (PHP) cannot work without the Microsoft C++ 2017 runtime libraries. Now open the Microsoft page for this download?" IDNO MsPageOut
               ;MessageBox MB_YESNO "MS C++ 2008 runtime package not found! It is required for PHP. Now open the Microsoft site for this download?" IDNO MsPageOut
               ExecShell "open" "https://aka.ms/vs/15/release/vc_redist.x64.exe"
               GOTO MsPageOut
               lang_de:
               MessageBox MB_YESNO "Warnung: XAMPP (PHP) ben�tigt das Microsoft C++ 2017 runtime libraries! Die Microsoft Seite f�r diesen Download jetzt �ffnen?" IDNO MsPageOut
               ; MessageBox MB_YESNO "MS C++ 2008 runtime Installation fehlt auf Ihrem Rechner! Diese wird f�r PHP ben�tigt. Die Microsoft Seite f�r diesen Download jetzt �ffnen?" IDNO MsPageOut
               ExecShell "open" "https://aka.ms/vs/15/release/vc_redist.x64.exe"
        MsPageOut:
               ; StrCmp $LANGUAGE "1031" lang_de2
               ; MessageBox MB_YESNO "Perhaps XAMPP do not work without the MS VC++ 2008 runtime library. Still go on with the XAMPP installation?" IDNO GoOut
               ; GOTO init_end
               ; lang_de2:
               ; MessageBox MB_YESNO "Ohne die MS VC++ 2008 Runtime Bibliothek k�nnte XAMPP nicht funktionieren! Die XAMPP Installation trotzdem weiterf�hren?" IDNO GoOut
               ; GOTO init_end
               ; GoOut:
               ; Abort "Exit by user."
  init_end:

                StrCmp $LANGUAGE "1031" detection_de
                GOTO non_de
                detection_de:
                MessageBox MB_OK "Das Paket ist Wechseldatentr�ger geeignet. Alle Konfigurationsdateien haben relative Pfade."
                GOTO usb_end
                non_de:
                MessageBox MB_OK "This package is removable device compatible. All configuration files have relative paths."
  usb_end:

FunctionEnd


Function WriteToFile
Exch $0 ;file to write to
Exch
Exch $1 ;text to write

  FileOpen $0 $0 a #open file
  FileSeek $0 0 END #go to end
  FileWrite $0 $1 #write to file
  FileClose $0

Pop $1
Pop $0
FunctionEnd

!macro WriteToFile NewLine File String
  !if `${NewLine}` == true
  Push `${String}$\r$\n`
  !else
  Push `${String}`
  !endif
  Push `${File}`
  Call WriteToFile
!macroend
!define WriteToFile `!insertmacro WriteToFile false`
!define WriteLineToFile `!insertmacro WriteToFile true`


Function .onInstSuccess

;CopyFiles "$INSTDIR\xampp_control3.ini" "$INSTDIR\xampp_control3.ini"
;Delete "$INSTDIR\xampp_control3.ini"


StrCmp $OPT_MYSQL "" no_mysql
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `MySQL=1`
Goto mysql_out
no_mysql:
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `MySQL=0`
Delete "$INSTDIR\mysql_start.bat"
Delete "$INSTDIR\mysql_stop.bat"
mysql_out:

StrCmp $OPT_PMA "" no_pma
Goto pma_out
no_pma:
; Delete "$INSTDIR\htdocs\xampp\navilinks\01_phpmyadmin.tools-usb"
pma_out:

FunctionEnd

Section "-XAMPP Files"
SetOverwrite ifnewer
SetOutPath "$INSTDIR"
File "${WORK_XAMPP_DIR}\setup_xampp.bat"
File "${WORK_XAMPP_DIR}\readme_en.txt"
File "${WORK_XAMPP_DIR}\xampp_control3.exe"
File "${WORK_XAMPP_DIR}\xampp_control3.ini"
File "${WORK_XAMPP_DIR}\xampp_start.exe"
File "${WORK_XAMPP_DIR}\xampp_stop.exe"
File "${WORK_XAMPP_DIR}\apache_start.bat"
File "${WORK_XAMPP_DIR}\apache_stop.bat"
File "${WORK_XAMPP_DIR}\mysql_start.bat"
File "${WORK_XAMPP_DIR}\mysql_stop.bat"
File "${WORK_XAMPP_DIR}\passwords.txt"
File "${WORK_XAMPP_DIR}\readme_de.txt"
File "${WORK_XAMPP_DIR}\test_php.bat"


SetOutPath "$INSTDIR\dbdump"
File /r "${WORK_XAMPP_DIR}\dbdump\*.*"
SetOutPath "$INSTDIR\htdocs"
File /r "${WORK_XAMPP_DIR}\htdocs\*.*"
SetOutPath "$INSTDIR\install"
File /r "${WORK_XAMPP_DIR}\install\*.*"
SetOutPath "$INSTDIR\locale"
File /r "${WORK_XAMPP_DIR}\locale\*.*"
SetOutPath "$INSTDIR\tmp"
File /nonfatal /r "${WORK_XAMPP_DIR}\tmp\*.*"

${WriteLineToFile} `$INSTDIR\xampp_control3.ini` ``
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `[Common]`
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Edition=Beta 4`
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Editor=notepad.exe`
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Browser=`
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Debug=0`
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Debuglevel=0`

StrCmp $LANGUAGE "1031" lang_de
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Language=en`
Goto lang_out
lang_de:
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Language=de`
lang_out:

${WriteLineToFile} `$INSTDIR\xampp_control3.ini` ` `
SectionEnd


SectionGroup "Server"
Section "Apache"
SetOverwrite ifnewer
SetOutPath "$INSTDIR\apache"
File /r "${WORK_XAMPP_DIR}\apache\*.*"
SectionIn RO
${WriteLineToFile} `$INSTDIR\xampp_control3.ini` `Apache=1`
SectionEnd

Section "MySQL"
SetOverwrite ifnewer
SetOutPath "$INSTDIR\mysql"
File /r "${WORK_XAMPP_DIR}\mysql\*.*"
StrCpy $OPT_MYSQL "true"
SectionEnd
SectionGroupEnd

SectionGroup "Program languages"
Section "PHP"
SetOverwrite ifnewer
SetOutPath "$INSTDIR\php"
File /r "${WORK_XAMPP_DIR}\php\*.*"
SectionIn RO
SectionEnd
SectionGroupEnd


SectionGroup "Tools"
Section "phpMyAdmin"
SetOverwrite ifnewer
SetOutPath "$INSTDIR\phpmyadmin"
File /r "${WORK_XAMPP_DIR}\phpmyadmin\*.*"
StrCpy $OPT_PMA "true"
SectionEnd
SectionGroupEnd

Section "-XAMPPSETUP"
SetOutPath "$INSTDIR"
ExecWait '"$INSTDIR\php\php.exe" -n -d output_buffering=0 "$INSTDIR\install\install.php" usb' $0
StrCmp $0 "0" php_done
       StrCmp $LANGUAGE "1031" lang_de
              MessageBox MB_OK "Installation failed (php.exe). Perhaps you have to install the Microsoft Visual C++ 2008 Redistributable package. After that please execute the setup_xampp.bat in the xampp folder manually."
              GOTO php_done
        lang_de:
              MessageBox MB_OK "Installation gescheitert. Vielleicht sollten Sie das Microsoft Visual C++ 2008 Redistributable Paket auf Ihrem System installieren. Bitte danach die setup_xampp.bat manuell noch einmal ausf�hren."
php_done:
SectionEnd

