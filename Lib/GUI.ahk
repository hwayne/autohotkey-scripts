/* A simple demo of how easy it is to write a GUI in AHK. This will allcaps any string you copy into the input.
You can run this script on its own, or from your main script with

    Run "autohotkey.exe " . A_WorkingDir . "\Lib\GUIs\Upcaser.ahk"

Keeping GUIs separate is good unless they need to share information with the main script.

READ MORE:
    - https://www.autohotkey.com/docs/v2/lib/Gui.htm
    - https://www.autohotkey.com/docs/v2/lib/GuiOnEvent.htm
    - https://www.autohotkey.com/docs/v2/lib/GuiControls.htm
*/
#SingleInstance Force ; No others

App := Gui("Resize", "UPCASER")
App.SetFont("s12")

App.AddText(,"Input")
cInput := App.AddEdit("r10 w400") ;GUI widgets are called "controls", hence "cInput"

App.AddText(,"Output")
cOutput := App.AddEdit("r10 w400 ReadOnly")

App.AddButton("Default w80", "Load File").OnEvent("Click", LoadFile)

cInput.OnEvent("Change", UpdateOutput) ; Triggered every time you type into the top box
App.OnEvent("Close", (*) => ExitApp(0))
App.OnEvent("Escape", (*) => ExitApp(0)) ; Close when you hit esc

App.Show()

UpdateOutput(ctrl, unused) {
    cOutput.value := StrUpper(ctrl.value)
}

LoadFile(ctrl, unused) {
    ; File selection is real easy in AHK!
    ; READ MORE: https://www.autohotkey.com/docs/v2/lib/FileSelect.htm
    file := FileSelect("1")
    if file {
        cInput.value := FileRead(file)
        UpdateOutput(cInput, "unused")
    }
}

; Separate scripts can have hotkeys, too. 
; Below hotkey will be removed when ExitApp is called.

NumpadRight::MsgBox("This will be unbound when ExitApp(0) is called")
