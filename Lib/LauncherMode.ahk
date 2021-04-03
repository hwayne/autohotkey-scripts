;This can probably be turned into an Input, I discovered that after adding modal functionality

#If (g_mode = "launcher")
+a::toggle_app("ahk_exe anki.exe", "C:\Program Files\Anki\anki.exe")

f::toggle_app("Frink", "D:\Software\Frink\frink.jar")
j::toggle_app("ahk_exe jqt.exe", "D:\Software\J\bin\jqt.exe")
+s::toggle_app("Window Spy", "C:\Program Files\AutoHotkey\WindowSpy.ahk")
#If