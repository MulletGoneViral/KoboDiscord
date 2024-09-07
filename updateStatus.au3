#include <Array.au3>
#include <File.au3>

; Open Discord
    Run("C:\Users\chris\AppData\Local\Discord\Update.exe --processStart Discord.exe") 
	winWaitActive("[CLASS:Chrome_WidgetWin_1]")
	
; Get status from file
$fileList = _FileListToArray(@ScriptDir, "*.txt", 1)
If @error Then
    MsgBox(0, "Error", "No file found in the folder.")
    Exit
EndIf

$fileName = $fileList[1]
$filePath = @ScriptDir & "\" & $fileName
$text = FileRead($filePath)

MouseClick("left", 163, 770) ; Open profile
Sleep(500)
MouseClick("left", 206, 558) ;  Open status
Sleep(200)
MouseClick("left", 847, 327) ; Clear status
Sleep(100)
MouseClick("left", 800, 327) ; Focus text box
Sleep(100)
send($text)
MouseClick("left", 815, 607) ; Save status

