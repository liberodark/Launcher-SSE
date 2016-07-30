#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.14.2
	Author: liberodark

	Script Function:
	Launcher SSE

#ce ----------------------------------------------------------------------------

#include <GuiConstants.au3>
#include <File.au3>
#include <7zaExe.au3>
#include <InetConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Global $sXMLPath = "Game\config.xml"
If Not FileExists($sXMLPath) Then Exit MsgBox(48, "error", "config.xml absent")

Global $savedXML = "Game\config.xml.save"
If Not FileExists($savedXML) Then FileCopy($sXMLPath, $savedXML) ; backup in launch
Global $backupXML = "Game\config.xml.bak"
If Not FileExists($backupXML) Then FileCopy($savedXML, $backupXML)

Global $PluginsDir = "Game\SmartSteamEmu\SmartSteamEmu\Plugins"
Global $PluginsDirBak = "Game\SmartSteamEmu\SmartSteamEmu\PluginsBak"

Global $iW = 500, $iH = 400, $iT = 52, $iB = 27, $iLeftWidth = 150, $iGap = 10, $hMainGUI, $modified = 0

; ==================
; read xml
$sXMLContent = FileRead($sXMLPath)

$currentname = StringRegExpReplace($sXMLContent, '(?s).*?<PersonaName>([^<]+).*', "$1")
$currentlang = StringRegExpReplace($sXMLContent, '(?s).*?<Language>([^<]+).*', "$1")
$currentVR = StringRegExpReplace($sXMLContent, '(?s).*?<VR>([^<]+).*', "$1")
$currentSteam = StringRegExpReplace($sXMLContent, '(?s).*?<Offline>([^<]+).*', "$1")
$currentOnlinePlay = StringRegExpReplace($sXMLContent, '(?s).*?<EnableOnlinePlay>([^<]+).*', "$1")
$currentOverlay = StringRegExpReplace($sXMLContent, '(?s).*?<EnableOverlay>([^<]+).*', "$1")
$currentSteamId = StringRegExpReplace($sXMLContent, '(?s).*?<SteamIdGeneration>([^<]+).*', "$1")
$currentappid = StringRegExpReplace($sXMLContent, '(?s).*?<AppId>([^<]+).*', "$1")

$currentappid1 = ""
; test 2 appid <AppId>
StringReplace($sXMLContent, '<AppId>', '<AppId>')
$nbAppid = @extended
If $nbAppid = 2 Then $currentappid1 = StringRegExpReplace($sXMLContent, '(?s).*<AppId>([^<]+).*', "$1")

; ==================
; Redistribuable Detection

; Check msvcr100.dll
Local $sDLL1 = "C:\Windows\System32\msvcr100.dll"
Local $sDLL2 = "C:\Windows\SysWOW64\msvcr100.dll"

If (not FileExists($sDLL1)) AND (not FileExists($sDLL2)) Then ; Returns 0 if the file does not exist
; If not detect Microsoft Visual C++ 2010
MsgBox(64,"Error Microsoft Visual C++ 2010", "Download & Install Microsoft Visual C++ 2010 x86")
ShellExecute ("https://www.microsoft.com/en-US/download/details.aspx?id=5555")
Exit
EndIf

; ==================
; update launcher

If _CheckVersion() = "1" Then
   MsgBox(0, "Update", "New version downloaded")
   Exit
EndIf

Func _CheckVersion()
	; read dat in server
	Local $remotedat = BinaryToString(InetRead("http://yurfile.altervista.org/download.php?fid=L3ZlcnNpb24udHh0"))
	If @error Then Return 0 ; error
	Local $lastversion = StringRegExp($remotedat, 'version=(\N+)', 1)[0] ; exemple 2.0.5
	; read dat in local
	$localdat = FileRead("version.dat")
	Local $currentversion = StringRegExp($localdat, 'version=(\N+)', 1)[0] ; exemple 2.0.4
	; compare versions
	If StringReplace($currentversion, ".", "") < StringReplace($lastversion, ".", "") Then ; ex. si 204 < 205
		If MsgBox(36, "Update", "Have new version" & @CRLF & "Download ?") = 6 Then
			$adresse = StringRegExp($remotedat, 'adresse=(\N+)', 1)[0]
			InetGet($adresse, @ScriptDir & "\Launcher_v." & $lastversion & ".exe")

			; ====== update sse ========

    ; Save the downloaded file to the temporary folder.
    Local $sFilePath = @ScriptDir & "\Game\update.7z"

    ; Download the file in the background with the selected option of 'force a reload from the remote site.'
    Local $hDownload = InetGet("http://yurfile.altervista.org/download.php?fid=L3VwZGF0ZS43eg==", $sFilePath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

    ; Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
    Do
        Sleep(250)
    Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)

    ; Retrieve details about the download file.
    Local $aData = InetGetInfo($hDownload)
    If @error Then
        FileDelete($sFilePath)
        Return False ; If an error occurred then return from the function and delete the file.
    EndIf

