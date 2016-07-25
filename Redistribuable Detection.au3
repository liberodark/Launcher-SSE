Example()

Func Example()

Local Const $sDLL = "C:\Windows\System32\msvcr100.dll"  ; Check msvcr100.dll "C:\Windows\SysWOW64\msvcr100.dll à ajouter"

If FileExists($sDLL) = 0 Then ; Returns 0 if the file does not exist

RunWait(@ScriptDir & "\Game\vcredist_x86.exe /passive /norestart") ; Install Microsoft Visual C++ 2010 if 0
; Si pas présent ouverture du lien
; ShellExecute https://www.microsoft.com/en-US/download/details.aspx?id=5555
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
ShellExecute https://www.microsoft.com/en-US/download/details.aspx?id=17851
Else
    MsgBox(0, "", ".NET Framework 4.0 est déjà installée")
EndIf

EndFunc   ;== > Microsoft Visual C++ 2010 & .NET Framework 4.0 is installed

; Part of Detection of .NET Framework 4.0 by zeshrek