#SingleInstance

; Set path to the configuration file
cfgFile := "C:\Projects\Toontown-AHK\config.ini"

; Read values from the configuration file
IniRead, BeanY, %cfgFile%, JellyBeanLocations, BeanY
IniRead, YellowX, %cfgFile%, JellyBeanLocations, YellowX
IniRead, RedX, %cfgFile%, JellyBeanLocations, RedX
IniRead, TealX, %cfgFile%, JellyBeanLocations, TealX
IniRead, OrangeX, %cfgFile%, JellyBeanLocations, OrangeX
IniRead, VioletX, %cfgFile%, JellyBeanLocations, VioletX
IniRead, PinkX, %cfgFile%, JellyBeanLocations, PinkX
IniRead, GreenX, %cfgFile%, JellyBeanLocations, GreenX

IniRead, PlantFlowerX, %cfgFile%, Others, PlantFlowerX
IniRead, PlantFlowerY, %cfgFile%, Others, PlantFlowerY
IniRead, PlantX, %cfgFile%, Others, PlantX
IniRead, PlantY, %cfgFile%, Others, PlantY
IniRead, PlantingSleep, %cfgFile%, Others, PlantingSleep
IniRead, OkX, %cfgFile%, Others, OkX
IniRead, OkY, %cfgFile%, Others, OkY
IniRead, WaterX, %cfgFile%, Others, WaterX
IniRead, WaterY, %cfgFile%, Others, WaterY
IniRead, WaterSleep, %cfgFile%, Others, WaterSleep
IniRead, ClickSleep, %cfgFile%, Others, ClickSleep

IniRead, CastX, %cfgFile%, Fishing, CastX
IniRead, CastY, %cfgFile%, Fishing, CastY
IniRead, FishCloseX, %cfgFile%, Fishing, FishCloseX
IniRead, FishCloseY, %cfgFile%, Fishing, FishCloseY

IniRead, whiteCheckX, %cfgFile%, WhiteCheck, whiteCheckX
IniRead, whiteCheckY, %cfgFile%, WhiteCheck, whiteCheckY
IniRead, whiteColor, %cfgFile%, WhiteCheck, whiteColor

IniRead, chatBubbleX, %cfgFile%, Elements, chatBubbleX
IniRead, chatBubbleY, %cfgFile%, Elements, chatBubbleY
chatBubble := {x: chatBubbleX, y: chatBubbleY}

IniRead, topOfChatX, %cfgFile%, Elements, topOfChatX
IniRead, topOfChatY, %cfgFile%, Elements, topOfChatY
topOfChat := {x: topOfChatX, y: topOfChatY}

IniRead, petsX, %cfgFile%, Elements, petsX
IniRead, petsY, %cfgFile%, Elements, petsY
pets := {x: petsX, y: petsY}

IniRead, tricksX, %cfgFile%, Elements, tricksX
IniRead, tricksY, %cfgFile%, Elements, tricksY
tricks := {x: tricksX, y: tricksY}

IniRead, topOfTricksX, %cfgFile%, Elements, topOfTricksX
IniRead, topOfTricksY, %cfgFile%, Elements, topOfTricksY
topOfTricks := {x: topOfTricksX, y: topOfTricksY}

IniRead, begX, %cfgFile%, Tricks, begX
IniRead, begY, %cfgFile%, Tricks, begY
beg := {x: begX, y: begY}

IniRead, jumpX, %cfgFile%, Tricks, jumpX
IniRead, jumpY, %cfgFile%, Tricks, jumpY
jump := {x: jumpX, y: jumpY}

IniRead, danceX, %cfgFile%, Tricks, danceX
IniRead, danceY, %cfgFile%, Tricks, danceY
dance := {x: danceX, y: danceY}

IniRead, playDeadX, %cfgFile%, Tricks, playDeadX
IniRead, playDeadY, %cfgFile%, Tricks, playDeadY
playDead := {x: playDeadX, y: playDeadY}

IniRead, backflipX, %cfgFile%, Tricks, backflipX
IniRead, backflipY, %cfgFile%, Tricks, backflipY
backflip := {x: backflipX, y: backflipY}

