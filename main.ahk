
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force ; No others
#Requires AutoHotkey >=2.0
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetKeyDelay 40 ; not actually used except when using SendRaw/Event
SetMouseDelay 40
SetTitleMatchMode "RegEx"


#Include Hotstrings.ahk ; Replace what you type with something else.

; NEWB CUTOFF
; If you copy just the above stuff and the hotstrings.ahk file, you'll have enough to get started with AHK.


#Include <HotStringAdder> ; Easily add new hotstrings
#Include <SpecificPrograms/FirefoxStuff> ; Special commands for just firefox.

#Include <ModesModal> ; Add ahk modes (a la vim) to your whole computing experience
#Include <CharScripts> ; subscripts and superscripts
#Include <Launchers/Folders> ; Open specific folders from anywhere with just your keyboard
#Include <Launchers/AHKFiles> ; Ditto, but for AHK files
#Include <WindowSwitching> ; Switch to specific windows with just your keyboard


; Some notes on hotkey modifier symbols
; # = Winkey
; + = shift
;   (hotkeys are otherwise case insensitive, c:: = C:: ≠ +c::
; ^ = ctrl
; ! = alt
; > = RIGHT modifier. >^c is "right ctrl + c"
;   good for not accidentally overriding builtin chords

; MAIN.AHK HOTKEYS BELOW HERE
; I like to put impromptu hotkeys in main, and then if they start coalescing around a theme
; (like firefox hotkeys), I create a separate imported file for them.

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

; Since AHK doesn't have modules, classes are a good way to contain state.
#Include <Researcher>
Research := Researcher()

; These are win+ctrl+key, but the RIGHT ctrl, so won't conflict.
; My own setup just uses win+key, which is a bad habit and you shouldn't do it.
#>^=::Research.SetNoteType()
#>^+::Research.AddNote()
#>^d::Research.JotNote()
#>^?::Research.OpenNotes()


 
; These hotkeys are only active if the condition is true
; In this case, we're in "workshop mode"
#HotIf (g_mode = "workshop")
  ; I love using wheelleft and wheelright for hotkeys because almost no Software
  ; uses them, so they're "free"
  WheelLeft:: GroupActivate("editors", "R")
  WheelRight:: GroupActivate("zoom", "R")
#HotIf

; Make sure to read Timezone.ahk to understand how this works.
#Include <Timezone>
#`::get_timezone()


; Makes a tooltip with the current time.
; >^>+d --> right-ctrl + right-shift + d 
>^>+d::
{
  Tooltip(FormatTime(,"MM/dd hh:mm tt"))
  ; Tooltip() closes any existing tooltip
  ; READ MORE: {toolip}
  SetTimer(() => ToolTip(), -700) ;-700 = in 700 ms, run ONCE
}


; Timestamp tracking
>^d::
{
  TimeString := FormatTime(,"MM/dd hh:mm tt")
  ; Inputboxes let you get text input from user.
  ; READ MORE: {Inputbox}
  t_msg := InputBox(,TimeString,"w200 h100")
  if t_msg.Result = "OK" {
    timestampfile := A_WorkingDir . "\Config\timestamps.txt"
    FileAppend(TimeString . "`t" . t_msg.Value . "`r`n", timestampfile)
  }
}

; The Alloy Analyzer is a homebrew IDE without a "tabs to spaces" option.
; This is a hack to make the tab key send spaces. 
#HotIf WinActive("Alloy Analyzer 6.1.0")
Tab::Send "{Space}{Space}"

; We don't need a closing #HotIf because the following #HotIf automagically ends the old one

; Open current selected file in notepad
#HotIf WinActive("ahk_class CabinetWClass") ; Explorer window, gotten with window spy
>!o::{
  A_clipboard := ""
  Send "^c"
  ClipWait 2
  Run(Format("notepad.exe `"{1}`"", A_clipboard)) ; This doesn't handle spaces in filenames and I don't yet know why 
}

#HotIf
