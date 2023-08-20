; Saves notes and bits of clipboard to a file.
; One of my older scripts, not too cleaned up yet.
; Also a demo of how to write classes in AHK!

class Researcher 
{
    ; Current notefile, starts as `0.txt`
    NoteType := "0"

    ; Change the name of the notefile.
    SetNoteType()
    {
        this.NoteType := InputBox(Format("Your current note type is {1}", this.NoteType), "Research").Value
    }

    ; Directly saves whatever you just copied to the notefile
    AddNote()
    {
        FileAppend("`r`n" . A_clipboard, this.NoteFile())
    }

    ; Open a "type notes here" input box and save whatever that is to the notefile
    JotNote()
    {        
        msg := InputBox(Format("Jot note for {1}", this.NoteType), "Research").Value
        FileAppend("`r`n" . A_clipboard, this.NoteFile())

    }

    ; Open the notefile
    OpenNotes()
    {
        tmp := this.NoteType . ".txt - Notepad"
        if(WinExist(tmp)) {
            WinKill ; close notepad if it exists
        }
        else {
            if(FileExist(this.NoteFile())) ; open if exists
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
; Hotkeys for SetNoteType, AddNote, JotNote, OpenNotes in main.ahk