IniRead, speakX, %cfgFile%, Tricks, speakX
IniRead, speakY, %cfgFile%, Tricks, speakY
speak := {x: speakX, y: speakY}

IniRead, rolloverX, %cfgFile%, Tricks, rolloverX
IniRead, rolloverY, %cfgFile%, Tricks, rolloverY
rollover := {x: rolloverX, y: rolloverY}

selectedTrick := ""  ; Declare selectedTrick globally, set an initial value
clickEnabled := false  ; Declare other global variables if necessary
loopEnabled := false
loopRunning := false
isTrickWindowOpen := false

runToggle := false  ; Initial state is "off"
targetWindowTitle := "Toontown Rewritten"

; Ctrl-Shift r
^+r::Reload
; Left-Alt k
<!k::Suspend, Toggle
; Left-Alt Esc
<!esc::exitapp

#IfWinActive Tricks
^t::
    loopRunning := false
    SetTimer, LoopTrick, Off  ; Stop the loop timer
    isTrickWindowOpen :=false
    Gui, TrickWindow:Destroy
    return
#IfWinActive  ; End scoped hotkeys

#IfWinActive Toontown Multicontroller
; Comment out if client is set to use arrow keys
c::Home
v::End

#IfWinActive Toontown Rewritten
; #IfWinActive ahk_exe TTREngine.exe Toontown Rewritten Launcher
; Left-Alt j
<!j::
   MsgBox, Its still working in Toontown hello
Return

; Stop the loop with Ctrl+T hotkey
^c::
    loopRunning := false
    SetTimer, LoopTrick, Off  ; Stop the loop timer
    isTrickWindowOpen :=false
    Gui, TrickWindow:Destroy
Return

; Hotkey to toggle the Trick Window
^t::ToggleTrickWindow()

; Trigger with Ctrl+G
^g::ShowGolfWindow()

Return

Up::w
Down::s 
Left::a 
Right::d

q::Home
e::End



RControl::Space

;; GUI ;;

; Function to create and show the Trick Window GUI
ShowTrickWindow() {
   global clickEnabled, selectedTrick, loopEnabled

   Gui, TrickWindow:New
   Gui, +AlwaysOnTop  ; Keep the window on top
   Gui, Add, Checkbox, vclickEnabled, Click on coordinates?

   ; Add checkbox for loop
   Gui, Add, Checkbox, vloopEnabled, Loop Trick

   ; Add more space between the checkbox and the "Select a Trick" text
   Gui, Add, Text, x10 y70, Select a Trick:
   Gui, Add, DropDownList, vselectedTrick w150, Jump!|Dance!|Play dead!|Backflip!|Speak!|Rollover!|Beg!

   Gui, Add, Button, x10 y120 w150 gPerformTrick, Perform Trick
   Gui, Show, w200 h160, Tricks
}

ShowGolfWindow() {
    Gui, GolfWindow:New
    Gui, Add, Text, x10 y10, Enter milliseconds to hold "Space":
    Gui, Add, Edit, vHoldTime w200, 2730 ; Default value of 2730 ms
    Gui, Add, Button, x10 y60 gStartGolf, Golf!
    Gui, Show, w230 h120, Golfing Tool
    return
}

StartGolf:
    Gui, Submit, NoHide
    HoldTime := HoldTime+0 ; Ensure the value is numeric
    if (HoldTime > 0) {
      if WinExist(targetWindowTitle) {
         Sleep, 250 ; Wait 1 second
         WinActivate, %targetWindowTitle%
         ; OPTIONAL: Wait to confirm activation
         Sleep, 500 ; Wait 1 second
         ; Send keystroke to the active window
         Send, {Space down}
         Sleep, HoldTime ; Hold for specified milliseconds
         Send, {Space up}
         MsgBox, 64, Success, Finished sending key!
     } else {
         MsgBox, 48, Error, Target window "%targetWindowTitle%" not found.
     }
    } else {
        MsgBox, 48, Error, Please enter a valid number of milliseconds.
    }
    return

GolfGuiClose: ; Close GUI
    Gui, GolfWindow:Destroy
    return


;; FUNCTION DEFINITIONS ;;

