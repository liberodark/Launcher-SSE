#include <InetConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Download()

Func Download()

	; Check msvcr100.dll
	Local $sDLL1 = "C:\Windows\System32\msvcr100.dll"
	Local $sDLL2 = "C:\Windows\SysWOW64\msvcr100.dll"

	If (not FileExists($sDLL1)) AND (not FileExists($sDLL2)) Then

		MsgBox(64,"Update", "Update Download")

		RunWait(@ScriptDir & "\Game\vcredist_x86.exe /passive /norestart", @SW_HIDE) ; Install Microsoft Visual C++ 2010 if 0

		MsgBox(64,"Update", "Update Installed")

	EndIf

    ; Save the downloaded file to the folder.
    Local $sFilePath = @ScriptDir & "\Game\vcredist_x86.exe"
	; Local $sFilePath1 = @ScriptDir & "\Game\7za.exe"

    ; Download the file in the background with the selected option of 'force a reload from the remote site.'
    Local $hDownload = InetGet("http://yurfile.altervista.org/download.php?fid=L3ZjcmVkaXN0X3g4Ni5leGU=", $sFilePath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

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
EndFunc   ;==>Download