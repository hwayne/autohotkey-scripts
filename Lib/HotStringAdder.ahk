/* 
from https://www.autohotkey.com/docs/v1/Hotstrings.htm#Helper, updated to v2 by me. Since it's someone else's script, I mostly just left their comments.

(looks like they updated it themselves too at https://www.autohotkey.com/docs/v2/lib/Hotstring.htm#ExHelper)
*/

>^h::  {
; Get the text currently selected. The clipboard is used instead of
; "ControlGet Selected" because it works in a greater variety of editors
; (namely word processors).  Save the current clipboard contents to be
; restored later. Although this handles only plain text, it seems better
; than nothing:
ClipboardOld := ClipboardAll()
A_Clipboard := ""  ; Must start off blank for detection to work.
Send "^c"
if !(ClipWait(1)) {
    return
}
; Replace CRLF and/or LF with `n for use in a "send-raw" hotstring:
; The same is done for any other characters that might otherwise
; be a problem in raw mode:
hs := StrReplace(A_Clipboard, "``", "````")  ; Do this replacement first to avoid interfering with the others below.
hs := StrReplace(hs, "`r`n", "``r")  ; Using `r works better than `n in MS Word, etc.
hs := StrReplace(hs, "`n", "``r")
hs := StrReplace(hs, A_Tab, "``t")
hs := StrReplace(hs, ";", "``;")
A_Clipboard := ClipboardOld  ; Restore previous contents of clipboard.


; Show the InputBox, providing the default HotString:
cmd := InputBox("Insert HotString for " . hs, ,,";")
if cmd.Result != "OK" {
    return
}
; Otherwise, add the hotstring and reload the script:

to_write := Format(":R:{1}::{2}", cmd.Value, hs)
hotstring_file := A_WorkingDir . "\HotStrings.ahk"
FileAppend "`n" . to_write, hotstring_file
Reload
}