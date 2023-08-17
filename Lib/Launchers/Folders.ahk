; A script to open a folder from anywhere on the computer.
; For example, if you press NumpadEnd and then press 'p', it will open your onedrive picture folder.
; Pressing NumpadEnd and then `?` will list all of the folders you can navigate to.

toggle_file_loc(app)
{
	tmp := A_TitleMatchMode
	SetTitleMatchMode 3 ; Otherwise regex mode interprets \ as escapes
	if WinExist(app)
		{
		
		if !WinActive(app)
			{
			WinActivate
		}
		else
			{
			WinMinimize
		}
	}
	else
		{
		
		Run("explore " . app)
	}
	SetTitleMatchMode(tmp)
}

NumpadEnd:: {
	; Change the line below if you have Onedrive somewhere else.
	; Or just use full filepaths to everything, I'm not your boss
	onedrive := "C:\Users\" . A_UserName . "\OneDrive"
	
	; Note this is a MAP object, which is new to AHK-v2.
	; Regular objects have case-insensitive keys, so you can't have
	; both `p` and `P` map to different things!

	; READ MORE: https://www.autohotkey.com/docs/v2/lib/Map.htm
	
	file_frame := Map(
		; Some examples. Fill in your own.
		"o", onedrive
		, "p", onedrive . "\Pictures\"
		, "P", onedrive . "\Documents\PowerShell"
		; etc etc etc
	)
	
	; We're going to read the folder key with InputHook, which takes a list of "match keys" in the form
	; of a single comma-separated string. So we have to build that string of matches first.
	
	file_input := "?" ; so ? is a key (for getting options)
	file_out := "" ; the options string
	
	
	for key, val in file_frame {
		file_input .= "," . key 
		file_out .= key . "`t" . val . "`n"
	}
	
	; Our InputHook object.
	; L1 C T1 -> max input length, case sensitive, how long to wait for keypresses.
	; If you made it L2, then you could have two-character keys (like `ad`).
	; READ MORE: https://www.autohotkey.com/docs/v2/lib/InputHook.htm
	ih := InputHook("L2 C T1",, file_input)
	
	; You can have multiple inputhooks run simultaneously, but I've never tried to do that.
	ih.Start()
	; .Wait() returns "Match" if you input a matching key, otherwise returns the termination reason.
	if (ih.Wait() == "Match") {
		if (ih.Match == "?") {
			MsgBox(file_out) ; show all of the folder options
		}
		else {
			toggle_file_loc(file_frame[ih.Match])
		}
	}
}