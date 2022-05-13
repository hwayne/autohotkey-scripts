
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force ; No others
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetMouseDelay, 100
SetKeyDelay, 40
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
GroupAdd, mail, ahk_exe thunderbird.exe
GroupAdd, hh, ahk_exe hh.exe
GroupAdd, firefox, ahk_exe firefox.exe 
GroupAdd, files, ahk_class CabinetWClass
GroupAdd, zoom, ahk_exe Zoom.exe
GroupAdd, alloy, ahk_class SunAwtFrame ; poor subsitute but works

GroupAdd, editors, ahk_exe Code.exe
GroupAdd, editors, ahk_exe nvim-qt.exe

GroupAdd, terminal, ahk_exe WindowsTerminal.exe
GroupAdd, terminal, ahk_exe powershell.exe
GroupAdd, terminal, ahk_exe powershell_ise.exe

GroupAdd, slides, ahk_class AcrobatSDIWindow
GroupAdd, slides, ahk_exe POWERPNT.EXE

GroupAdd, workshop, ahk_exe firefox.exe 
GroupAdd, workshop, ahk_class AcrobatSDIWindow
GroupAdd, workshop, ahk_class SunAwtFrame ; poor subsitute but works
GroupAdd, workshop, TLA\+ Toolbox

; Yay globals
g_mode := ""


Return ; END OF HEADERS

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
#!c::
	ctmp := clipboard
	clipboard := ""
	Send ^c
	ClipWait, 2
	clipboard := "[" . clipboard . "](" . ctmp . ")"
Return

; Same as above, but use title too
; (I don't ever use this one)
>^>!c::
	clipboard := ""
	Send ^c
	ClipWait, 2
	ctmp := clipboard
	Send ^l
	Sleep, 400
	clipboard := ""

	Send ^c
	ClipWait, 2
	clipboard := "[" . ctmp . "](" . clipboard . ")"
Return






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

>!1:: GroupActivate, firefox, R
>!t:: toggle_app("TLA\+ Toolbox", "")
>!2:: GroupActivate, editors, R

>!e:: GroupActivate, mail, R
>!h:: GroupActivate, hh, R
>!p:: GroupActivate, slides, R
>!f:: GroupActivate, files, R
>!x:: GroupActivate, terminal, R
>!c:: GroupActivate, editors, R
>!z:: GroupActivate, zoom, R
>!a:: GroupActivate, alloy, R
>!.:: GroupActivate, workshop, R
 
#If (g_mode = "workshop") 
	F1:: GroupActivate, workshop, R
	F2:: GroupActivate, zoom, R
	
	F4:: FileClone.Clone()
#If

>^>+d::
FormatTime, TimeString,, MM/dd hh:mm tt
;TrayTip ,, %TimeString%, 1, ; too long
Tooltip %TimeString%
SetTimer, RemoveToolTip, -700
return

RemoveToolTip:
ToolTip
return

RemoveTrayTip:
TrayTip
return


; Timestamp tracking
>^d::
FormatTime, TimeString,, MM/dd hh:mm tt
InputBox, t_msg, Timestamp,,,200,100,,,,,
if !ErrorLevel { ;ErrorLevel is 0 if ok, nonzero if cancel
	timestampfile := A_WorkingDir . "\Config\timestamps.txt"
	FileAppend, %TimeString%	%t_msg%`r`n, %timestampfile%
}
return

; Alloy proper tab
#IfWinActive, Alloy Analyzer 5.1.0
Tab::Send {Space}{Space}

; Open current selected file in notepad
#IfWinActive, ahk_class CabinetWClass
>!o::
	clipboard := ""
	Send ^c
	ClipWait, 2
	Run, notepad.exe `"%clipboard%`"
	return
#IfWinActive

