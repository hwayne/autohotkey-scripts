; Modal hotkeys and scripts. Make some hotkeys only active in a specific mode by adding
; #HotIf (g_mode == "modename") before the hotkeys. See Charscripts.ahk for an example.

; Since Include behaves like "a copy-and-paste", included scripts can reference parent variables
; We abuse this to use the g_mode global as a mode indicator.
; I use this a lot less than I used to, but it's still nice for things like superscripts

; globals are ok if you're not sharing the file with anyone else
g_mode := ""

set_mode(new_mode) {
	global g_mode
	if (g_mode == new_mode) {
		g_mode := ""
	}
	else {
		g_mode := new_mode
	}
	
	if (g_mode == "") {
		TrayTip("Normal Mode")
	} else {
		TrayTip(Format("Mode: {1}", g_mode))
	}
	; Traytip() closes any existing traytip
  ; READ MORE: https://www.autohotkey.com/docs/v2/lib/TrayTip.htm
	SetTimer () => TrayTip(), -500 ; run fun after 500 ms, ONCE
}

; I love using the numpad for hotkeys. Basically nothing REQUIRES the numpad, so it's free buttons!
; Kinda annoying when I'm on a laptop, though; I use a USB wireless numpad.

; Workshop mode is when I teach TLA+ workshops: it makes tapping the scrollwheel left-right switch to various windows


NumpadDel::set_mode("workshop")

; A limitation of the approach: can't be in workshop mode and subscript mode at the same time.
; Extending it is an exercise for the student.

NumpadAdd::set_mode("superscripts")
NumpadSub::set_mode("subscripts")
NumpadIns::set_mode("") ; No mode
