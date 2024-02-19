         lst   on
* Sprite: Mushey v0.19
         lst   off

* 1- bits 1-4: 0=moving, 1-7=frozen
*    bit 8: backwards
* 2- mushroom type indicator
* 3- Vertical velocity
* 4- Map Y in blocks
* 5- Sub-Block Y 16th (from bottom)
* 6- Map X in blocks
* 7- Sub-Block X fifth (from left)

         MX    %10
Mushey   ldx   Tmp
         lda   #$78
         clc
         adc   SprI+2,x
         sta   DraW,y     ; Set up the picture
         lda   SprI+1,x
         and   #$0F
         beq   :NotFrozen    ; update freeze counter
         dec   SprI+1,x
         jmp   Mushey24
:NotFrozen rep   #$20
         lda   SprI+6,x
         and   #$00FF
         ASLS  2
         sta   Tmp2
         asl
         adc   Tmp2
         sta   Tmp2
         lda   SprI+4,x
         and   #$000F
         eor   #$000F
         sec
         sbc   #$0004     ; Same as subtracting it from $b
         clc
         adc   Tmp2
         sta   Tmp3       ; Map location in Tmp3
         sep   #$20
         lda   SprI+1,x
         and   #$f0
         bne   Mushey6    ; If heading back, go to other routine.
         lda   SprI+7,x   ; if slice = 0, check for obstacle
         beq   Mushey4
         inc
         cmp   #$05
         bne   :NotOnEdge
         inc   SprI+6,x
         rep   #$21
         lda   Tmp3
         adc   #$000C     ; Move the map pointer forward too
         sta   Tmp3
         sep   #$20
         lda   #$00
:NotOnEdge BRA   Mushey8
Mushey4  ldx   Tmp3
         lda   MapBl+$C,x
         ldx   Tmp
         cmp   #BlkId_PipeDown ; Horiz obst check 1
         bcc   Mushey5    ; Clear if before
         lda   #$80       ; Reverse direction
         sta   SprI+1,x
         lda   #$00
         bra   Mushey8
Mushey5  lda   #$01
         bra   Mushey8
Mushey6  lda   SprI+7,x
         dec
         bpl   Mushey8
         ldx   Tmp3
         lda   MapBl-$C,x
         ldx   Tmp
         cmp   #BlkId_PipeDown ; horiz. check 2
         bcc   Mushey7
         lda   #$00
         sta   SprI+1,x
         bra   Mushey8
Mushey7  dec   SprI+6,x
         rep   #$20
         lda   Tmp3
         sec
         sbc   #$000C     ; Move the map pointer back
         sta   Tmp3
         sep   #$20
         lda   #$04
Mushey8  sta   SprI+7,x   ; underside check:
         inc   SprI+3,x
         lda   SprI+5,x
         bne   Mushey10   ; if the vertical slice isn't 0, he falls
         ldx   Tmp3       ; if it IS 0, we check for the block under
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #BlkId_Pltfm
         bcs   Mushey9    ; If it's not solid, don't reset the Vv
         lda   SprI+7,x   ; If mushey is not on a
         beq   Mushey10   ; single block, check the block "in front"
         ldx   Tmp3
         lda   MapBl+$D,x
         ldx   Tmp
         cmp   #BlkId_Pltfm
         Bcc   Mushey10
Mushey9  lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
Mushey11 jmp   Mushey16
Mushey10 lda   SprI+3,x   ; Next we need to update it to the location.
         cmp   #$80       ; If the speed is neutral,
         beq   Mushey11   ; don't bother to update
         eor   #$80
         cmp   #$80
         bcc   Mushey12   ; If it's rising, do a flat addition.
         eor   #$FF
         clc
         adc   SprI+5,x
         sta   Tmp2
         and   #$0F
         sta   SprI+5,x   ; number of sections up
         lda   Tmp2
         lsr
         lsr
         lsr
         lsr
         clc
         adc   SprI+4,x   ; number of blocks up
         sta   SprI+4,x
         bra   Mushey16
Mushey12 dec
         sta   Tmp2       ; If falling, do slow increment w/checking
         dec   SprI+5,x
         bpl   Mushey15
         ldx   Tmp3
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #BlkId_Pltfm
         bcs   Mushey13   ; If it's not solid, don't reset the Vv
         lda   SprI+7,x
         cmp   #$00       ; If not on a
         beq   Mushey14   ; single block, check the block "in front"
         ldx   Tmp3
         lda   MapBl+$D,x
         ldx   Tmp
         cmp   #BlkId_Pltfm
         Bcc   Mushey14
Mushey13 lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
         stz   SprI+5,x
         bra   Mushey16
Mushey14 lda   #$0F
         sta   SprI+5,x
         dec   SprI+4,x
         lda   SprI+4,x
         cmp   #$F0       ; If he falls off,
         bcc   Mushey15   ; He's gone!
         jmp   KillDis
Mushey15 lda   Tmp2
         bne   Mushey12
