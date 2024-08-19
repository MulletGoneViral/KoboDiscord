#include <Array.au3>
#include <File.au3>

; Define the folder where the file is saved
$folderPath = "C:\Users\chris\OneDrive\Documents\Config.json\ConnectionManager.xml\SoFTwAre\KoboDiscord\saved_files"

; Get the name of the only file in the folder
$fileList = _FileListToArray($folderPath, "*.txt", 1)
If @error Then
    MsgBox(0, "Error", "No file found in the folder.")
    Exit
EndIf

; Since there should be only one file, get the first file in the list
$fileName = $fileList[1]
$filePath = $folderPath & "\" & $fileName

; Read the content of the file
$fileContent = FileRead($filePath)

; Open Discord (assuming it's already running, this will bring it to the front)
    Run("C:\Users\chris\AppData\Local\Discord\Update.exe --processStart Discord.exe") 
    Sleep(1000)

; Click at a fixed position (e.g., 156, 297)
MouseClick("left", 156, 297 + (50 * ($fileName - 1))) ; Adjust the position if needed
Sleep(500)

; Send the file content and press Enter
Send($fileContent)
Send("{ENTER}")
