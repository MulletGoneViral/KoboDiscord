#include <Array.au3>
#include <File.au3>

$folderPath = "C:\path\to\KoboDiscord\sent_messages" ; Change to your path

; Get DM number from filename
$fileList = _FileListToArray($folderPath, "*.txt", 1)
If @error Then
    MsgBox(0, "Error", "No file found in the folder.")
    Exit
EndIf

$fileName = $fileList[1]
$filePath = $folderPath & "\" & $fileName

; Open Discord
Run("C:\Users\<user>\AppData\Local\Discord\Update.exe --processStart Discord.exe") ; Change to your username
Sleep(1000)
	
; Moves the click down to the next DM each iteration, adjust coordinants to match your display
MouseClick("left", 156, 297 + (50 * ($fileName - 1)))
Sleep(500) ; Adjust delay if necessary

; Drag the mouse from (841, 681) to (365, 89)
MouseClickDrag("left", 854, 689, 357, 100, 10) ; The 10 controls the speed of the drag, adjust if necessary
Sleep(500) ; Wait a bit then copy
Send("^c") ; Ctrl + C to copy

; Open Notepad and paste
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
Send("^v")
Sleep(500)

; Save the file <dm#>.txt
Send("^s")
WinWaitActive("Save as")
Send($fileName)
Sleep(500)
Send("{ENTER}")
Sleep(500)
	
; Close Notepad
Send("!{F4}")
