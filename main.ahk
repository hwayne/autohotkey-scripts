
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force ; No others
#Requires AutoHotkey >=2.0
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetKeyDelay 40 ; not actually used except when using SendRaw/Event
SetMouseDelay 40
SetTitleMatchMode RegEx

; Since AHK doesn't have modules, classes are a good way to contain state.
#Include <Researcher>
Research := new Researcher()

#Include <ClipImageSaver>
ClipImageSave := new ClipImageSaver()

#Include <FileCloner>
FileClone := new FileCloner()

; You can use the WindowSpy script to get the names and classes of programs
; WindowSpy comes with AutoHotKey
GroupAdd("mail", "ahk_exe thunderbird.exe")
GroupAdd("mail", "ahk_exe OUTLOOK.EXE")
GroupAdd("hh", "ahk_exe hh.exe ") ;ahk help
GroupAdd("firefox", "ahk_exe firefox.exe")
GroupAdd("files", "ahk_class CabinetWClass")
GroupAdd("zoom", "ahk_exe Zoom.exe")
GroupAdd("zoom", "ahk_exe Teams.exe")
GroupAdd, alloy, ahk_class SunAwtFrame ; poor subsitute but works

GroupAdd("alloy", "ahk_class SunAwtFrame ") ; poor subsitute but works

GroupAdd("editors", "ahk_exe Code.exe")
GroupAdd("editors", "ahk_exe nvim-qt.exe")

GroupAdd("terminal", "ahk_exe WindowsTerminal.exe")
GroupAdd("terminal", "ahk_exe powershell.exe")
GroupAdd("terminal", "ahk_exe powershell_ise.exe")

GroupAdd("slides", "ahk_class AcrobatSDIWindow")
GroupAdd("slides", "ahk_exe POWERPNT.EXE")

GroupAdd("workshop", "ahk_exe firefox.exe")
GroupAdd("workshop", "ahk_class AcrobatSDIWindow")
GroupAdd("workshop", "ahk_class SunAwtFrame ") ; poor subsitute but works
GroupAdd("workshop", "TLA+ Toolbox")
GroupAdd("workshop", "ahk_exe Code.exe")
GroupAdd("workshop", "ahk_class PodiumParent")

; globals are ok if you're not sharing the file with anyone else
g_mode := ""


#Include Hotstrings.ahk
#Include <HotStringAdder>
#Include <FirefoxStuff>

#Include <ModesModal>
#Include <CharScripts>
#Include <FileMode>

; Some notes on hotkey modifier symbols
; # = Winkey
; + = shift
;   (hotkeys are otherwise case insensitive, c:: = C:: ≠ +c::
; ^ = ctrl
; ! = alt
; > = RIGHT modifier. >^c is "right ctrl + c"
;   good for not accidentally overriding builtin chords

; !!! IMPORTANT !!!
; These let you update and reload your config on the fly
; They are super, SUPER IMPORTANT
; (They also only work if you're running an .ahk file, not a compiled .exe)
#!.::Reload
#!,::Edit

; Format copy as markdown link
; Unfortunately there's no way to get selected text without copying it to the clipboard
#!c:: {
  ctmp := A_clipboard ; Save what's on the clipboard for later formatting
  A_clipboard := ""
  Send "^c"
  ClipWait 2 ; Wait until there's non-empty data on the clipboard
  A_clipboard := "[" . A_clipboard . "](" . ctmp . ")"
}





; For things that are unique
toggle_app(app, location) 
{
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
	else if location != ""
	{
		Run, %location%
	}
}

#Include <LauncherMode>

#=::Research.SetNoteType()
#+::Research.AddNote()
#D::Research.JotNote()
#?::Research.OpenNotes()


; TODO make this its own file/function/whatever
NumpadClear::
	researchmap := {t: "therapy", d: "diary", l: "learn", r: "recs", m: "memo", s: "slush"}
  ; Input is INCREDIBLY useful for making key combinations, like if you want
  ; `a THEN b` to trigger a hotkey
	Input, NewNoteType, L1 T1,, t,d,r,l,m,s
	if (ErrorLevel = "Match") {
		tmp_x := researchmap[NewNoteType]
		Research.SetTo(tmp_x)
		TrayTip,, Note type: %tmp_x%, 20, 17
		SetTimer, RemoveTrayTip, -700
	}
return


#>^s::ClipImageSave.SaveClip()
#>^+s::ClipImageSave.FastSaveClip()


; This has to be a .lnk file because spotify is an app, not an .exe. It's weird.
>!s::toggle_app("ahk_exe Spotify.exe", "D:\Software\AutoHotKey\Lib\Spotify.lnk")

; Switch to a window of whichever type.
; IE right-alt+1 switches through firefox windows.
; All of these use right-alt+char because consistency is cool

>!1:: GroupActivate("firefox", "R")
>!2:: GroupActivate("editors", "R")
>!e:: GroupActivate("mail", "R")
>!h:: GroupActivate("hh", "R")
>!p:: GroupActivate("slides", "R")
>!f:: GroupActivate("files", "R")
>!x:: GroupActivate("terminal", "R")
>!c:: GroupActivate("editors", "R")
>!z:: GroupActivate("zoom", "R")
>!a:: GroupActivate("alloy", "R")
>!.:: GroupActivate("workshop", "R")
 
; These hotkeys are only active if the condition is true
; In this case, we're in "workshop mode"
#HotIf (g_mode = "workshop")
  ; I love using wheelleft and wheelright for hotkeys because almost no Software
  ; uses them, so they're "free"
  WheelLeft:: GroupActivate("workshop", "R")
  WheelRight:: GroupActivate("zoom", "R")
	
	F4:: FileClone.Clone()
#HotIf


; Makes a tooltip with the current time.
; >^>+d --> right-ctrl + right-shift + d 
>^>+d::
{
  Tooltip(FormatTime(,"MM/dd hh:mm tt"))
  ; Tooltip() closes any existing tooltip
  SetTimer(() => ToolTip(), -700) ;-700 = in 700 ms, run ONCE
}


; Timestamp tracking
>^d::
{
  TimeString := FormatTime(,"MM/dd hh:mm tt")
  t_msg := InputBox(,TimeString,"w200 h100")
  if t_msg.Result = "OK" {
    timestampfile := A_WorkingDir . "\Config\timestamps.txt"
    FileAppend(TimeString . "`t" . t_msg.Value . "`r`n", timestampfile)
  }
}

; Alloy proper tab
#HotIf WinActive("Alloy Analyzer 6.1.0")
Tab::Send {Space}{Space}

; We don't need a closing #HotIf because the following #HotIf automagically ends the old one

; Open current selected file in notepad
#HotIf WinActive("ahk_class CabinetWClass")
>!o::{
  A_clipboard := ""
  Send "^c"
  ClipWait 2
  Run(Format("notepad.exe `"{1}`"", A_clipboard)) ; This doesn't handle spaces in filenames and I don't yet know why 
}

#HotIf
