; Lets you select a file like foo.bar and generate
; foo.1.bar, foo.2.bar, etc. I mostly use this for workshops
class FileCloner
{
    FileFull := ""
    FileName := ""
    Dir := ""
    Ext := ""

    SelectFile(path:="C:\")
    {
        tmp := this.File
        
        FileSelectFile, tmp, 1, %path%
        this.File := tmp
        SplitPath, tmp, , Dir, Ext, FileName,

        this.Dir := Dir
        this.Ext := Ext
        this.FileName := FileName
    }

    Clone()
    {
        count := 0
        tmp := this.File
        while FileExist(tmp)
        {
            count := count + 1
            tmp := this.Dir . "\" . this.FileName . "." . count "." . this.Ext
        }
        file := this.File
        FileCopy, %file%, %tmp%
    }
}

; Lowercase
;=::TrayTip, "hello", "world"
