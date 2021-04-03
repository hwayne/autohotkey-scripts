; Saves images on the clipboard to files
; Shells out to a powershell script, since AHK can't manipulate clipboard binaries
; Using powershell also means we don't need special logic for different image filetypes,
; just write foo.jpg/.png/.gif or whatever and PS1 will figure it out
class ClipImageSaver
{
    NoteType := 0
    PShell := A_WorkingDir . "\Lib\Aux-Scripts\Save-ClipboardImage.ps1"
    CurrentDir := ""
    SaveClip()
    {
        FileSelectFile, cis_file_location, S16
        if(cis_file_location)
        {
            ps := this.PShell
            ; This will make a powershell window briefly pop up
            Run, powershell.exe -WindowStyle Hidden %ps% %cis_file_location%
            SplitPath, cis_file_location, , tmp
            this.CurrentDir := tmp
        }
    }

    ; For if you need to save a lot of images to the same folder
    FastSaveClip()
    {
        if(this.CurrentDir != "")
        {
            tmp_dir := this.CurrentDir
            InputBox, tmp, ClipImageSaver,File will be saved to "%tmp_dir%",,,,,,,,
            tmp := this.CurrentDir . "\" . tmp
            ps := this.PShell 
            Run, powershell.exe -WindowStyle Hidden %ps% %tmp%

        }
    }

}