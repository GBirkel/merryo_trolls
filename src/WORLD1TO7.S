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
]SFXcode  =     1
]DoBlComp =     1          ; Assemble compiled blockset
]Flower   =     1          ; Include these sprites:
]Turtle   =     1
]BChester =     1
]Snail    =     1
]GdRecord =     1          ; Include joystick path recorder
]Slope    =     0          ; Include platform slopes
]VertFunk =     0          ; Vertical "funky" effect
]ScrlLeft =     0          ; Whether the screen can scroll left
]HeatWave =     0
]DeRezz   =     1          ; Techno Land de-rez effect
]Buttons  =     0          ; Half-height connect-based-sprite buttons
]TVscrns  =     0          ; Techno Land tv screens (buttons required)
]SizLine  =     $F0        ; Length of one line on the PEA field
]CodeSiz  =     $00
         FIN

         IF    2=World      ; Unhappy land
]SFXcode  =     0
]DoBlComp =     0
]Flower   =     0
]Turtle   =     0
]BChester =     1
]Snail    =     1
]GdRecord =     0
]Slope    =     1
]VertFunk =     0
]ScrlLeft =     1
]HeatWave =     0
]DeRezz   =     0
]Buttons  =     0
]TVscrns  =     0
]SizLine  =     $F0
]CodeSiz  =     $00
         FIN

         IF    3=World      ; Munchies land
]SFXcode  =     0
]DoBlComp =     1
]Flower   =     0
]Turtle   =     0
]BChester =     1
]Snail    =     1
]GdRecord =     0
]Slope    =     0
]VertFunk =     0
]ScrlLeft =     1
]HeatWave =     0
]DeRezz   =     0
]Buttons  =     0
]TVscrns  =     0
]SizLine  =     $F0
]CodeSiz  =     $00
         FIN

         IF    4=World      ; Gothic land
]SFXcode  =     0
]DoBlComp =     0
]Flower   =     0
]Turtle   =     0
]BChester =     1
]Snail    =     1
]GdRecord =     0
]Slope    =     1
]VertFunk =     0
]ScrlLeft =     1
]HeatWave =     0
]DeRezz   =     0
]Buttons  =     0
]TVscrns  =     0
]SizLine  =     $F0
]CodeSiz  =     $00
         FIN

         IF    5=World      ; Techno land
]SFXcode  =     0
]DoBlComp =     1
]Flower   =     1
]Turtle   =     1
]BChester =     1
]Snail    =     1
]GdRecord =     0
]Slope    =     0
]VertFunk =     0
]ScrlLeft =     1
]HeatWave =     0
]DeRezz   =     1
]Buttons  =     1
]TVscrns  =     1
]SizLine  =     $F0
]CodeSiz  =     $00
         FIN

         IF    6=World      ; Acid land
]SFXcode  =     0
]DoBlComp =     1
]Flower   =     1
]Turtle   =     1
]BChester =     1
]Snail    =     1
]GdRecord =     0
]Slope    =     0
]VertFunk =     0
]ScrlLeft =     0
]HeatWave =     1
]DeRezz   =     0
]Buttons  =     0
]TVscrns  =     0
]SizLine  =     $F0
]CodeSiz  =     $03
         FIN

         IF    7=World      ; Aliens land
]SFXcode  =     0
]DoBlComp =     1
]Flower   =     1
]Turtle   =     1
]BChester =     1
]Snail    =     1
]GdRecord =     0
]Slope    =     0
]VertFunk =     0
]ScrlLeft =     0
]HeatWave =     0
]DeRezz   =     0
]Buttons  =     1
]TVscrns  =     0
]SizLine  =     $F0
]CodeSiz  =     $00
         FIN