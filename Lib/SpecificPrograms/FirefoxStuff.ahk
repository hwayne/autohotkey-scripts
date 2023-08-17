; These shortcuts only work when you're in Firefox. Should be easily adaptable to Chrome or Edge or whatever.

#HotIf WinActive("ahk_exe firefox.exe")
; opens a specific group of bookmarks I positioned
; Dependent on the bookmark folder ordering

>^b::
{
  ; Keywaits make sure the button is no longer pressed.
  ; READ MORE: {Keywait}
	Keywait("RControl")
    Keywait("b")
    SendEvent("!b")
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


<^k::Send("^l")  ;remove the 'search with google' shortcut


; One second youtube moves
#HotIf WinActive("ahk_exe firefox.exe") && WinActive(" - YouTube")

; For 1.25x speed
[::Send("+<+<+<{left}+>+>+>")
]::Send("+<+<+<{right}+>+>+>")

; For 1.5x speed
{::Send("+<+<+<+<{left}+>+>+>+>")
}::Send("+<+<+<+<{right}+>+>+>+>")
#HotIf
