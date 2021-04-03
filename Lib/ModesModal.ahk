; Since Include behaves like "a copy-and-paste", included scripts can reference parent variables
; We abuse this to use the g_mode global as a mode indicator

set_mode(new_mode) {
	global g_mode
	if (g_mode = new_mode) {
		g_mode := ""
	}
	else {
		g_mode := new_mode
	}
	
	if (g_mode = "") {
		TrayTip,, Normal Mode, 20, 17		
	} else {
		TrayTip,, Mode: %g_mode%, 20, 17
	}
	return
	
}

NumpadDel::set_mode("workshop")

NumpadEnd::set_mode("folders")
NumpadDown::set_mode("launcher")

; Probably want to be using separate mode objects to allow overlapping, right?
NumpadAdd::set_mode("superscripts")
NumpadSub::set_mode("subscripts")
NumpadIns::set_mode("")

; MODE IDEAS
; File mover?
; Inserter for a specific type of data
; Tagging things
; Paper trawling mode
	
	
