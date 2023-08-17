/* 
Takes a selected time information and converts it to Central and UTC.
An example of how to shell out to another program.
NOTE: this uses timeshim.py, which requires the click and timeutils packages!
*/

get_timezone() {
	A_clipboard := ""
	Send "^c" ; only way to get selected text is to copy it
	ClipWait 2

	timeshim := A_WorkingDir . "\Lib\Aux-Scripts\timeshim.py" ; TODO use A_ScriptDir somehow
	cmd := Format("pythonw.exe {1} --date=`"{2}`"", timeshim, A_Clipboard)
	
	run(A_ComSpec Format(" /c `"{1}`"", cmd), , "Hide")
}

/* Try it on the following!

10 AM
16:00 EST
*/
