         lst   on
* Windowed PEA routines v0.2
         lst   off


* Calculate a location in the screen memory (and place in y)
* Calculate a location in the PEA field (and place in x)
* These locations correspond to a corner of where Guido is standing,
* and can be used to perform animations in a contained space,
* e.g. moving Guido vertically down in the space until he's outside
* it, which will naturally clip Guido off at the edge of the
* space, so it appears he's going down a pipe that's already present
* on the screen below the space.
* Note that these calculations currently depend on a fixed PEA scanline length of $F0.
* Calculations for other lengths will have to be substituted in.
DoorCompute = *
         REP   #$30
         lda   GPositionYBlk
         and   #$000F           ; Just in case
         jsr   MultiplyNybbleBySizLine
         ASLS  4
         sta   Tmp2
         lda   GPositionYSlice
         jsr   MultiplyNybbleBySizLine
         clc
         adc   Tmp2
         sta   Tmp2
         ldal  PeaJumpPtr
         sec
         sbc   GPositionXScreenFifth
         sec
         sbc   GPositionXScreenFifth
         sec
         sbc   GPositionXScreenFifth ; Subtracted x3 to count each fifth as a 'PEA #xxxx'.
         clc
         adc   Tmp2
         sec
         sbc   #$000c     ; Subtract 13 bytes- that is, 4 PEAs
         tax              ; (including left edge overlap for Guido)
         lda   GPositionYBlk ; Vertical block comp. with reversal
         Xba
         and   #$0F00
         sta   Tmp2
         lda   GPositionYSlice
         ASLS  4
         adc   Tmp2
         eor   #$0FFF     ; just like subtracting it from $BF0
         sec
         sbc   #$040F
         sta   Tmp3
         ASLS  2
         adc   Tmp3
         clc              ; xA, plus screen offset x2
         adc   GPositionXScreenFifth
         asl
         adc   #SHR+$A7   ; MOD 3 less than location for left-overlap
         tay              ; =SHR screen location
         rts


         MX    %00
* Draw a 7-byte-long set of "windowed PEA" instructions,
* forming a column in the PEA field that does a subtraction on the
* stack pointer and branches ahead, so only a rectangular portion of
* the field is drawn to the screen.
* x: Number of PEAs wide the window needs to be (premultiplied, in bytes)
* y: Number of scanlines high the window needs to be.
DrawWindowedPeaFrameAndBlit = *
         txa
         sta   Tmp
         xba
         sta   Tmp2
* Relative branch amount.
* Size of a PEA line, minus X in PEA instructions
* and 7 bytes for "SBC xxxx, TCS, BRL xxxx" (total $16)
         lda   #BF_SizLine-$7*$100+$82
         sec
         sbc   Tmp2
         sta   Tmp2
         lda   WindowedPEA
         stal  PeaJumpPtr
         clc
         adc   Tmp
         tax
* The $F in "ForegPeaField+$F,x" and "#$000F" below is the width of 5 PEA instructions,
* Which currently fixes the width of this "window" to 20 pixels.
]lp      lda   #$a0e9       ; Replace PEA instructions
         stal  ForegPeaField,x ; with some stack pointer math (SBC #$00A0, TCS)
         lda   #$1b00       ; and a BRL to the next line
         stal  ForegPeaField+$2,x
         lda   Tmp2
         stal  ForegPeaField+$4,x ; Establish frame
         lda   #$0000
         stal  ForegPeaField+$6,x
         txa
         clc
         adc   #BF_SizLine
         tax
         dey
         bne   ]lp
         sec
         sbcl  PeaJumpPtr
         sta   SizTotal
         jmp   PeaBlit    ; Blit frame


         MX    %00
* Erase the 7-byte-long set of "windowed PEA" instructions,
* using the background PEA field as a reference.
* x: Number of PEAs wide the window was
* y: Number of scanlines high the window was.
*    (This needs to be accurate since we need to erase the
*     return jump on the tail end of the window as well.) 
RemoveWindowedPeaFrame = *
         txa
         clc
         adc   WindowedPEA
         tax
]lp      ldal  BackgPeaField,x
         stal  ForegPeaField,x
         ldal  BackgPeaField+$2,x
         stal  ForegPeaField+$2,x
         ldal  BackgPeaField+$4,x
         stal  ForegPeaField+$4,x ; Erase frame
         ldal  BackgPeaField+$6,x
         stal  ForegPeaField+$6,x
         txa
         clc
         adc   #BF_SizLine
         tax
         dey
         bne   ]lp
         ldal  BackgPeaField,x ; Erase return jump
         stal  ForegPeaField,x
         ldal  BackgPeaField+$2,x
         stal  ForegPeaField+$2,x
         rts


         MX    %11
DrawOrEraseGuido = *
         sta   DaSpot+2
         sta   DaSpotB+2
         ldx   #GuidoSpriteJumpTable
         lda   GBodyFlg_Facing
         and   #$01
         beq   :Br1
         ldx   #GuidoSpriteJumpTable+$C0
:Br1     txa
         sta   DaSpot+1
         inc
         sta   DaSpotB+1
         rep   #$30
         lda   WindowedGuido
         inc
         jmp   DrawGuidoHere


DrawWindowedGuidoAndBlit = *
         sep   #$30
         lda   #>GuidoSpriteJumpTable
         jsr   DrawOrEraseGuido
* We draw Guido before constructing the frame,
* so there's no risk of corrupting the frame code with the draw.
         rep   #$30
         ldx   #$000f
         ldy   #$0021
         jsr   DrawWindowedPeaFrameAndBlit
         sep   #$30
         lda   #>GuidoEraserJumpTable ; Erase him
         jsr   DrawOrEraseGuido
         rep   #$30
         ldx   #$000f
         ldy   #$0021
         jsr   RemoveWindowedPeaFrame
         rts


* Brute-force way to multiply any 4-bit value by the
* size of a scanline in the PEA field.
MultiplyNybbleBySizLine = *
         asl
         tax
         lda :Muls,x
         rts
:Muls    DW 0
         DW BF_SizLine
         DW BF_SizLine*2
         DW BF_SizLine*3
         DW BF_SizLine*4
         DW BF_SizLine*5
         DW BF_SizLine*6
         DW BF_SizLine*7
         DW BF_SizLine*8
         DW BF_SizLine*9
         DW BF_SizLine*10
         DW BF_SizLine*11
         DW BF_SizLine*12
         DW BF_SizLine*13
         DW BF_SizLine*14
         DW BF_SizLine*15