Mushey16 lda   SprI+6,x
         inc
         cmp   GPositionXBlk
         bcc   Mushey24   ; Too far before the freak
         dec
         dec
         dec
         cmp   GPositionXBlk
         bcs   Mushey24   ; Too far after the bozo
         lda   SprI+6,x
         cmp   GPositionXBlk
         beq   Mushey18   ; If on the same block, contact.
         bcs   Mushey17   ; If before Guidoguy, check section
         lda   SprI+7,x   ; Same if after
         dec
         cmp   GPositionXFifth
         bcs   Mushey18   ; Not within boundary? No grab.
         bra   Mushey24
Mushey17 lda   SprI+7,x
         cmp   GPositionXFifth
         bcs   Mushey24
Mushey18 lda   GPositionYBlk
         inc
         inc
         cmp   SprI+4,x
         bcc   Mushey24   ; V check above
         lda   SprI+4,x
         inc
         cmp   GPositionYBlk ; V check below
         bcc   Mushey24
         lda   SprI+4,x   ; Both on same block?
         cmp   GPositionYBlk
         beq   Mushey23   ; Then the mushroom is definitely in reach
         inc
         cmp   GPositionYBlk ; Is shroom one below?
         bne   Mushey22
         lda   SprI+5,x
         cmp   GPositionYSlice ; Either it's nabbed, or no contact.
         bcc   Mushey24
Mushey23 rep   #$20
         lda   SprI+2,x   ; Yipee! Guido gets a mushroom!
         and   #$000F
         phy
         phx
         asl
         tax
         jsr   (Mushey69,x)
         sep   #$20
         lda   #$05       ; Award 500 points
         sta   Score2+2
         jsr   ScoreAdd
         rep   #$10
         plx
         ply
         jmp   KillDis    ; Kill the mushroom
Mushey22 lda   GPositionYBlk
         inc              ; Avoid 0 wrap!
         inc
         cmp   SprI+4,x   ; Is Guido 2 below?
         bne   Mushey23
         lda   SprI+5,x
         cmp   GPositionYSlice ; Then it's a contest check
         bcc   Mushey23
Mushey24 rep   #$20
         lda   SprI+7,x
         and   #$00FF
         sta   Tmp
         lda   SprI+6,x
         and   #$00FF
         sta   Tmp2
         ASLS  2
         adc   Tmp2
         adc   Tmp        ; Slice in map now in A
         sta   Tmp
         cmp   WinXEdgeTotalFifths
         bcs   Mushey25   ; Not on screen, but still in area
         lda   WinXEdgeTotalFifths ; Also left behind- kill!
         sec
         sbc   Tmp        ; In a city where crooks are all roamin',
         cmp   #$004d     ; Got a dirty old rental I made my home in,
         bcc   :Br1       ; And I once had a dog, but he went out
         cmp   #$0068     ; on the highway and got his head bashed in, aww man
         bcc   Mushey25   ;
         jmp   KillDis    ; I got a case of beer to booze on,
:Br1     sta   Tmp3       ; Got a wife --who's a flooze,
         lda   SprI+4,x   ; I got ten trillion channels of reruns,
         and   #$000F     ; on cable to choose from.
         ASLS  4          ;
         sta   Tmp2       ; Man, I'm afraid of heights...
         lda   SprI+5,x   ; And me and my neighbor's cat, we got in a fight.
         and   #$000F     ; And I got a broken light, needs replacin',
         clc              ; Really sucks... went right out, aww maan...
         adc   Tmp2       ;
         dec              ; And I have to go,
         dec              ; To the store to get one new,
         sta   Tmp2       ; But man, when I wanna telephone you,
         ASLS  2          ; Well...  I always get that damn answering machine!
         clc              ;
         adc   Tmp2       ; <click> "hello?"
         ASLS  4          ; "Uh, yeah, I'd like to speak to-"
         clc              ; "HAH! Fooled you!  I don't beleive ya fell for
         adc   Tmp3       ;  that! Like I ever even want to hear from YOU!"
         inc              ; <click>
         sta   DraW+1,y   ; "Awww, maaaan...
         inc   ErAc       ;
Mushey25 sep   #$20       ; -Garote & Andy's dubbed version of
         rts              ;  Pink Floyd's "Nobody Home"

Mushey69 DA    Mushey70,Mushey71,Mushey72,Mushey73,Mushey74

         MX    %00
Mushey70 ldal  WldCndtn+ShelPage ; Guido life
         cmp   #$0003
         beq   AlrdyFul
         inc
         stal  WldCndtn+ShelPage
         ASLS  2
         tax
         LDA   #$F00F
         stal  $012140+129,x
         stal  $0121e0+129,x
         stal  $012280+129,x
AlrdyFul rts
Mushey71 lda   #41        ; Horns
         sta   Ahed
         rts
Mushey72 lda   #44        ; Beanie
         sta   Ahed
         rts
Mushey73 lda   #43        ; Shades
         sta   Aeye
         rts
Mushey74 jmp   LivesInc   ; Extra life
