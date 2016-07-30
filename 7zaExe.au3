#include-once

;Get the 7za.exe program on web site : http://www.7-zip.org/download.html
;
;===============================================================================
;
; Function Name:    _Extract7zaExe()
; Description:      Extracts files from an archive
; Parameter(s):     $7zaPath    - The 7za path & exe
;                   $Archive    - The Archive to use
;                   $OutDir     - Where to extract the files
;                   $Recurce    - Use recursive files or not (0 or 1)
;                                 If recursive is used, then the extraction method
;                                 is whith full Path else simple extraction is used
;                   $Filter     - Files to extract from the Archive
; Requirement(s):   AutoIt3 and 7za.exe
; Return Value(s):  On Success - Return 1
;                   On Failure - Return 0
; Author(s):        Tlem
;
;===============================================================================
Func _Extract7zaExe($7zaPath, $Archive, $OutDir, $Recurse = 0, $Filter = "*.*")
    If $Recurse = 1 Then
        $Recurse = ' -r '
        $Extract = 'x'
    Else
        $Recurse = ''
        $Extract = 'e'
    EndIf
    ShellExecuteWait($7zaPath, $Extract & ' "' & $Archive & '" -o"' & $OutDir & '" ' & $Filter & $Recurse & ' -y', "", "", @SW_HIDE)
    $error = @error
    If $error Then
        Return 0
    Else
        Return 1
    EndIf
EndFunc   ;==>_Extract7zaExe

;===============================================================================
;
; Function Name:    _Add7zaExe()
; Description:      Adds Files to an Archive/Creates an Archive
; Parameter(s):     $7zaPath    - The 7za path & exe
;                   $Archive    - The Archive to use with extention
;                                 (7z, zip, gzip, bzip2, or tar).
;                                 Note: gzip or bzip2 formats support only one file per archive.
;                                 If you want to compress more than one file to these formats,
;                                 create a tar archive first, and then compress it with your selected format.
;                   $InDir      - Where to add the files
;                   $Recurce    - Use recursive files or not (0 or 1)
;                   $Filter     - Files to add to the Archive
; Requirement(s):   AutoIt3 and 7za.exe
; Return Value(s):  On Success - Return 1
;                   On Failure - Return 0
; Author(s):        Tlem
;
;===============================================================================
Func _Add7zaExe($7zaPath, $Archive, $InDir, $Recurse = 0, $Filter = "*.*")
        $array = StringSplit($Archive, ".")
        $Type = StringTrimLeft($Archive, StringLen($array[1])+1)
    If $Type = "7Z" Or $Type = "zip" Or $Type = "gzip" Or $Type = "bzip2" Or $Type = "tar" Then
        If FileExists($InDir & '\' & $Filter) Then
            If $Recurse = 1 Then
                $Recurse = ' -r '
            Else
                $Recurse = ''
            EndIf
            ShellExecuteWait($7zaPath, 'a -t' & $Type & ' "' & $Archive & '" "' & $InDir & '\' & $Filter & '"' & $Recurse, "", "", @SW_HIDE)
            $error = @error
            If $error Then
                Return 0
            Else
                Return 1
            EndIf
        Else
            Return 0
        EndIf
    Else
        Return 0
    EndIf
EndFunc   ;==>_Add7zaExe

;===============================================================================
;
; Function Name:    _CMD7zaExe()
; Description:      Executes 7-zip Commands (See Syntax in 7z.exe/7za.exe doc)
; Parameter(s):     $7zaPath    - The 7za path & exe
;                   $sCMDLine   - The Commandline
; Requirement(s):   AutoIt3 and 7za.exe
; Return Value(s):  On Success - Return 1
;                   On Failure - Return 0
; Author(s):        Tlem
;
;===============================================================================
Func _CMD7zaExe($7zaPath, $sCMDLine)
    ShellExecuteWait($7zaPath, $sCMDLine, "", "", @SW_HIDE)
    $error = @error
    If $error Then
        Return 0
    Else
        Return 1
    EndIf
EndFunc   ;==>_CMD7zaExe