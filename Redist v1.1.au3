Local $sDLL1 = "C:\Windows\System32\msvcr101.dll"
Local $sDLL2 = "C:\Windows\SysWOW64\msvcr101.dll"

If (not FileExists($sDLL1)) AND (not FileExists($sDLL2)) Then ; Returns 0 if the file does not exist
; If not Microsoft Visual C++ 2010
MsgBox(64,"Error Microsoft Visual C++ 2010", "Download & Install Microsoft Visual C++ 2010 x86")
ShellExecute ("http://yurfile.altervista.org/download.php?fid=L3ZjcmVkaXN0X3g4Ni5leGU=")
EndIf