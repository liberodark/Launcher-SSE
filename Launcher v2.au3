#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.14.2
	Author: liberodark

	Script Function:
	Launcher SSE

#ce ----------------------------------------------------------------------------

#include <GuiConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <File.au3>
#Region GLOBAL VARIABLES
Global $iW = 600, $iH = 400, $iT = 52, $iB = 52, $iLeftWidth = 150, $iGap = 10, $hMainGUI
Global $sXMLPath = "Game\config.xml" ; added by blacksoul305
#EndRegion GLOBAL VARIABLES

_MainGui()

Func _MainGui()
	Local $hFooter, $nMsg, $aPos
	Local $iLinks = 6
	Local $sMainGuiTitle = "Launcher SSE"
	Local $sHeader = "Open Source Launcher (v2.0.2)"
	Local $sFooter = "2016 © liberodark"
	Local $aLink[$iLinks], $aPanel[$iLinks]
	$aLink[0] = $iLinks - 1
	$aPanel[0] = $iLinks - 1
	$hMainGUI = GUICreate($sMainGuiTitle, $iW, $iH, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_MAXIMIZEBOX, $WS_TABSTOP))
	GUISetIcon("shell32.dll", -58, $hMainGUI)

	GUICtrlCreateLabel($sHeader, 48, 8, $iW - 56, 32, $SS_CENTERIMAGE)
	GUICtrlSetFont(-1, 14, 800, 0, "Arial", 5)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

	GUICtrlCreateIcon("shell32.dll", -131, 8, 8, 32, 32)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("", 0, $iT, $iW, 2, $SS_SUNKEN);separator
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("", $iLeftWidth, $iT + 2, 2, $iH - $iT - $iB - 2, $SS_SUNKEN);separator
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH)
	GUICtrlCreateLabel("", 0, $iH - $iB, $iW, 2, $SS_SUNKEN);separator
	GUICtrlSetResizing(-1, $GUI_DOCKBOTTOM + $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKHEIGHT)

	$hFooter = GUICtrlCreateLabel($sFooter, 10, $iH - 34, $iW - 20, 17, BitOR($SS_LEFT, $SS_CENTERIMAGE))
	GUICtrlSetTip(-1, "GitHub", "Click to open...")
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKBOTTOM + $GUI_DOCKHEIGHT)

	;add links to the left side
	$aLink[1] = _AddNewLink("Pseudo")
	$aLink[2] = _AddNewLink("Language", -14)
	$aLink[3] = _AddNewLink("Options", -22)
	$aLink[4] = _AddNewLink("Launch Game", -12)
	$aLink[5] = _AddNewLink("Credit", -222)

	;and the corresponding GUI's
	$aPanel[1] = _AddNewPanel("Enter your Pseudo")
	$aPanel[2] = _AddNewPanel("Chose your Language")
	$aPanel[3] = _AddNewPanel("Options")
	$aPanel[4] = _AddNewPanel("Launch Game")
	$aPanel[5] = _AddNewPanel("Credits")

	;add some controls to the panels
	_AddControlsToPanel($aPanel[1])
	GUICtrlCreateLabel("Name", 8, 38, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $sXMLPath = "Game\config.xml"
	Local $currentname = "your name here"  ; nom par défaut
	If FileExists($sXMLPath) Then
    $currentname = StringRegExpReplace(FileRead($sXMLPath), '(?s).*?<PersonaName>([^<]+).*', "$1")
	EndIf
	Local $hInput1 = GUICtrlCreateInput($currentname, 56, 35, 121, 21)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton1 = GUICtrlCreateButton("Ok", 180, 33, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

	_AddControlsToPanel($aPanel[2])
	GUICtrlCreateLabel("Languages", 8, 38, 56, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Global $Combo1 = GUICtrlCreateCombo("", 76, 35, 121, 21, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
	GUICtrlSetData($Combo1, "Arabic|Brazilian|Bulgarian|Croatian|Czech|Danish|Dutch|English|Estonian|Finnish|French|German|Greek|Hungarian|Italian|Japanese|Koreana|Lithuanian|Norwegian|Polish|Portuguese|Russian|Romanian|Serbian|Simplified Chinese|Spanish|Swedish|Thai|Traditional Chinese|Turkish|Ukrainian", "French")
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton2 = GUICtrlCreateButton("Ok", 200, 33, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

	_AddControlsToPanel($aPanel[3])
	GUICtrlCreateLabel("Config", 8, 40, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton5 = GUICtrlCreateButton("Save", 56, 35, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton6 = GUICtrlCreateButton("Restore", 150, 35, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("Steam", 8, 70, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton7 = GUICtrlCreateButton("Online", 56, 65, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton8 = GUICtrlCreateButton("Offline", 150, 65, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("Online", 8, 100, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton9 = GUICtrlCreateButton("On", 56, 95, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton10 = GUICtrlCreateButton("Off", 150, 95, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("Overlay", 8, 130, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton11 = GUICtrlCreateButton("On", 56, 125, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton12 = GUICtrlCreateButton("Off", 150, 125, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("VR", 8, 160, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton13 = GUICtrlCreateButton("On", 56, 155, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton14 = GUICtrlCreateButton("Off", 150, 155, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("Plugins", 8, 190, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton15 = GUICtrlCreateButton("Remove", 56, 185, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("Reset", 8, 220, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton16 = GUICtrlCreateButton("Reset", 56, 215, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateLabel("Appid", 8, 250, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $sXMLPath = "Game\config.xml"
	If FileExists($sXMLPath) Then
    $currentappid = StringRegExpReplace(FileRead($sXMLPath), '(?s).*?<AppId>([^<]+).*', "$1")
	EndIf
	Local $hInput2 = GUICtrlCreateInput($currentappid, 56, 245, 75, 25)
	Local $sXMLPath = "Game\config.xml"
	If FileExists($sXMLPath) Then
    $currentappid = StringRegExpReplace(FileRead($sXMLPath), '(?s).*?<AppId>([^<]+).*', "$1")
	EndIf
	Local $hInput3 = GUICtrlCreateInput($currentappid, 150, 245, 75, 25)
	Local $hButton17 = GUICtrlCreateButton("Save", 240, 245, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

	;add some controls to the panels
	_AddControlsToPanel($aPanel[4])
	GUICtrlCreateLabel("Select", 8, 40, 36, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton3 = GUICtrlCreateButton("32bit", 56, 35, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Local $hButton4 = GUICtrlCreateButton("64Bit", 150, 35, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

	_AddControlsToPanel($aPanel[5])
	GUICtrlCreateEdit("", 10, 37, $iW - $iLeftWidth + 2 - 20 - 5, $iH - $iT - $iB - 40, BitOR($ES_AUTOVSCROLL, $ES_NOHIDESEL, $ES_WANTRETURN, $WS_VSCROLL), $WS_EX_STATICEDGE)
	Local $sTestTxt = ""
	For $i = 1 To 1
		$sTestTxt &= @TAB & "liberodark - Dev" & @CRLF
		$sTestTxt &= @TAB & "orax - Helper" & @CRLF
		$sTestTxt &= @TAB & "Teckos - Helper" & @CRLF
		$sTestTxt &= @TAB & "taietel - GUI Template" & @CRLF
		$sTestTxt &= @TAB & "blacksoul305 - Helper" & @CRLF
		$sTestTxt &= @TAB & "mikell - Helper" & @CRLF
	Next
	GUICtrlSetData(-1, $sTestTxt)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKBOTTOM)

	;set default to Panel1
	GUISwitch($aPanel[1])
	;show the main GUI
	GUISetState(@SW_SHOW, $hMainGUI)

	While 1
		Sleep(10)
		FileCopy("Game\config.xml", "Game\config.xml.save") ; backup
		$nMsg = GUIGetMsg(1)
		Switch $nMsg[1]
			Case $hMainGUI
				Switch $nMsg[0]
					Case $GUI_EVENT_CLOSE
						Exit
					Case $GUI_EVENT_MINIMIZE, $GUI_EVENT_MAXIMIZE, $GUI_EVENT_RESTORE
						$aPos = WinGetPos($hMainGUI)
						$iW = $aPos[2]
						$iH = $aPos[3]
						For $i = 0 To $aPanel[0]
							WinMove($aPanel[$i], "", $iLeftWidth + 2, $iT, $iW - $iLeftWidth + 2, $iH - $iT - $iB - 20)
						Next
					Case $aLink[1], $aLink[2], $aLink[3], $aLink[4], $aLink[5]
						For $i = 1 To $aLink[0]
							If $nMsg[0] = $aLink[$i] Then
								GUISetState(@SW_SHOW, $aPanel[$i])
							Else
								GUISetState(@SW_HIDE, $aPanel[$i])
							EndIf
						Next
					Case $hFooter
						ShellExecute("https://github.com/liberodark/Launcher-SSE")
				EndSwitch
			Case $aPanel[1] ; added by blacksoul305
				Switch $nMsg[0]
					Case $hButton1
						_SetName(GUICtrlRead($hInput1), $sXMLPath)
				EndSwitch
			Case $aPanel[2] ; from balcksoul305 : if $aPanel[2] represents Language section, why trying to handle events from controls based on $aPanel[1]?
				Switch $nMsg[0]
					Case $hButton2 ; Added by blacksoul305
						_SetLanguage(GUICtrlRead($Combo1), $sXMLPath)
				EndSwitch
			Case $aPanel[4]
				Switch $nMsg[0]
					Case $hButton3
						Run("Game\ -appid 394690", "Game\")
						Exit
					Case $hButton4
						Run("Game\SSELauncher.exe -appid 394690", "Game\")
						Exit
				EndSwitch
			Case $aPanel[3]
				Switch $nMsg[0]
					Case $hButton5
						FileCopy("Game\config.xml", "Game\config.xml.bak") ; backup
						MsgBox(64, "Launcher SSE", "Saved !")
					Case $hButton6
						FileCopy("Game\config.xml.bak", "Game\config.xml", $FC_OVERWRITE) ; restore
						MsgBox(64, "Launcher SSE", "Restored !")
					Case $hButton7
						_ReplaceStringInFile("Game\config.xml", "<Offline>-1</Offline>", "<Offline>0</Offline>") ; Steam Online
						_ReplaceStringInFile("Game\config.xml", "<Offline>1</Offline>", "<Offline>0</Offline>")
						MsgBox(64, "Launcher SSE", "Actived !")
					Case $hButton8
						_ReplaceStringInFile("Game\config.xml", "<Offline>0</Offline>", "<Offline>1</Offline>") ; Steam Offline
						MsgBox(64, "Launcher SSE", "Desactived !")
					Case $hButton9
						_ReplaceStringInFile("Game\config.xml", "<EnableOnlinePlay>-1</EnableOnlinePlay>", "<EnableOnlinePlay>1</EnableOnlinePlay>") ; Online On
						_ReplaceStringInFile("Game\config.xml", "<EnableOnlinePlay>0</EnableOnlinePlay>", "<EnableOnlinePlay>1</EnableOnlinePlay>")
						MsgBox(64, "Launcher SSE", "Actived !")
					Case $hButton10
						_ReplaceStringInFile("Game\config.xml", "<EnableOnlinePlay>1</EnableOnlinePlay>", "<EnableOnlinePlay>0</EnableOnlinePlay>") ; Online Off
						MsgBox(64, "Launcher SSE", "Desactived !")
					Case $hButton11
						_ReplaceStringInFile("Game\config.xml", "<EnableOverlay>-1</EnableOverlay>", "<EnableOverlay>1</EnableOverlay>") ; Overlay On
						_ReplaceStringInFile("Game\config.xml", "<EnableOverlay>0</EnableOverlay>", "<EnableOverlay>1</EnableOverlay>")
						MsgBox(64, "Launcher SSE", "Actived !")
					Case $hButton12
						_ReplaceStringInFile("Game\config.xml", "<EnableOverlay>1</EnableOverlay>", "<EnableOverlay>0</EnableOverlay>") ; Overlay Off
						MsgBox(64, "Launcher SSE", "Desactived !")
					Case $hButton13
						_ReplaceStringInFile("Game\config.xml", "<VR>-1</VR>", "<VR>1</VR>") ; VR On
						_ReplaceStringInFile("Game\config.xml", "<VR>0</VR>", "<VR>1</VR>")
						MsgBox(64, "Launcher SSE", "Actived !")
					Case $hButton14
						_ReplaceStringInFile("Game\config.xml", "<VR>1</VR>", "<VR>0</VR>") ; VR Off
						MsgBox(64, "Launcher SSE", "Desactived !")
					Case $hButton15
						MsgBox(64, "Launcher SSE", "Remove plugins remove overlay and online options !")
						DirRemove("Game\SmartSteamEmu\SmartSteamEmu\Plugins", $DIR_REMOVE) ; Remove plugins
						MsgBox(64, "Launcher SSE", "Removed !")
					Case $hButton16
						MsgBox(64, "Launcher SSE", "Reset Configuration remove name and other options !")
						FileCopy("Game\config.xml.save", "Game\config.xml", $FC_OVERWRITE) ; restore / Reset
						MsgBox(64, "Launcher SSE", "Success !")
				EndSwitch
		EndSwitch
	WEnd
EndFunc   ;==>_MainGui

Func _AddNewLink($sTxt, $iIcon = -44)
	Local $hLink = GUICtrlCreateLabel($sTxt, 36, $iT + $iGap, $iLeftWidth - 46, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	GUICtrlCreateIcon("shell32.dll", $iIcon, 10, $iT + $iGap, 16, 16)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	$iGap += 22
	Return $hLink
EndFunc   ;==>_AddNewLink

Func _AddNewPanel($sTxt)
	Local $gui = GUICreate("", $iW - $iLeftWidth + 2, $iH - $iT - $iB, $iLeftWidth + 2, $iT, $WS_CHILD + $WS_VISIBLE, -1, $hMainGUI)
	GUICtrlCreateLabel($sTxt, 10, 10, $iW - $iLeftWidth - 20, 17, $SS_CENTERIMAGE)
	GUICtrlSetFont(-1, 9, 800, 4, "Arial", 5)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
	Return $gui
EndFunc   ;==>_AddNewPanel

Func _AddControlsToPanel($hPanel)
	GUISwitch($hPanel)
EndFunc   ;==>_AddControlsToPanel

;~ -------------------------------------------------------------------------
;~ ------------------	Added by blakcsoul305 ------------------------------
;~ -------------------------------------------------------------------------

Func _SetLanguage($sLanguage, $sFilePath)
;~ 	MsgBox(64, "_SetLanguage", "Inputs are : " & @CRLF & " - " & $sLanguage & @CRLF & " - " & $sFilePath & @CRLF)
	Local $fFile, $sBuff = "", $sNewLine, $bEnd = false, $iCurrentLine = 1

	$fFile = FileOpen($sFilePath, 0) ; reading only
	Do
		$sBuff = FileReadLine($fFile)
		if (StringRegExp($sBuff,"\<Language\>.*\<\/Language\>")) Then ; <Language></Language> found
			$sNewLine = StringRegExpReplace($sBuff,"\<Language\>.*\<\/Language\>", "<Language>" & $sLanguage & "</Language>")
			_FileWriteToLine($sFilePath, $iCurrentLine, $sNewLine, True)
			$bEnd = True
		EndIf
		$iCurrentLine+=1
	Until ($bEnd)

	FileClose($fFile)
EndFunc

Func _SetName($sName, $sFilePath)
	Local $fFile, $sBuff = "", $sNewLine, $bEnd = false, $iCurrentLine = 1

	$fFile = FileOpen($sFilePath, 0) ; reading only
	Do
		$sBuff = FileReadLine($fFile)
		if (StringRegExp($sBuff,"\<PersonaName\>.*\<\/PersonaName\>")) Then
			$sNewLine = StringRegExpReplace($sBuff,"\<PersonaName\>.*\<\/PersonaName\>", "<PersonaName>" & $sName & "</PersonaName>")
			_FileWriteToLine($sFilePath, $iCurrentLine, $sNewLine, True)
			$bEnd = True
		EndIf
		$iCurrentLine+=1
	Until ($bEnd)

	FileClose($fFile)
EndFunc