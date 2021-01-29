#SingleInstance
^j::
   MsgBox, Its still working
Return
^+r::Reload

^esc::exitapp
#IfWinActive Toontown Rewritten
; #IfWinActive ahk_exe TTREngine.exe
^j::
   MsgBox, Its still working in Toontown
Return


^k::Suspend, Toggle

Delete::
    Send, {Delete down}
    Sleep, 10
    Send, {Delete up} 
Return
