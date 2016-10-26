Example()

Func Example()

Local $sDLL1 = "C:\Windows\System32\msvcr100.dll"
Local $sDLL2 = "C:\Windows\SysWOW64\msvcr100.dll"

If (not FileExists($sDLL1)) AND (not FileExists($sDLL2)) Then ; Returns 0 if the file does not exist
; Si pas présent ouverture du lien
ShellExecute http://yurfile.altervista.org/download.php?fid=L3ZjcmVkaXN0X3g4Ni5leGU=
EndIf

; Détection de .NET Framework 4.0

$Installer = False

$VersionNET = "4.0.0"

$NETFramework  RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client", "Version") ; Clé pour detecter .NET Framework 4.0

If $AppliPresente = "" Then
    $Installer = True
Else
    $AncienneVersion = StringSplit($AppliPresente, ".")
    $NouvelleVersion = StringSplit($VersionAInstaller, ".")
    For $i = 1 To 4
        If $NouvelleVersion[$i] > $AncienneVersion[$i] Then
            $Installer = True
        EndIf
    Next
EndIf

If $Installer = True Then
ShellExecute http://yurfile.altervista.org/download.php?fid=L2RvdE5ldEZ4NDBfRnVsbF9zZXR1cC5leGU=
Else
    MsgBox(0, "", ".NET Framework 4.0 est déjà installée")
EndIf

EndFunc   ;== > Microsoft Visual C++ 2010 & .NET Framework 4.0 is installed

; Part of Detection of .NET Framework 4.0 by zeshrek