CheckPixelColor() {
   global whiteCheckX, whiteCheckY, whiteColor
   PixelGetColor, color, whiteCheckX, whiteCheckY, RGB

   return (color = whiteColor)
}

CheckToggle:
    if (runToggle) {
        ControlSend,, {W down}, %targetWindowTitle%  ; Send W down to the target window
   }
   return

; Function to toggle the Trick Window
ToggleTrickWindow() {
   global isTrickWindowOpen
   if (!isTrickWindowOpen) {
       isTrickWindowOpen := true
       ShowTrickWindow()
   } else {
       Gui, TrickWindow:Destroy
       isTrickWindowOpen := false
   }
}

; Map user-friendly names to variable keys
GetTrickByName(trickName) {
   global jump, dance, playDead, backflip, speak, rollover, beg
   if (trickName = "Jump!") {
       return jump
   } else if (trickName = "Dance!") {
       return dance
   } else if (trickName = "Play dead!") {
       return playDead
   } else if (trickName = "Backflip!") {
       return backflip
   } else if (trickName = "Speak!") {
       return speak
   } else if (trickName = "Rollover!") {
       return rollover
   } else if (trickName = "Beg!") {
       return beg
   }
   return false  ; Return false if no match is found
}


; Function to move cursor and optionally click
PerformTrick() {
   Gui, Submit, NoHide
   global clickEnabled, selectedTrick, loopEnabled, loopRunning

   ; Check if loop is enabled
   if (loopEnabled && !loopRunning) {
       loopRunning := true
       ; Start looping
       SetTimer, LoopTrick, 2000  ; Start a 2-second timer loop
   } else if (loopRunning) {
       loopRunning := false
       SetTimer, LoopTrick, Off  ; Stop the loop timer
   } else {
       ; Perform trick one time if not looping
       DoTrick()
   }
}

DoTrick() {
   global chatBubble, clickEnabled, topOfChat, pets, selectedTrick, tricks, topOfTricks, trickCoordinates

   ; region Start Trick
   coords := GetTrickByName(selectedTrick)
   if (not coords) {
       MsgBox, Invalid trick selected
       Return
   }
   WinActivate, Toontown Rewritten

   ; Move to each coordinate in order
   MoveCursor(chatBubble.x, chatBubble.y, true)
   MoveCursor(topOfChat.x, topOfChat.y, false)
   MoveCursor(pets.x, pets.y, false)
   MoveCursor(tricks.x, tricks.y, false)
   MoveCursor(topOfTricks.x, topOfTricks.y, false)

   ; Get the selected trick and its coordinates
   
   if (coords) {
       MoveCursor(coords.x, coords.y, clickEnabled) ; only click on the last action
   } else {
       MsgBox, Invalid trick selected.
   }
   ; endregion
}

StartListeningWater() {
   global waterCoordinates, clickEnabled
   ; Prompt user to click 3 spots where there is water with no fish
   waterCoordinates := []
   MsgBox, Please click 3 locations with water and no fish.
   SetTimer, GetClick, 100
}

GetClick:
if (clickEnabled) {
   ; Store the last 3 clicks
   MouseGetPos, xpos, ypos
   waterCoordinates.push([xpos, ypos])
   if (waterCoordinates.MaxIndex() >= 3) {
       MsgBox, Water locations gathered. You can now gather fish data.
       SetTimer, GetClick, Off
   }
   clickEnabled := false
}
Return

StartGatheringFishColor() {
   global fishColor
   ; Prompt user to click 3 spots with fish
   MsgBox, Please click 3 locations where there are fish.
   SetTimer, GetFishClick, 100
}

GetFishClick:
if (clickEnabled) {
   ; Store fish color data
   MouseGetPos, xpos, ypos
   PixelGetColor, color, xpos, ypos, RGB
   fishColor.push(color)
   if (fishColor.MaxIndex() >= 3) {
       MsgBox, Fish color data gathered. You can now start the fishing loop.
       SetTimer, GetFishClick, Off
   }
   clickEnabled := false
}
Return

StartFishingLoop() {
   global fishColor, waterCoordinates

   ; This is the loop to check for fish and cast if detected
   SetTimer, CheckForFish, 1000  ; Check every second
}

