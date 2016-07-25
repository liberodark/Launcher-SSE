Example()

Func Example()

Local Const $sDLL = "C:\Windows\System32\msvcr100.dll"  ; Check msvcr100.dll "C:\Windows\SysWOW64\msvcr100.dll à ajouter"

If FileExists($sDLL) = 0 Then ; Returns 0 if the file does not exist

RunWait(@ScriptDir & "\Game\vcredist_x86.exe /passive /norestart") ; Install Microsoft Visual C++ 2010 if 0
; Si pas présent ouverture du lien
; https://www.microsoft.com/en-US/download/details.aspx?id=5555
EndIf

EndFunc   ;== > Microsoft Visual C++ 2010 is installed

; Détection de .NET Framework 4.0

; HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client (Clé pour detecter .NET Framework 4.0)

; Si pas installé ouverture du lien de téléchargement
; https://www.microsoft.com/en-US/download/details.aspx?id=17851