MsgBox(64,"Success", "Download")
FileDelete("Game\SSELauncher.exe")
DirRemove("Game\SmartSteamEmu", 1)
MsgBox(64,"Success", "Remove")

$7zaPath = @ScriptDir & "\Game\7za.exe"
$Archive = @ScriptDir & "\Game\update.7z"

$Res = _Extract7zaExe($7zaPath, $Archive, @ScriptDir&"\Game", 1)
MsgBox(64,"Success", "Extract")

    ; Close the handle returned by InetGet.
    InetClose($hDownload)

    ; Display details about the downloaded file.
    MsgBox($MB_SYSTEMMODAL, "", "Bytes read: " & $aData[$INET_DOWNLOADREAD] & @CRLF & _
            "Size: " & $aData[$INET_DOWNLOADSIZE] & @CRLF & _
            "Complete: " & $aData[$INET_DOWNLOADCOMPLETE] & @CRLF & _
            "successful: " & $aData[$INET_DOWNLOADSUCCESS] & @CRLF & _
            "error: " & $aData[$INET_DOWNLOADERROR] & @CRLF & _
            "extended: " & $aData[$INET_DOWNLOADEXTENDED] & @CRLF)

    ; Delete the file.
    FileDelete($sFilePath)

	; Modify the dat file.
	If Not @error Then
		IniWrite("version.dat", "OpenSourceLauncher", "version", $lastversion)
				Return 1 ; ok
			EndIf
		EndIf
	EndIf
	Return 0 ; error
EndFunc   ;==>_CheckVersion



; ====== gui ========

$hMainGUI = GUICreate("Launcher SSE", $iW, $iH, -1, 150)
<<<<<<< HEAD
GUISetIcon("steam.ico", -58, $hMainGUI)
GUICtrlCreateLabel("Open Source Launcher 2.1.0 Build 1", 48, 8, $iW - 56, 32, $SS_CENTERIMAGE)
=======
GUISetIcon("shell32.dll", -58, $hMainGUI)
GUICtrlCreateLabel("Open Source Launcher 2.0.9 Build 10", 48, 8, $iW - 56, 32, $SS_CENTERIMAGE)
<<<<<<< HEAD
>>>>>>> parent of 123572d... 2.1.0.0 Build 0
=======
>>>>>>> parent of 123572d... 2.1.0.0 Build 0
GUICtrlSetFont(-1, 14, 800, 0, "Arial", 5)
GUICtrlCreateIcon("steam.ico", -131, 8, 8, 32, 32)
GUICtrlCreateLabel("", 0, $iT, $iW, 2, $SS_SUNKEN) ; separator
GUICtrlCreateLabel("", $iLeftWidth, $iT + 2, 2, $iH - $iT - $iB - 2, $SS_SUNKEN) ; separator
GUICtrlCreateLabel("", 0, $iH - $iB, $iW, 2, $SS_SUNKEN) ; separator
$hFooter = GUICtrlCreateLabel("© 2016 liberodark", 10, $iH - 18, $iW - 20, 17)
GUICtrlSetTip(-1, "GitHub", "Click to open...")
GUICtrlSetCursor(-1, 0)

$intro1 = GUICtrlCreateIcon("open.ico", -131, $iLeftWidth + 100, 100, 64, 64)
$intro2 = GUICtrlCreateLabel("Welcome", $iLeftWidth + 95, 180, 100, 25)
GUICtrlSetFont(-1, 14, 800, 0, "Arial", 5)

Global $iLinks = 7
Global $aLink[$iLinks], $aPanel[$iLinks]
$aLink[0] = $iLinks - 1
$aPanel[0] = $iLinks - 1

;add links to the left side
$aLink[1] = _AddNewLink("Pseudo")
$aLink[2] = _AddNewLink("Language", -14)
$aLink[3] = _AddNewLink("Options", -22)
$aLink[4] = _AddNewLink("Save / Restore", -166)
$aLink[5] = _AddNewLink("Launch Game", -12)
$aLink[6] = _AddNewLink("Credits", -222)

