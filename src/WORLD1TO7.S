         LST   ON
*  Merryo Trolls loader v1.31n
*  Merryo Trolls player v1.78t
*       (c) Garote '93
*
         lst   off

*World    KBD   "World number compiling for (1-7)"  ; Not supported by Merlin32
World   =       "1"

         TR    ADR
         LSTDO OFF
*         CAS   SE  ; Merlin32 is case-sensitive by default and does not support this pseudo-opcode
         MX    %00

Debugger =     1

* Set build flags based on the world we're building for

         IF    1=World    ; Happy land
BF_SFXCode  =     1
BF_BlkComp  =     1          ; Assemble compiled blockset
BF_S_Flowr  =     1          ; Include these sprites:
BF_S_Turtl  =     1
BF_S_Chstr  =     1
BF_S_Snail  =     1
BF_Recordr  =     1          ; Include joystick path recorder
BF_Slopes   =     0          ; Include platform slopes
BF_VrtFunk  =     0          ; Vertical "funky" effect
BF_ScrlLft  =     0          ; Whether the screen can scroll left
BF_HeatWav  =     0
BF_DeRezz   =     1          ; Techno Land de-rez effect
BF_Buttons  =     0          ; Half-height connect-based-sprite buttons
BF_TVScrns  =     0          ; Techno Land tv screens (buttons required)
BF_SizLine  =     $F0        ; Length of one line on the PEA field
BF_SizCode  =     $00
         FIN

         IF    2=World      ; Unhappy land
BF_SFXCode  =     0
BF_BlkComp  =     0
BF_S_Flowr  =     0
BF_S_Turtl  =     0
BF_S_Chstr  =     1
BF_S_Snail  =     1
BF_Recordr  =     0
BF_Slopes   =     1
BF_VrtFunk  =     0
BF_ScrlLft  =     1
BF_HeatWav  =     0
BF_DeRezz   =     0
BF_Buttons  =     0
BF_TVScrns  =     0
BF_SizLine  =     $F0
BF_SizCode  =     $00
         FIN

         IF    3=World      ; Munchies land
BF_SFXCode  =     0
BF_BlkComp  =     1
BF_S_Flowr  =     0
BF_S_Turtl  =     0
BF_S_Chstr  =     1
BF_S_Snail  =     1
BF_Recordr  =     0
BF_Slopes   =     0
BF_VrtFunk  =     0
BF_ScrlLft  =     1
BF_HeatWav  =     0
BF_DeRezz   =     0
BF_Buttons  =     0
BF_TVScrns  =     0
BF_SizLine  =     $F0
BF_SizCode  =     $00
         FIN

         IF    4=World      ; Gothic land
BF_SFXCode  =     0
BF_BlkComp  =     0
BF_S_Flowr  =     0
BF_S_Turtl  =     0
BF_S_Chstr  =     1
BF_S_Snail  =     1
BF_Recordr  =     0
BF_Slopes   =     1
BF_VrtFunk  =     0
BF_ScrlLft  =     1
BF_HeatWav  =     0
BF_DeRezz   =     0
BF_Buttons  =     0
BF_TVScrns  =     0
BF_SizLine  =     $F0
BF_SizCode  =     $00
         FIN

         IF    5=World      ; Techno land
BF_SFXCode  =     0
BF_BlkComp  =     1
BF_S_Flowr  =     1
BF_S_Turtl  =     1
BF_S_Chstr  =     1
BF_S_Snail  =     1
BF_Recordr  =     0
BF_Slopes   =     0
BF_VrtFunk  =     0
BF_ScrlLft  =     1
BF_HeatWav  =     0
BF_DeRezz   =     1
BF_Buttons  =     1
BF_TVScrns  =     1
BF_SizLine  =     $F0
BF_SizCode  =     $00
         FIN

         IF    6=World      ; Acid land
BF_SFXCode  =     0
BF_BlkComp  =     1
BF_S_Flowr  =     1
BF_S_Turtl  =     1
BF_S_Chstr  =     1
BF_S_Snail  =     1
BF_Recordr  =     0
BF_Slopes   =     0
BF_VrtFunk  =     0
BF_ScrlLft  =     0
BF_HeatWav  =     1
BF_DeRezz   =     0
BF_Buttons  =     0
BF_TVScrns  =     0
BF_SizLine  =     $F0
BF_SizCode  =     $03
         FIN

         IF    7=World      ; Aliens land
BF_SFXCode  =     0
BF_BlkComp  =     1
BF_S_Flowr  =     1
BF_S_Turtl  =     1
BF_S_Chstr  =     1
BF_S_Snail  =     1
BF_Recordr  =     0
BF_Slopes   =     0
BF_VrtFunk  =     0
BF_ScrlLft  =     0
BF_HeatWav  =     0
BF_DeRezz   =     0
BF_Buttons  =     1
BF_TVScrns  =     0
BF_SizLine  =     $F0
BF_SizCode  =     $00
         FIN