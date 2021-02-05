#SingleInstance
username = username
password = password


; JELLY BEAN LOCATIONS
BeanY = 645 ; This is the horizontal row of beans

; Yellow - 1422, 645
YellowX = 1422 
; Red - 995, 645
RedX = 995
; Teal - 1495, 645
TealX = 1495
; Orange - 1135, 645
OrangeX = 1135


;;; OTHERS ;;;
; Plant Flower - 90, 345
PlantFlowerX = 90
PlantFlowerY = 345
; Plant - 1485, 950
PlantX = 1485
PlantY = 950
PlantingSleep = 7000
; Ok Button - 1280, 875
OkX = 1280
OkY = 880
; Water - 90, 475
WaterX = 90
WaterY = 475
WaterSleep = 50

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


 

1:: ; Test
   MouseMove, %PlantFlowerX%, %PlantFlowerY%, Client   
Return


4:: ; 4 jelly bean garden
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client    ; PLANT FLOWER
   MouseClick, left, %YellowX%, %BeanY%, Client                ; Yellow Bean
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   MouseClick, left, %TealX%, %BeanY%, Client                  ; Teal Bean
   MouseClick, left, %OrangeX%, %BeanY%, Client                ; Orange Bean
   MouseClick, left, %PlantX%, %PlantY%, Client                ; Plant Bean
   Sleep, %PlantingSleep%                                      ; Wait for shovling 
   MouseClick, left, %OkX%, %OkY%, Client                      ; Click ok button
   Sleep %WaterSleep%                                          ; Wait just a half a second
   MouseClick, left, %WaterX%, %WaterY%, Client                ; Click Water
Return

5:: ; 5 jelly bean garden
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client    ; PLANT FLOWER
   MouseClick, left, %TealX%, %BeanY%, Client                  ; Teal Bean
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   MouseClick, left                                            ; Red Bean
   MouseClick, left                                            ; Red Bean
   MouseClick, left                                            ; Red Bean
   MouseClick, left, %PlantX%, %PlantY%, Client                ; Plant Bean
   Sleep, %PlantingSleep%                                      ; Wait for shovling 
   MouseClick, left, %OkX%, %OkY%, Client                      ; Click ok button
   Sleep %WaterSleep%                                          ; Wait just a half a second
   MouseClick, left, %WaterX%, %WaterY%, Client                ; Click Water
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