;and the corresponding GUI's
$aPanel[1] = _AddNewPanel("Enter your Pseudo")
$aPanel[2] = _AddNewPanel("Chose your Language")
$aPanel[3] = _AddNewPanel("Options")
$aPanel[4] = _AddNewPanel("Save / Restore Configuration File")
$aPanel[5] = _AddNewPanel("Launch Game")
$aPanel[6] = _AddNewPanel("Credits")

;add some controls to the panels
_AddControlsToPanel($aPanel[1])
GUICtrlCreateLabel("Name", 8, 38, 36, 17)
Local $hInput1 = GUICtrlCreateInput($currentname, 56, 35, 121, 21)
Local $hButton1 = GUICtrlCreateButton("Ok", 180, 33, 75, 25)

_AddControlsToPanel($aPanel[2])
GUICtrlCreateLabel("Languages", 8, 38, 56, 17)
Global $Combo1 = GUICtrlCreateCombo("", 76, 35, 121, 21)
GUICtrlSetData($Combo1, "Arabic|Brazilian|Bulgarian|Croatian|Czech|Danish|Dutch|English|Estonian|Finnish|French|German|Greek|Hungarian|Italian|Japanese|Koreana|Lithuanian|Norwegian|Polish|Portuguese|Russian|Romanian|Serbian|Simplified Chinese|Spanish|Swedish|Thai|Traditional Chinese|Turkish|Ukrainian", $currentlang)
Local $hButton2 = GUICtrlCreateButton("Ok", 200, 33, 75, 25)

