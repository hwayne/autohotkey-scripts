; Lets you insert subscripts and superscripts with rctrl+0 etc.
; g_mode is from ModesModal.ahk

#HotIf (g_mode != "subscripts")
	>^0:: Send("⁰")
	>^1:: Send("¹")
	>^2:: Send("²")
	>^3:: Send("³")
	>^4:: Send("⁴")
	>^5:: Send("⁵")
	>^-:: Send("⁻")
	>^+:: Send("⁺")
	>^m:: Send("ᵐ")
	>^n:: Send("ⁿ")

	 	 	

#HotIf (g_mode = "subscripts")
	>^0:: Send("₀")
	>^1:: Send("₁")
	>^2:: Send("₂")
	>^3:: Send("₃")
	>^4:: Send("₄")
	>^5:: Send("₅")
	>^-:: Send("₋")
	>^+:: Send("₊")
	>^i:: Send("ᵢ")
	>^=:: Send("₊")
	>^m:: Send("ₘ")
	>^n:: Send("ₙ")
#HotIf