CheckForFish() {
   global fishColor, waterCoordinates
   ; Scan screen for fish color
   PixelSearch, fishX, fishY, 0, 0, A_ScreenWidth, A_ScreenHeight, fishColor[1], 0, Fast  ; Use the first fish color for detection

   if (ErrorLevel = 0) { ; If fish color is found
       ; Perform casting at that location
       MouseGetPos, xpos, ypos
       NewY := Floor((CastY - ypos)/2.75) + CastY
       NewX := CastX - (-1 * Floor((CastX - xpos)/3)) 
       MouseMove, %CastX%, %CastY%, 0
       Click down
       MouseMove, %NewX%, %NewY%, 0
       Click up
       Sleep, 100
       MouseMove, %xpos%, %ypos%, 0
       Return
   }
}

; Loop trick function (performs the trick continuously)
LoopTrick:
   global loopRunning
   if (loopRunning) {
       DoTrick()  ; Perform the selected trick
       return
   }

; Function to move cursor and optionally click
MoveCursor(x, y, forceClick) {
   MouseMove, %x%, %y%, 1  ; Move cursor with slight delay
   if (forceClick)
       Click
   Sleep, 500  ; Pause briefly to simulate human interaction
}

; R::
;    if CheckPixelColor() {
;       Return
;    }
;    runToggle := !runToggle  ; Toggle the state
;     if (runToggle) {
;         SetTimer, CheckToggle, 10  ; Start checking toggle every 10ms
;     } else {
;         SetTimer, CheckToggle, Off  ; Stop checking toggle
;         ControlSend,, {W up}, %targetWindowTitle%  ; Release W in the target window
;     }
;     return

W::

   if (runToggle) {
      return  ; Do nothing if toggle is active
   }
   ; Set the W key down if it's not already
   if GetKeyState("W", "P") {  ; If W is not already pressed
      Send, {w down}  ; Press W down
   }
   
   ; Wait until the W key is released before sending the up command
   while GetKeyState("W", "P") {
         Sleep, 10  ; Check if the W key is still held down
   }
   
   Send, {w up}  ; Release W when it is no longer pressed
   return

~S::

   if (runToggle) {
      SetTimer, CheckToggle, Off  ; Stop checking toggle
      ControlSend,, {W up}, %targetWindowTitle%  ; Release W in the target window
   }

   return



