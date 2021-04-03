#IfWinActive ahk_exe firefox.exe
; opens a specific group of bookmarks I positioned
; Dependent on the bookmark folder ordering
>^b:: 
	Keywait, RControl
	Keywait, b
	SendEvent, !b
	SendEvent, {down}{down}{down}{right}meo
	return

; Reopens page in sci-hub
; Todo probably better to do this as clipboard manipulation than as throwing in raw keystrokes
>!^s::
	Keywait, RControl
	Keywait, RAlt
	SendEvent, ^l
	SendInput, {left}sci-hub.st/{enter}
return


; should I make these functions?
; Nah
; Reopens page in archive.org
>!^a::
	Keywait, RControl
	Keywait, RAlt
	SendEvent, ^l
	SendInput, {left}https://web.archive.org/web/*/{enter}
return

^k::Send, ^l ;remove the 'search with google' shortcut

#IfWinActive

; One second youtube moves
#If WinActive("ahk_exe firefox.exe") && WinActive(" - YouTube")

  [::
    send, +<+<+<{left}+>+>+>
  return 

  ]::
    ; msgbox, 
    send, +<+<+<{right}+>+>+>
  return 

#If 