         lst   on
* Activator 8: FlagPole v0.08
         lst   off

         MX    %00
FlagTop  =     *
FlagPole lda   ExStats
         and   #$0040
         beq   :Br1
         rts
:Br1     ldal  PeaJumpPtr ; Push vital values
         pha
         lda   SizTotal
         pha
         lda   SizStack
         pha
         jsr   DoorCompute
         lda   #27
         sta   Artm       ; "Carry" arm for grabbing flag
         txa
         clc
         adc   #BF_SizLine
         sta   WindowedPEA ; Window's PEA field
         clc
         adc   #$000f
         sta   WindowedGuido ; DraTrol's PEA field
         sty   SizStack   ; Screen location
         lda   Mvb
         dec
         dec
         and   #$000F
         ASLS  4
         adc   Mhs
         lsr
         inc              ; Just in case we have a zero-high flag slide
         sta   Lupe
]lp2     jsr   WaitSync
         jsr   WindowedBlit
         ldx   WindowedPEA
         ldy   #$0021
]lp      ldal  BackFld+$F,x
         stal  ForeFld+$F,x
         ldal  BackFld+$11,x
         stal  ForeFld+$11,x
         ldal  BackFld+$13,x
         stal  ForeFld+$13,x ; Erase frame
         ldal  BackFld+$15,x
         stal  ForeFld+$15,x
         txa
         clc
         adc   #BF_SizLine
         tax
         dey
         bne   ]lp
         ldal  BackFld+$F,x ; Erase return jump
         stal  ForeFld+$F,x
         ldal  BackFld+$11,x
         stal  ForeFld+$11,x
         lda   WindowedPEA
         sec
         sbc   #BF_SizLine   ; Guido position
         sec
         sbc   #BF_SizLine
         sta   WindowedPEA
         clc
         adc   #$000f
         sta   WindowedGuido       ; DraTrol's PEA field
         lda   SizStack   ; Screen position
         clc
         adc   #$0140
         sta   SizStack
         dec   Lupe
         bne   ]lp2
         lda   #$0080
         sta   Mvv
         sta   Mhv        ; Set Guido's position to bottom of flag,
         lda   #$0002     ; no velocities.
         sta   Mvb
         stz   Xaxs
         stz   Yaxs
         stz   Mvs
         stz   WindowedPEA
         stz   WindowedGuido

                          ; lda SpAc
                          ; ASLS 3 ; x8
                          ; adc SpAc ; x9
                          ; tax ; in X
                          ; lda #IDPlayer
                          ; sta SprI,x ; Sets playback ID
                          ; lda #$0000
                          ; sta SprI+1,x ; Resets index
                          ; lda #$0169
                          ; sta SprI+5,x ; Sets "first cycle" flag
                          ; inc SpAc ; and index to "end of level 1"
                          ; sep #$20
         lda   #$40       ; Set autopilot indicator flag (was $C0)
         tsb   ExStats    ; And the "ignore flagpole" flag
                          ; lda #$FF
                          ; sta SprI+8,x ; M: Sets non-level I.D.

         rep   #$20
         pla
         sta   SizStack
         pla
         sta   SizTotal
         pla
         stal  PeaJumpPtr
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
         inc   ErAc
         rts
Flag1    jmp   KillDis
