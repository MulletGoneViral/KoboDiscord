#include <Array.au3>
#include <File.au3>

; Get the DM number from the command-line argument
If $CmdLine[0] < 1 Then
    MsgBox(0, "Error", "No DM number passed.")
    Exit
EndIf

$dmNumber = $CmdLine[1]

$folderPath = "@ScriptDir"

; Open Discord
Run("C:\Users\chris\AppData\Local\Discord\Update.exe --processStart Discord.exe") ; Change this path to where your Discord executable is located
winWaitActive("[CLASS:Chrome_WidgetWin_1]")
	
; Click at position (156, 297 + (50 * ($dmNumber - 1))) - Moves the click down to the correct DM
MouseClick("left", 156, 297 + (50 * ($dmNumber - 1)))
Sleep(1000) ; Adjust delay if necessary

; Drag the mouse to highlight messages
MouseClickDrag("left", 850, 695, 357, 100, 10) ; The 10 controls the speed of the drag, adjust if necessary
Sleep(500) ; Wait a bit then copy
Send("^c") ; Ctrl + C to copy

; Open Notepad and paste
Run("notepad.exe")
WinWaitActive("[CLASS:Notepad]")
Send("^v")
Sleep(500)

; Save the file <dmNumber>.txt
Send("^s")
WinWaitActive("Save as")
Send($dmNumber)
Sleep(500)
Send("{ENTER}")
Sleep(500)
	
; Close Notepad
Send("!{F4}")
