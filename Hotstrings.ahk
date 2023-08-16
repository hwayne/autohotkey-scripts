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

; MISC STUFF

::;ahk::AutoHotKey
::;shrug::¯\_(ツ)_/¯ 

; DATE FUNCTIONS

:R:;date:: 
{
    Send(FormatTime(,"M/d/yyyy"))
}

:R:;iso:: 
{
    Send(FormatTime(,"yyyy-MM-dd"))
}


; AUTOGEN

:R:;ESE::Empirical Software Engineering
:R:;lq::« 
:R:;rq::»
:R:;pm::±
:R:;deg::°
:R:;zed::ℤ
:R:;notin::∉
:R:;mapsto::↦
:R:;lam::λ
:R:;to::→
:R:;alpha::α
:R:;tau::τ
:R:;mdshrug::¯\\\_(ツ)\_/¯
:R:;congruent::≅
:R:;neg::¬
:R:;range::Range(f) == {f[x] : x \in DOMAIN f}`r

