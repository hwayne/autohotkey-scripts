; Saves notes and bits of clipboard to a file.
; Also a demo of how to write classes in AHK!

class Researcher 
{
    NoteType := "0"

    SetNoteType()
    {
        this.NoteType := InputBox(Format("Your current note type is {1}", this.NoteType), "Research").Value
    }

    SetTo(val)
    {
        this.NoteType := val
    }
    
    AddNote()
    {
        FileAppend("`r`n" . A_clipboard, this.NoteFile())
    }

    JotNote()
    {        
        msg := InputBox(Format("Jot note for {1}", this.NoteType), "Research").Value
        FileAppend("`r`n" . A_clipboard, this.NoteFile())

    }

    OpenNotes()
    {
        tmp := this.NoteType . ".txt - Notepad"
        if(WinExist(tmp)) {
            WinKill
        }
        else {
            if(FileExist(this.NoteFile()))
                Run this.NoteFile()
        }
    }

    NoteFile()
    {
		; TODO make this able to have different note directories
        return (A_WorkingDir . "\Config\Notes\" . this.NoteType . ".txt")    
    }
}

Research := Researcher()