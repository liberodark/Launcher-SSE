#include <MsgBoxConstants.au3>

_Reset()

Func _Reset()
	; Supprime le fichier INI.
    FileDelete("Game\ALI213.ini")

    ; Crée une structure de section INI sous forme de chaîne.
    Local $sSection = "PlayerName = liberodark" & @CRLF & "Language = French" & @CRLF & "SaveType = 1" & @CRLF & "AppID = 383120" & @CRLF & "API = 2.89.45.4"

    ; Écrit la chaîne dans le sections intitulées 'General', 'Version' et 'Other'.
    IniWriteSection("Game\ALI213.ini", "Settings", $sSection)

    ; Lit les noms des sections INI. Ce qui renvoie un tableau à 1 dimension.
    Local $aArray = IniReadSectionNames("Game\ALI213.ini")

    ; Vérifie si une erreur s'est produite.
    If Not @error Then
        ; Énumére le tableau où figurent les noms des sections.
        For $i = 1 To $aArray[0]
            MsgBox($MB_SYSTEMMODAL, "", "Reset: " & $aArray[$i])
        Next
    EndIf
EndFunc   ;==> _Reset