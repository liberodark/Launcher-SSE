#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author: liberodark

 Script Function:
	Launcher SSE

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

MsgBox(64, "Launcher", "Lancement du jeu !")
Run ( "Game\SSELauncher.exe -appid 406170", "Game\" )
#include <File.au3>
_ReplaceStringInFile("config.xml", "<Language>French</Language>", "<Language>English</Language>")
Exit
