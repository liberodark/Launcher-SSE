#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author: liberodark

 Script Function:
	Launcher SSE

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <File.au3>

MsgBox(64, "Launcher", "Lancement du jeu !")
Run ( "Game\SSELauncher.exe -appid 406170", "Game\" )
_ReplaceStringInFile("Game\config.xml", "<Language>English</Language>", "<Language>French</Language>")
Exit