_AddControlsToPanel($aPanel[3])
GUICtrlCreateLabel("Appid", 18, 45, 36, 17)
Local $hInput2 = GUICtrlCreateInput($currentappid, 80, 42, 70, 20)
Local $hInput3 = GUICtrlCreateInput($currentappid1, 155, 42, 70, 20)
If $nbAppid = 1 Then GUICtrlSetState(-1, $GUI_DISABLE)
Local $btn_appid = GUICtrlCreateButton("Save", 235, 41, 50, 22)
GUIStartGroup()
GUICtrlCreateLabel("Steam ID", 18, 75, 80, 17)
Global $Combo2 = GUICtrlCreateCombo("", 80, 70, 121, 21)
GUICtrlSetData($Combo2, "Static|Random|ip|PersonaName|GenerateRandom", $currentSteamId)
Local $hButton17 = GUICtrlCreateButton("Save", 235, 70, 50, 22)
GUIStartGroup()
GUICtrlCreateLabel("Steam Online", 18, 100, 80, 17)
Local $hButton7 = GUICtrlCreateRadio("Online", 100, 95, 50, 25)
GUICtrlSetState(-1, ($currentSteam <> "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
Local $hButton8 = GUICtrlCreateRadio("Offline", 160, 95, 50, 25)
GUICtrlSetState(-1, ($currentSteam = "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
GUIStartGroup()
GUICtrlCreateLabel("OnlinePlay", 18, 125, 80, 17)
Local $hButton9 = GUICtrlCreateRadio("On", 100, 120, 50, 25)
GUICtrlSetState(-1, ($currentOnlinePlay = "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
Local $hButton10 = GUICtrlCreateRadio("Off", 160, 120, 50, 25)
GUICtrlSetState(-1, ($currentOnlinePlay <> "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
GUIStartGroup()
GUICtrlCreateLabel("Overlay", 18, 150, 36, 17)
Local $hButton11 = GUICtrlCreateRadio("On", 100, 145, 50, 25)
GUICtrlSetState(-1, ($currentOverlay = "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
Local $hButton12 = GUICtrlCreateRadio("Off", 160, 145, 50, 25)
GUICtrlSetState(-1, ($currentOverlay <> "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
GUIStartGroup()
GUICtrlCreateLabel("VR", 18, 175, 36, 17)
Local $hButton13 = GUICtrlCreateRadio("On", 100, 170, 50, 25)
GUICtrlSetState(-1, ($currentVR = "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
Local $hButton14 = GUICtrlCreateRadio("Off", 160, 170, 50, 25)
GUICtrlSetState(-1, ($currentVR <> "1") ? $GUI_CHECKED : $GUI_UNCHECKED)
GUIStartGroup()
GUICtrlCreateLabel("Plugins", 18, 215, 36, 17)
Local $hButton15 = GUICtrlCreateCheckbox("Remove", 98, 210, 60, 25)
Local $hButton15b = GUICtrlCreateCheckbox("Restore", 163, 210, 55, 25)
If Not FileExists($PluginsDir) Then
	GUICtrlSetState($hButton15, $GUI_CHECKED + $GUI_DISABLE)
Else
	GUICtrlSetState($hButton15b, $GUI_CHECKED + $GUI_DISABLE)
EndIf


_AddControlsToPanel($aPanel[4])
GUICtrlCreateLabel("Save current configuration and settings :", 18, 50, 260, 17)
Local $hButton5 = GUICtrlCreateButton("Save", 150, 70, 75, 22)
GUICtrlCreateLabel("Restore previous configuration and settings:", 18, 110, 260, 17)
Local $hButton6 = GUICtrlCreateButton("Restore", 150, 130, 75, 22)
GUICtrlCreateLabel("Reset configuration (remove all custom settings) :", 18, 170, 260, 17)
Local $hButton16 = GUICtrlCreateButton("Reset", 150, 190, 75, 22)

_AddControlsToPanel($aPanel[5])
GUICtrlCreateLabel("Select", 8, 40, 36, 17)
Local $hButton3 = GUICtrlCreateButton("32bit", 56, 35, 75, 25)
Local $hButton4 = GUICtrlCreateButton("64Bit", 150, 35, 75, 25)

_AddControlsToPanel($aPanel[6])
GUICtrlCreateEdit("", 10, 37, $iW - $iLeftWidth + 2 - 20 - 5, $iH - $iT - $iB - 40, $ES_READONLY, $WS_EX_STATICEDGE)
GUICtrlSetBkColor(-1, 0xffffff)
Local $sTestTxt = ""
$sTestTxt &= @TAB & "liberodark - Dev" & @CRLF
$sTestTxt &= @TAB & "orax - Helper" & @CRLF
$sTestTxt &= @TAB & "Teckos - Helper" & @CRLF
$sTestTxt &= @TAB & "taietel - GUI Template" & @CRLF
$sTestTxt &= @TAB & "blacksoul305 - Helper" & @CRLF
$sTestTxt &= @TAB & "mikell - Helper" & @CRLF
$sTestTxt &= @TAB & "gothgothhh - Helper" & @CRLF
GUICtrlSetData(-1, $sTestTxt)

GUISetState(@SW_SHOW, $hMainGUI)


While 1
	Sleep(10)
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[1]
		Case $hMainGUI
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					If $modified = 0 Then Exit
					If MsgBox(36, "Launcher SSE", "Keep these modifications ?") <> 6 Then
						FileCopy($backupXML, $sXMLPath, $FC_OVERWRITE) ; restore
						MsgBox(64, "Launcher SSE", "OK, maybe next time... see you later")
					EndIf
					Exit
				Case $aLink[1], $aLink[2], $aLink[3], $aLink[4], $aLink[5], $aLink[6]
					GUICtrlSetState($intro1, $GUI_HIDE)
					GUICtrlSetState($intro2, $GUI_HIDE)
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
		Case $aPanel[1]
			Switch $nMsg[0]
				Case $hButton1
					_UpdateXML($sXMLPath, "PersonaName", GUICtrlRead($hInput1))
			EndSwitch
		Case $aPanel[2]
			Switch $nMsg[0]
				Case $hButton2
					_UpdateXML($sXMLPath, "Language", GUICtrlRead($Combo1))
			EndSwitch
		Case $aPanel[3]
			Switch $nMsg[0]
				Case $btn_appid
					_UpdateXML($sXMLPath, "AppId", GUICtrlRead($hInput2), GUICtrlRead($hInput3)) ; AppId
				Case $hButton17
					_UpdateXML($sXMLPath, "Steam ID", GUICtrlRead($Combo2)) ; Steam ID Generation
				Case $hButton7
					_UpdateXML($sXMLPath, "Offline", "0") ; Steam Online
				Case $hButton8
					_UpdateXML($sXMLPath, "Offline", "1") ; Steam Offline
				Case $hButton9
					_UpdateXML($sXMLPath, "EnableOnlinePlay", "1") ; Online On
				Case $hButton10
					_UpdateXML($sXMLPath, "EnableOnlinePlay", "0") ; Online Off
				Case $hButton11
					_UpdateXML($sXMLPath, "EnableOverlay", "1") ; Overlay On
				Case $hButton12
					_UpdateXML($sXMLPath, "EnableOverlay", "0") ; Overlay Off
				Case $hButton13
					_UpdateXML($sXMLPath, "VR", "1") ; VR On
				Case $hButton14
					_UpdateXML($sXMLPath, "VR", "0") ; VR Off
				Case $hButton15
					If MsgBox(33, "Launcher SSE", "Remove plugins, overlay and online options ?") = 1 Then
						DirMove($PluginsDir, $PluginsDirBak, 1) ; Remove plugins
						GUICtrlSetState($hButton15, $GUI_CHECKED + $GUI_DISABLE)
						GUICtrlSetState($hButton15b, $GUI_UNCHECKED + $GUI_ENABLE)
						MsgBox(64, "Launcher SSE", "Plugins removed !")
						$modified = 1
					Else
						GUICtrlSetState($hButton15, $GUI_UNCHECKED)
					EndIf
				Case $hButton15b
					If MsgBox(33, "Launcher SSE", "Restore plugins, overlay and online options ?") = 1 Then
						DirMove($PluginsDirBak, $PluginsDir, 1) ; Restore plugins
						GUICtrlSetState($hButton15b, $GUI_CHECKED + $GUI_DISABLE)
						GUICtrlSetState($hButton15, $GUI_UNCHECKED + $GUI_ENABLE)
						MsgBox(64, "Launcher SSE", "Plugins restored !")
						$modified = 1
					Else
						GUICtrlSetState($hButton15b, $GUI_UNCHECKED)
					EndIf
			EndSwitch
		Case $aPanel[4]
			Switch $nMsg[0]
				Case $hButton5
					If MsgBox(33, "Launcher SSE", "Backup current configuration and settings ?") = 1 Then
						FileCopy($sXMLPath, $backupXML) ; backup
						MsgBox(64, "Launcher SSE", "Current configuration saved")
					EndIf
				Case $hButton6
					If MsgBox(33, "Launcher SSE", "Restore previous configuration and settings ?") = 1 Then
						FileCopy($backupXML, $sXMLPath, $FC_OVERWRITE) ; restore
						MsgBox(64, "Launcher SSE", "Previous configuration restored")
					EndIf
				Case $hButton16
					If MsgBox(49, "Launcher SSE", "Reset configuration and remove name and all options ?") = 1 Then
						FileCopy($savedXML, $sXMLPath, $FC_OVERWRITE) ; restore / Reset
						MsgBox(64, "Launcher SSE", "Reset configuration done")
					EndIf
			EndSwitch
		Case $aPanel[5]
			Switch $nMsg[0]
				Case $hButton3
					Run("Game\SSELauncher.exe -appid " & GUICtrlRead($hInput2), "Game\")
					Exit
				Case $hButton4
					Switch $nbAppid
						Case 1
							Run("Game\SSELauncher.exe -appid " & GUICtrlRead($hInput2), "Game\")
						Case 2
							Run("Game\SSELauncher.exe -appid " & GUICtrlRead($hInput3), "Game\")
					EndSwitch
					Exit
			EndSwitch
	EndSwitch
WEnd


;==================================================

Func _UpdateXML($sFilePath, $option, $value1, $value2 = "")
	Local $content = FileRead($sFilePath), $new, $text
	$new = StringRegExpReplace($content, '(?<=<' & $option & '>)[^<]*', $value1, 1)
	$text = 'Modification "' & $option & ' = ' & $value1 & '" saved'
	If $value2 <> "" Then
		$new = StringRegExpReplace($new, '(?s).*\K(?<=<' & $option & '>)[^<]*', $value2, 1)
		$text &= @CRLF & 'Modification "' & $option & '2 = ' & $value2 & '" saved'
	EndIf
	Local $hFile = FileOpen($sFilePath, 2)
	FileWrite($hFile, $new)
	FileClose($hFile)
	$modified = 1
	MsgBox(64, "Launcher SSE", $text)
EndFunc   ;==>_UpdateXML

Func _AddNewLink($sTxt, $iIcon = -44)
	Local $hLink = GUICtrlCreateLabel($sTxt, 36, $iT + $iGap, $iLeftWidth - 46, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateIcon("shell32.dll", $iIcon, 10, $iT + $iGap, 16, 16)
	$iGap += 22
	Return $hLink
EndFunc   ;==>_AddNewLink

Func _AddNewPanel($sTxt)
	Local $gui = GUICreate("", $iW - $iLeftWidth + 2, $iH - $iT - $iB, $iLeftWidth + 2, $iT, $WS_CHILD, -1, $hMainGUI)
	GUICtrlCreateLabel($sTxt, 10, 10, $iW - $iLeftWidth - 20, 17, $SS_CENTERIMAGE)
	GUICtrlSetFont(-1, 9, 800, 4, "Arial", 5)
	Return $gui
EndFunc   ;==>_AddNewPanel

Func _AddControlsToPanel($hPanel)
	GUISwitch($hPanel)
EndFunc   ;==>_AddControlsToPanel
