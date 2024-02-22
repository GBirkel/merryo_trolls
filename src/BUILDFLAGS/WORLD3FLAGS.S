* In the build.sh build sequence, this file is tacked onto MAIN.S to create a file called WORLD#.S
* This is done to define global build flags for each World separately.
* Conditional code inclusion that redefines globals does not work in Merlin32, and
* you cannot nest PUT commands in any version of Merlin.

World   =       3 ; Munchies Land

* Using 'DO' and some math on World for conditional code inclusion worked on Merlin16
* But it relied on negative and fractional values being equivalent to 0.
* Merlin32 documentation frowns on this.
BuildingWorld1  = 0
BuildingWorld2  = 0
BuildingWorld3  = 1
BuildingWorld4  = 0
BuildingWorld5  = 0
BuildingWorld6  = 0
BuildingWorld7  = 0

* Include these sprites
BF_S_Chstr  =     1
BF_S_Flowr  =     0
BF_S_Snail  =     1
BF_S_Turtl  =     0

* Visual effects

* The vertical "funky" effect
BF_VrtFunk  =     0
* The "heat wave" effect
BF_HeatWav  =     0
* De-rezz effect for exiting a level or dying
BF_DeRezz   =     0

* Map features

* Include platform slopes
BF_Slopes   =     0
* Whether the screen can scroll left
BF_ScrlLft  =     1
* Half-height connect-based-sprite buttons
BF_Buttons  =     0
* Techno Land tv screens (buttons required)
BF_TVScrns  =     0

* Include joystick path recorder
BF_Recordr  =     0
* Compile the blockset
BF_BlkComp  =     1

BF_SFXCode  =     0

* The size of one scanline's worth of PEA data in the PEA field.
* Usually 320 pixels / 2 = 160 bytes, grouped into 80 words each with a PEA instruction,
* for a total of 160+80 bytes = 240 bytes ($F0).
* Additional code can be appended to the PEA chain for per-line effects,
* for example "SBC $00,x" "TCS" for the heat wave effect in World 6,
* which adds three bytes to each line for a total of $F3.
BF_SizLine  =     $F0
BF_SizCode  =     $00
