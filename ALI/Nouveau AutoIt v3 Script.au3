#include <MsgBoxConstants.au3>

Example()

Func Example()
    ; Ecrit la valeur "AutoIt" à la clé "Title" et dans la section "General".
    IniWrite(@TempDir & "\Example.ini", "General", "Title", "AutoIt")

    ; Lit le fichier INI pour la valeur "Title" dans la section "General".
    Local $sRead = IniRead(@TempDir & "\Example.ini", "General", "Title", "Default Value")

    ; Affiche la valeur retournée par IniRead.
    MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title'in the section labelled 'General'is: " & $sRead)

    ; Supprime la clé portant la mention "Titre".
    IniDelete(@TempDir & "\Example.ini", "General", "Title")

    ;Lire le fichier INI pour la valeur de 'Titre'dans la section «Général».
    $sRead = IniRead(@TempDir & "\Example.ini", "General", "Title", "Default Value")

    ; Affiche la valeur retournée par IniRead. Comme il n'y a pas de clé stocké la valeur sera la 'Valeur par défaut 'passé à IniRead.
    MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title'in the section labelled 'General'is: " & $sRead)

    ;Supprimez le fichier INI.
    FileDelete(@TempDir & "\Example.ini")
EndFunc   ;==> Example
