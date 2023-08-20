; These shortcuts only work when you're in Firefox. Should be easily adaptable to Chrome or Edge or whatever.

; These hotkeys are only active if the condition is true
; In this case, the "active window" is firefox.exe
; READ MORE: https://www.autohotkey.com/docs/v2/lib/WinActive.htm
#HotIf WinActive("ahk_exe firefox.exe")
; opens a specific group of bookmarks I positioned
; Dependent on the bookmark folder ordering

>^b::
{
  ; Keywaits make sure the button is no longer pressed.
  ; READ MORE: https://www.autohotkey.com/docs/v2/lib/KeyWait.htm
	Keywait("RControl")
    Keywait("b")
    SendEvent("!b") ; TODO explain SendEvent vs Send
    SendEvent("{down 4}{right}meo")
}


; Reopens page in sci-hub
>!^s::
{
    Keywait("RControl")
    Keywait("RAlt")
    SendEvent("^l")
    SendInput("{left}sci-hub.ru/{enter}")
}


; Reopens page in archive.org
>!^a::
{
    Keywait("RControl")
    Keywait("RAlt")
    SendEvent("^l")
    SendInput("{left}https://web.archive.org/web/*/{enter}")
}


<^k::Send("^l")  ;remove the 'search with google' shortcut if you slip and hit ctrl+k instead of ctrl+l


; One second youtube moves
#HotIf WinActive("ahk_exe firefox.exe") && WinActive(" - YouTube")

; For 1.25x speed
[::Send("{< 3}{left}{> 3}")
]::Send("{< 3}{right}{> 3}")

; For 1.5x speed
{::Send("{< 4}{left}{> 4}")
}::Send("{< 4}{right}{> 4}")

#HotIf ; #HotIf without anything ends the block-- everything below is global