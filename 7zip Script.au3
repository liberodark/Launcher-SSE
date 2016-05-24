#include <7zaExe.au3>

FileDelete("Game\7za.exe")
FileDelete("Game\SSELauncher.exe")
DirRemove("Game\SmartSteamEmu", 1)
MsgBox(64,"Success", "Remove")

$7zaPath = "Game\7za.exe"
$Archive = @ScriptDir & "Game\update.7z"
$Res = _Extract7zaExe($7zaPath, $Archive, @ScriptDir&"\Game", 1)
FileDelete("Game\update.7z")
MsgBox(64,"Success", "Extract")