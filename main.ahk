
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

; Groups are collections of window queries that you can operate on as a group,
; IE show all of them, hide all of them, close the most recently active, etc.
; READ MORE: TODO

; You can use the WindowSpy script to get the names and classes of programs
; WindowSpy comes with AutoHotKey

GroupAdd("hh", "ahk_exe hh.exe ") ;ahk help

; If you add multiple queries to a group, all queries that match any will be used
GroupAdd("mail", "ahk_exe thunderbird.exe")
GroupAdd("mail", "ahk_exe OUTLOOK.EXE")
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
GroupAdd("workshop", "TLA+ Toolbox")
GroupAdd("workshop", "ahk_exe Code.exe")
GroupAdd("workshop", "ahk_class PodiumParent")

; Switch to a window of whichever type.
; IE right-alt+1 switches through firefox windows.
; All of these use right-alt+char because consistency is cool

; GroupActivate(name, "R") activates ONE window. Otherwise it activates them all.
; READ MORE: TODO

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


; globals are ok if you're not sharing the file with anyone else
g_mode := ""


#Include Hotstrings.ahk ; Replace what you type with something else.

; NEWB CUTOFF
; If you copy just the above stuff and the hotstrings.ahk file, you'll have enough to get started with AHK.

#Include <HotStringAdder> ; Easily add new hotstrings
#Include <FirefoxStuff> ; Special commands for just firefox.

#Include <ModesModal> ; Add ahk modes (a la vim) to your whole computing experience
#Include <CharScripts> ; subscripts and superscripts
#Include <FileMode> ; Open specific folders from anywhere with just your keyboard

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
; They are super, SUPER USEFUL
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

; These all are just win+key and may conflict with other program hotkeys. This is a bad idea,
; don't do this.

#=::Research.SetNoteType()
#+::Research.AddNote()
#d::Research.JotNote()
#?::Research.OpenNotes()

; These are win+ctrl+key, but the RIGHT ctrl, so won't conflict.
#>^s::ClipImageSave.SaveClip()
#>^+s::ClipImageSave.FastSaveClip()


 
; These hotkeys are only active if the condition is true
; In this case, we're in "workshop mode"
#HotIf (g_mode = "workshop")
  ; I love using wheelleft and wheelright for hotkeys because almost no Software
  ; uses them, so they're "free"
  WheelLeft:: GroupActivate("editors", "R")
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

; The Alloy Analyzer is a homebrew IDE without a "tabs to spaces" option.
; This is a hack to make the tab key send spaces. 
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
