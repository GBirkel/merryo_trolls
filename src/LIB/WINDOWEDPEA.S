         lst   on
* Windowed PEA routines v0.2
         lst   off


* y: Horizontal location in block fifths (4 pixel intervals)
* x: Vertical location in lines from the bottom of the screen
* Using these, return their corresponding memory locations for:
* x: the location in the PEA field
* y: the location in screen memory
         MX    %00
ComputeBlitLocations = *
         sty   Tmp
         txa
         sta   Tmp2
         and   #$000F
         jsr   MultiplyNybbleBySizLine
         sta   Tmp3
         lda   Tmp2
         and   #$00F0
         LSRS  4
         jsr   MultiplyNybbleBySizLine
         ASLS  4
         clc
         adc   Tmp3
         clc
* Move ahead one full PEA line minus the bumper code (if any)
* since the bottom left edge of the screen is actually one full PEA line into
* the field.  We subtract the horizontal offset to come back the other way.
         adc   #BF_SizLine-BF_SizCode-3
         sec
         sbc   Tmp
         sec
         sbc   Tmp
         sec
         sbc   Tmp ; Subtracted x3 to count each fifth as a 'PEA #xxxx'.
         clc
         adcl  PeaJumpPtr
         tax
* Since we're calculating from the bottom of the screen, we want to subtract
* the vertical location from the beginning of the last scanline in memory
* (160 bytes x 191 = 0x7760).
* Since we need to multiply the vertical location by A0 as well, we'll
* combine those operations.
         lda   Tmp2
         ASLS  4            ; Multiply by the 0x10 part of 0xA0.
         eor   #$0FFF       ; Inverting all these bits is just like subtracting
         sec                ; the value from 0xFFF.
         sbc   #$040F       ; Subtract the difference between 0xFFF and 0xBF0.
         sta   Tmp3
         ASLS  2
         adc   Tmp3         ; Multiply by 5, for 0x50.  Almost there.
         clc                
         adc   Tmp          ; Add horizontal block fifth offset.
         asl                ; Bring vertical multiplier to 0xA0 and horizontal to 2.
         adc   #SHR+1       ; Add in the SHR screen location, plus one byte because we're
         tay                ; referencing a location that will be used as a stack pointer,
         rts                ; and a PEA will push two bytes, so we start at the high byte.


* Calculate a location in the screen memory (and place in y)
* Calculate a location in the PEA field (and place in x)
* These locations correspond to a corner of where Guido is standing,
* and can be used to perform animations in a contained space,
* e.g. moving Guido vertically down in the space until he's outside
* it, which will naturally clip Guido off at the edge of the
* space, so it appears he's going down a pipe that's already present
* on the screen below the space.
DoorCompute = *
         REP   #$30
         lda   GPositionYBlk
         ASLS  4
         clc
         adc   GPositionYSlice
         dec            ; Guido is always drawn one line down from his actual
         tax            ; map location, so he overlaps the ground.
         ldy   GPositionXScreenFifth
         jsr   ComputeBlitLocations
         txa
         clc
         adc   #$0006   ; Add one PEA
         tax            ; This is done because Guido is always drawn four pixels
         tya            ; left of his actual sprite edge, so he overlaps
         sec            ; the block on his left slightly.
         sbc   #$0004
         tay
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
         sta   TableRef+2
         sta   TableRefB+2
         ldx   #GuidoSpriteJumpTable
         lda   GBodyFlg_Facing
         and   #$01
         beq   :Br1
         ldx   #GuidoSpriteJumpTable+$C0
:Br1     txa
         sta   TableRef+1
         inc
         sta   TableRefB+1
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
