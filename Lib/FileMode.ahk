
toggle_file_loc(app) 
{
	tmp := A_TitleMatchMode
	SetTitleMatchMode, 3 ; Otherwise regex mode interprets \ as escapes
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
		Run, explorer.exe %app%
	}
	SetTitleMatchMode, %tmp%
}

; Some examples
#If (g_mode = "folders")

a::toggle_file_loc("D:\Software\AutoHotKey")
+a::toggle_file_loc("D:\Software\Alloy")

+t::toggle_file_loc("D:\Software\TLA+")

+s::toggle_file_loc("D:\Software\TLA+\Specs")

w::toggle_file_loc("D:\website")
#If 