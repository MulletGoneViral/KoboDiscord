#include <Array.au3>
#include <File.au3>

$folderPath = "C:\path\to\KoboDiscord\sent_messages" ; change to your path

; Get DM number from filename
$fileList = _FileListToArray($folderPath, "*.txt", 1)
If @error Then
    MsgBox(0, "Error", "No file found in the folder.")
    Exit
EndIf

$fileName = $fileList[1]
$filePath = $folderPath & "\" & $fileName
$text = FileRead($filePath)

; Open Discord
    Run("C:\Users\<username>\AppData\Local\Discord\Update.exe --processStart Discord.exe") ; change to your discord path
	winWaitActive("[CLASS:Chrome_WidgetWin_1]") ; Very intuitive window path, discord.

; Click DM
MouseClick("left", 156, 297 + (50 * ($fileName - 1))) ; Adjust the position for your screen (autoIt window info can help)
Sleep(500)

; Send the text and press Enter
Send($text)
Send("{ENTER}")
