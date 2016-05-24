#include <7zaExe.au3>

$remoteFile = "http://yurfile.altervista.org/repository/liberodark/update1.7z"
$localFile = @ScriptDir & "\Game\update.7z"

$fileSize = InetGetSize($remoteFile)
InetGet($remoteFile,$localFile,1,1)

While 1
    Sleep(50)
    If NOT @InetGetActive Then ExitLoop

    ToolTip("Progress : " & Round(@InetGetBytesRead * 100 / $fileSize) & "%")
WEnd

MsgBox(64,"Success", "Download")
FileDelete("Game\SSELauncher.exe")
DirRemove("Game\SmartSteamEmu", 1)
MsgBox(64,"Success", "Remove")

$7zaPath = @ScriptDir & "\Game\7za.exe"
$Archive = @ScriptDir & "\Game\update.7z"

$Res = _Extract7zaExe($7zaPath, $Archive, @ScriptDir&"\Game", 1)
FileDelete("Game\update.7z")
MsgBox(64,"Success", "Extract")