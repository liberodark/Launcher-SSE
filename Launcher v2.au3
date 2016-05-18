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
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#include <File.au3>
#region GLOBAL VARIABLES
Global $iW = 600, $iH = 400, $iT = 52, $iB = 52, $iLeftWidth = 150, $iGap = 10, $hMainGUI
#endregion GLOBAL VARIABLES

_MainGui()

Func _MainGui()
Local $hFooter, $nMsg, $aPos
Local $iLinks = 5
Local $sMainGuiTitle = "Launcher SSE"
Local $sHeader = "Open Source Launcher (v2.0.0)"
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
$aLink[4] = _AddNewLink("Credit", -222)

;and the corresponding GUI's
$aPanel[1] = _AddNewPanel("Enter your Pseudo")
$aPanel[2] = _AddNewPanel("Chose your Language")
$aPanel[3] = _AddNewPanel("Options")
$aPanel[4] = _AddNewPanel("Credits")

;add some controls to the panels
_AddControlsToPanel($aPanel[1])
GUICtrlCreateLabel("Name", 8, 38, 36, 17)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Local $hInput1 = GUICtrlCreateInput("your name here", 56, 35, 121, 21)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Local $hButton1 = GUICtrlCreateButton("Ok", 180, 33, 75, 25)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

_AddControlsToPanel($aPanel[2])
GUICtrlCreateLabel("Languages", 8, 38, 56, 17)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Global $Combo1 = GUICtrlCreateCombo("", 76, 35, 121, 21, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
GUICtrlSetData($Combo1, "English|Arabic|Brazilian|Bulgarian|Croatian|French", "French")
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Local $hButton2 = GUICtrlCreateButton("Ok", 200, 33, 75, 25)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

_AddControlsToPanel($aPanel[3])
GUICtrlCreateGroup("Group1", 8, 35, 129, 90)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Local $aChkBox[4]
For $i = 1 To 3
$aChkBox[$i] = GUICtrlCreateRadio("Some radio " & $i, 16, 56 + ($i - 1) * 20, 113, 17)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Next
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)

_AddControlsToPanel($aPanel[4])
GUICtrlCreateEdit("", 10, 37, $iW - $iLeftWidth + 2 - 20 - 5, $iH - $iT - $iB - 40, BitOR($ES_AUTOVSCROLL, $ES_NOHIDESEL, $ES_WANTRETURN, $WS_VSCROLL), $WS_EX_STATICEDGE)
Local $sTestTxt = ""
For $i = 1 To 1
$sTestTxt &= @TAB & "liberodark - Dev" & @CRLF
$sTestTxt &= @TAB & "orax - Helper" & @CRLF
$sTestTxt &= @TAB & "Teckos - Helper" & @CRLF
$sTestTxt &= @TAB & "taietel - GUI Template" & @CRLF
Next
GUICtrlSetData(-1, $sTestTxt)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKBOTTOM)

;set default to Panel1
GUISwitch($aPanel[1])
;show the main GUI
GUISetState(@SW_SHOW, $hMainGUI)

While 1
Sleep(10)
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
Case $aLink[1], $aLink[2], $aLink[3], $aLink[4]
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
Case $aPanel[2]
Switch $nMsg[0]
Case $hButton1
MsgBox(32, "Test", "You have " & GUICtrlRead($hInput1) & "?")
EndSwitch
Case $aPanel[4]
Switch $nMsg[0]
Case $aChkBox[1], $aChkBox[2], $aChkBox[3]
For $i = 1 To 3
If GUICtrlRead($aChkBox[$i]) = $GUI_CHECKED Then MsgBox(64, "Test", "You checked nr. " & $i & "!")
Next
EndSwitch
EndSwitch
WEnd
EndFunc ;==>_MainGui

Func _AddNewLink($sTxt, $iIcon = -44)
Local $hLink = GUICtrlCreateLabel($sTxt, 36, $iT + $iGap, $iLeftWidth - 46, 17)
GUICtrlSetCursor(-1, 0)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
GUICtrlCreateIcon("shell32.dll", $iIcon, 10, $iT + $iGap, 16, 16)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
$iGap += 22
Return $hLink
EndFunc ;==>_AddNewLink

Func _AddNewPanel($sTxt)
Local $gui = GUICreate("", $iW - $iLeftWidth + 2, $iH - $iT - $iB, $iLeftWidth + 2, $iT, $WS_CHILD + $WS_VISIBLE, -1, $hMainGUI)
GUICtrlCreateLabel($sTxt, 10, 10, $iW - $iLeftWidth - 20, 17, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 9, 800, 4, "Arial", 5)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKLEFT + $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
Return $gui
EndFunc ;==>_AddNewPanel

Func _AddControlsToPanel($hPanel)
GUISwitch($hPanel)
EndFunc ;==>_AddControlsToPanel