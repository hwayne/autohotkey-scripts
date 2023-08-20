; Groups are collections of window queries that you can operate on as a group,
; IE show all of them, hide all of them, close the most recently active, etc.
; READ MORE: https://www.autohotkey.com/docs/v2/misc/WinTitle.htm#ahk_group
; AND: https://www.autohotkey.com/docs/v2/lib/GroupAdd.htm

; You can use the WindowSpy script to get the names and classes of programs
; WindowSpy comes with AutoHotKey

GroupAdd("hh", "ahk_exe hh.exe ") ; ahk help program
GroupAdd("firefox", "ahk_exe firefox.exe")

; If you add multiple queries to a group, all queries that match any will be used
GroupAdd("mail", "ahk_exe thunderbird.exe")
GroupAdd("mail", "ahk_exe OUTLOOK.EXE")

; You can also match on the "window class", which IIRC is determined by the GUI sdk.
; This is the class for the file explorer window.
GroupAdd("files", "ahk_class CabinetWClass")

GroupAdd("zoom", "ahk_exe Zoom.exe")
GroupAdd("zoom", "ahk_exe Teams.exe")

GroupAdd("editors", "ahk_exe Code.exe")
GroupAdd("editors", "ahk_exe nvim-qt.exe")

; Switch to a window of whichever type.
; IE right-alt+1 switches through firefox windows.
; All of these use right-alt+char because consistency is cool

; GroupActivate(name, "R") activates THE MOST RECENTLY ACTIVE window
; READ MORE: https://www.autohotkey.com/docs/v2/lib/GroupActivate.htm

>!1:: GroupActivate("firefox", "R")
>!e:: GroupActivate("mail", "R")
>!h:: GroupActivate("hh", "R")
>!f:: GroupActivate("files", "R")
>!c:: GroupActivate("editors", "R")
>!z:: GroupActivate("zoom", "R")