$'::
   if CheckPixelColor() {
      Return
   }
    Send, {' down}
    Send, {' up} 
Return

$Delete::
    Send, {Delete down}
    Send, {Delete up} 
Return

1:: ; Test
   if CheckPixelColor() {
      Return
   }
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client   
Return

3:: ; 4 jelly bean garden
   if CheckPixelColor() = True {
      Return
   }
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client    ; PLANT FLOWER
   Sleep, %ClickSleep%
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left, %PlantX%, %PlantY%, Client                ; Plant Bean
   Sleep, %PlantingSleep%                                      ; Wait for shovling 
   MouseClick, left, %OkX%, %OkY%, Client                      ; Click ok button
   Sleep %WaterSleep%                                          ; Wait just a half a second
   MouseClick, left, %WaterX%, %WaterY%, Client                ; Click Water
Return

4:: ; 4 jelly bean garden
   if CheckPixelColor() = True {
      Return
   }
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client    ; PLANT FLOWER
   Sleep, %ClickSleep%
   MouseClick, left, %YellowX%, %BeanY%, Client                ; Yellow Bean
   Sleep, %ClickSleep%
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left, %TealX%, %BeanY%, Client                  ; Teal Bean
   Sleep, %ClickSleep%
   MouseClick, left, %OrangeX%, %BeanY%, Client                ; Orange Bean
   Sleep, %ClickSleep%
   MouseClick, left, %PlantX%, %PlantY%, Client                ; Plant Bean
   Sleep, %PlantingSleep%                                      ; Wait for shovling 
   MouseClick, left, %OkX%, %OkY%, Client                      ; Click ok button
   Sleep %WaterSleep%                                          ; Wait just a half a second
   MouseClick, left, %WaterX%, %WaterY%, Client                ; Click Water
Return

5:: ; 5 jelly bean garden
   if CheckPixelColor() {
      Return
   }
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client    ; PLANT FLOWER
   Sleep, %ClickSleep%
   MouseClick, left, %TealX%, %BeanY%, Client                  ; Teal Bean
   Sleep, %ClickSleep%
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left, %PlantX%, %PlantY%, Client                ; Plant Bean
   Sleep, %PlantingSleep%                                      ; Wait for shovling 
   MouseClick, left, %OkX%, %OkY%, Client                      ; Click ok button
   Sleep %WaterSleep%                                          ; Wait just a half a second
   MouseClick, left, %WaterX%, %WaterY%, Client                ; Click Water
Return

6:: ; 6 jelly bean garden
   if CheckPixelColor() {
      Return
   }
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client    ; PLANT FLOWER
   Sleep, %ClickSleep%
   MouseClick, left, %TealX%, %BeanY%, Client                  ; Teal Bean
   Sleep, %ClickSleep%
   MouseClick, left, %RedX%, %BeanY%, Client                   ; Red Bean
   Sleep, %ClickSleep%
   MouseClick, left, %VioletX%, %BeanY%, Client                ; Violet Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Violet Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Violet Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Violet Bean
   Sleep, %ClickSleep%
   MouseClick, left, %PlantX%, %PlantY%, Client                ; Plant Bean
   Sleep, %PlantingSleep%                                      ; Wait for shovling 
   MouseClick, left, %OkX%, %OkY%, Client                      ; Click ok button
   Sleep %WaterSleep%                                          ; Wait just a half a second
   MouseClick, left, %WaterX%, %WaterY%, Client                ; Click Water
Return

7:: ; 7 jelly bean garden
   if CheckPixelColor() {
      Return
   }
   MouseClick, left, %PlantFlowerX%, %PlantFlowerY%, Client    ; PLANT FLOWER
   Sleep, %ClickSleep%
   MouseClick, left, %PinkX%, %BeanY%, Client                  ; Pink Bean
   Sleep, %ClickSleep%
   MouseClick, left, %GreenX%, %BeanY%, Client                 ; Green Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Green Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Green Bean
   Sleep, %ClickSleep%
   MouseClick, left                                            ; Green Bean
   Sleep, %ClickSleep%
   MouseClick, left, %YellowX%, %BeanY%, Client                ; Yellow Bean
   Sleep, %ClickSleep%
   MouseClick, left, %GreenX%, %BeanY%, Client                 ; Green Bean
   Sleep, %ClickSleep%
   MouseClick, left, %PlantX%, %PlantY%, Client                ; Plant Bean
   Sleep, %PlantingSleep%                                      ; Wait for shovling 
   MouseClick, left, %OkX%, %OkY%, Client                      ; Click ok button
   Sleep %WaterSleep%                                          ; Wait just a half a second
   MouseClick, left, %WaterX%, %WaterY%, Client                ; Click Water
Return

^f::
   MouseGetPos, xpos, ypos
   MouseClick, left, FishCloseX, FishCloseY, Client
   MouseMove, %xpos%, %ypos%, 0
Return

; RIGHT CLICK - FISHING
RButton::
   MouseGetPos, xpos, ypos 
   NewY := Floor((CastY - ypos)/2.75) + CastY
   NewX := CastX - (-1 * Floor((CastX - xpos)/2.75)) 
   ; MsgBox, %CastY% now equals: %NewY% based on ypos %ypos%`n %CastX% now equals: %NewX% based on xpos %xpos%
   Sleep, 50
   MouseMove, %CastX%, %CastY%, 0
   Click down
   ; MsgBox, X: %CastX%, %NewY%
   Sleep, 250
   MouseMove, %NewX%, %NewY%, 0
   Click up
   Sleep, 250
   MouseMove, %xpos%, %ypos%, 0
Return

; Ctrl Right Click
^RButton::
   MouseGetPos, xpos, ypos 
   PixelGetColor, color, %xpos%, %ypos%, RGB
   MsgBox, The cursor is at X%xpos% Y%ypos% with color %color%.
Return


#IfWinActive ; end of Active Window checking

; Close GUI event
TrickGuiClose:
    loopRunning := false
    isTrickWindowOpen :=false
    Gui, TrickWindow:Destroy
    Return