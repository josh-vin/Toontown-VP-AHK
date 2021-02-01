#SingleInstance
username = username
password = password
<!j::
   MsgBox, Its working
Return
^+r::Reload
<!k::Suspend, Toggle
<!esc::exitapp

#IfWinActive Toontown Rewritten
; #IfWinActive ahk_exe TTREngine.exe Toontown Rewritten Launcher
<!j::
   MsgBox, Its still working in Toontown
Return

$'::
    Send, {' down}
    Send, {' up} 
Return

$Delete::
    Send, {Delete down}
    Send, {Delete up} 
Return

#IfWinActive ahk_exe Launcher.exe
<!j::
   MsgBox, Its still working in Toontown Launcher
Return
<!l::
   Send, %username%{Tab}%password%{Enter}
Return
+l::
   Send, %password%{Enter}
Return
