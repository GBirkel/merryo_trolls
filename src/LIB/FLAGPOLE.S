         lst   on
* Activator 8: FlagPole v0.08
         lst   off

         MX    %00
FlagTop  =     *
FlagPole lda   GameFlags    ; Skip all this if the "don't respond to the flagpole" flag is set
         and   #$0040
         beq   :Br1
         rts
:Br1     lda   PEAInitialStackPtr
         pha
         ldal  PeaJumpPtr ; Save vital values
         pha
         lda   SizTotal
         pha
         lda   #GuidoSprId_ArmCarry
         sta   GCurrentSpr_RArm       ; "Carry" arm for grabbing flag
* This code here aims to erase any lingering scrap of Guido on the screen
* from rendering the previous frame, when he was in his previous position
         ldx   #$0020   ; Two blocks up from the bottom of the screen, in slices.
         ldy   GPositionXScreenFifth
         dey
         jsr   ComputeBlitLocations
         stx   WindowedPEA
         sty   PEAInitialStackPtr   ; Our blit will be 3 PEAs wide to cover
         ldx   #$0009               ; the case of Guido jumping and moving at a run,
         ldy   #$009C               ; and tall enough to erase a region
         jsr   DrawWindowedPeaFrameAndBlit ; as tall as the flagpole.
         ldx   #$0009
         ldy   #$009C
         jsr   RemoveWindowedPeaFrame
* Now compute Guido's PEA and screen location the usual way and prepare to
* draw him in a frame.
         jsr   DoorCompute
         txa
         sta   WindowedGuido        ; Corner PEA instruction to draw Guido into
         sec
         sbc   #$000f
         sta   WindowedPEA          ; Window's PEA field
         tya
         clc
         adc   #$000a
         sta   PEAInitialStackPtr   ; Screen location
         lda   GPositionYBlk
         dec
         dec
         and   #$000F
         ASLS  4
         adc   GPositionYSlice
         lsr
         inc              ; Just in case we have a zero-high flag slide
         sta   Lupe
]lp2     jsr   WaitSync
         jsr   DrawWindowedGuidoAndBlit
         lda   WindowedPEA
         sec
         sbc   #BF_SizLine*2       ; Moving Guido and the window two scanlines at a time
         sta   WindowedPEA
         clc
         adc   #$000f
         sta   WindowedGuido       ; DraTrol's PEA field
         lda   PEAInitialStackPtr  ; Screen position
         clc
         adc   #$0140              ; Two scanlines down on the screen
         sta   PEAInitialStackPtr
         dec   Lupe
         bne   ]lp2
         lda   #$0080
         sta   GVelocityY
         sta   JoystkHLev
         sta   GVelocityX ; Set Guido's position to bottom of flag, which is always 2 blocks up,
         lda   #$0002     ; and zero velocity.
         sta   GPositionYBlk
         stz   GXVectorRemaining
         stz   GYVectorRemaining
         stz   GPositionYSlice
         stz   WindowedPEA
         stz   WindowedGuido

                          ; lda SpritesActiveCnt
                          ; ASLS 3 ; x8
                          ; adc SpritesActiveCnt ; x9
                          ; tax ; in X
                          ; lda #IDPlayer
                          ; sta SprI,x ; Sets playback ID
                          ; lda #$0000
                          ; sta SprI+1,x ; Resets index
                          ; lda #$0169
                          ; sta SprI+5,x ; Sets "first cycle" flag
                          ; inc SpritesActiveCnt ; and index to "end of level 1"
                          ; sep #$20
         lda   #$40       ; Set autopilot indicator flag (was $C0)
         tsb   GameFlags  ; And the "ignore flagpole" flag
                          ; lda #$FF
                          ; sta SprI+8,x ; M: Sets non-level I.D.

         rep   #$20
         pla
         sta   SizTotal
         pla
         stal  PeaJumpPtr ; Save vital values
         pla
         sta   PEAInitialStackPtr
         RTS


         lst   on
* Sprite: Flag v0.02
         lst   off

* 1- Caught flag (nonzero=caught)
* 4,5- H strip
* 6- V strip (bottom=1)

Flag     sep   #$20       ; actual entry point
         ldx   Tmp
         lda   SprI+1,x
         bne   Flag1
         rep   #$20
         lda   SprI+4,x
         cmp   WinXEdgeTotalFifths
         bcs   Flag1      ; Not on screen
         lda   WinXEdgeTotalFifths
         sec
         sbc   SprI+4,x
         cmp   #$004E
         bcs   Flag1      ; Not on screen
         sta   Tmp2
         lda   SprI+6,x   ; 
         and   #$00ff     ;
         sta   Tmp        ; 
         ASLS  2          ; 
         adc   Tmp        ; Vert.strip x 5
         ASLS  2          ; x 80
         adc   Tmp2       ; plus horizontal offset
         sta   DraW+1,y
         sep   #$20
         lda   #$7F       ; flag sprite
         sta   DraW,y
         inc   SpritesOnScreenCnt
         rts
Flag1    jmp   KillDis
