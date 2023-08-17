; A script to open a specific AHK file from anywhere on the computer.
; This is a lot of duplicated code from Folders.ahk, so check that for explanations on how it all works.

NumpadClear:: {
    lib := A_ScriptDir . "\Lib"
    launchers := A_ScriptDir . "\Lib\Launchers"
    file_frame := Map(
            "h", A_ScriptDir . "\Hotstrings.ahk"
        ,   "f", launchers . "\Folders.ahk"
        ,   "c", lib . "\CharScripts.ahk"
    )
    file_input := "?"

    file_out := ""


    for key, val in file_frame {
        file_input .= "," . key
        file_out .= key . "`t" . val . "`n"
    }

    ih := InputHook("L2 C T1", , file_input)
    ih.Start()
    if (ih.Wait() == "Match") {
        if (ih.Match == "?") {
            MsgBox(file_out)
        }
        else {
            Run(Format("edit `"{1}`"", file_frame[ih.Match]))
        }
    }
}