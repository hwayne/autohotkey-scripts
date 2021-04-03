; Saves notes and bits of clipboard to a file.

class Researcher 
{
    NoteType := 0

    SetNoteType()
    {
        ; We have to save to tmp because InputBox variable interpolation doesn't accept dots
        tmp := this.NoteType
        
        InputBox, tmp, Researcher,Your current note type is "%tmp%",,,,,,,, %tmp%
        this.NoteType := tmp

    }

    ; I added this well after the rest of Researcher, should make SetNoteType use it lol
    SetTo(val)
    {
        this.NoteType := val
    }
    
    AddNote()
    {
        tmp := this.NoteFile()
        FileAppend, %clipboard%`r`n, %tmp%
    }

    JotNote()
    {
        tmp := this.NoteType
        
        InputBox, msg, Jot Note, Jot note for type "%tmp%",,,,,,,,
        file := this.NoteFile()
        FileAppend, %msg%`r`n, %file%

    }

    OpenNotes()
    {
        ifWinExist, ahk_exe notepad.exe
            WinKill
        else
            ifExist % this.NoteFile()
                Run % this.NoteFile()
    }

    NoteFile()
    {
		
                return (A_WorkingDir . "\Config\Notes\" . this.NoteType . ".txt")    
    }
}

; Lowercase
;=::TrayTip, "hello", "world"
