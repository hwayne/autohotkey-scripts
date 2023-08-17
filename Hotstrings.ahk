; Hotstrings are text that's replaced when you type them. I use a lot of them, they're super handy.
; READ MORE: https://www.autohotkey.com/docs/v2/Hotstrings.htm

; All my hotstrings start with a ; so that I unintentionally trigger any of them
; eg `::e::foo` --> triggers if I type ` e `, can easily happen by accident
; `::;e::` triggers if I type ` ;e `, never happens in day-to-day programming

; MATH STUFF
; O means it doesn't add a space after completing
:O:;e::∃
:O:;a::∀
::;in::∈
::;cup::∪
::;cap::∩
::;subset::⊆
:O:;sq::□
:O:;circ::◯
:O:;diamond::◇
::;and::⋀
::;or::⋁
::;dar::⇒
::;implies::⇒
:O:;not::¬
::;infty::∞
::;iff::⇔
::;equiv::≡
::;approx::≈
::;neq::≠ 
::;leq::≤
::;geq::≥
:O:;nat::ℕ
:O:;int::ℤ
:O:;real::ℝ
::;pi::π
::;mapsto::↦

; DATE FUNCTIONS
; Hotstrings can also trigger functions!
:R:;date:: 
{
    Send(FormatTime(,"M/d/yyyy"))
}

:R:;iso:: 
{
    Send(FormatTime(,"yyyy-MM-dd"))
}

; MISC STUFF

::;ahk::AutoHotKey
::;shrug::¯\_(ツ)_/¯ 
:R:;mdshrug::¯\\\_(ツ)\_/¯
:R:;zoom::https://myzoomlink.zoom.us/
::;adr::My address (street and apt num)
::;fadr::Full address (street, city, state, zip)

; AUTOGEN
; Anything added by the HotStringAdder.ahk will go below here.

