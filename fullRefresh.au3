For $i = 1 To 8
    ; Open Discord
	Run("C:\Users\<username>\AppData\Local\Discord\Update.exe --processStart Discord.exe") ; Change to your username
	Sleep(1000)
	
    ;  Moves the click down to the next DM each iteration, adjust 
    MouseClick("left", 156, 297 + (50 * ($i - 1)))
    Sleep(500) ; Adjust delay if necessary

	; Drag the mouse, adjust to your screen size (autoit window info)
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
	Send($i)
	Sleep(500)
    Send("{ENTER}")
    Sleep(500)
	
    ; Close Notepad
    Send("!{F4}")

Next