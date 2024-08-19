For $i = 1 To 8
    ; Open Discord
	Run("C:\Users\chris\AppData\Local\Discord\Update.exe --processStart Discord.exe") ; Change this path to where your Discord executable is located
	Sleep(1000)
	
    ; Click at position (156, 297 + (50 * ($i - 1))) - Moves the click down by 10 pixels each iteration
    MouseClick("left", 156, 297 + (50 * ($i - 1)))
    Sleep(500) ; Adjust delay if necessary

	; Drag the mouse from (841, 681) to (365, 89)
	MouseClickDrag("left", 854, 689, 357, 100, 10) ; The 10 controls the speed of the drag, adjust if necessary
	Sleep(500) ; Wait a bit after the drag operation

    ; Copy the selected text to the clipboard
    Send("^c") ; Ctrl + C to copy

    ; Open Notepad
    Run("notepad.exe")
    WinWaitActive("[CLASS:Notepad]")

    ; Paste the text
    Send("^v")
    Sleep(500)

    ; Save the file as an .txt file
    Send("^s")
    WinWaitActive("Save as")
	Send($i)
	Sleep(500)
	
    ; Press Enter to save
    Send("{ENTER}")
    Sleep(500)
	
    ; Close Notepad
    Send("!{F4}")

Next
