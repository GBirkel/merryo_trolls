         lst   on
* Sprite: Turtle v0.08
         lst   off

TurtleSp ldx   Tmp        ; 1- bit 8=backwards, bit 4=red type
         lda   SprI+2,x   ; 2- animation stage
         inc              ; 3- VV
         cmp   #$04       ; 4- VB
         bne   Turtle6    ; 5- VS
         lda   #$00       ; 6- HB
Turtle6  sta   SprI+2,x   ; 7- HS
         rep   #$20
         lda   SprI+6,x
         and   #$00FF
         ASLS  2          ; x4
         sta   Tmp2
         asl              ; x8
         adc   Tmp2       ; x12
         sta   Tmp2
         lda   SprI+4,x
         and   #$000F
         eor   #$000F
         sec
         sbc   #$0004     ; Same as subtracting it from $b
         clc
         adc   Tmp2
         sta   Tmp3       ; Map loc in Tmp3
         stx   Tmp
         sep   #$20
         lda   SprI+1,x
         bmi   Turtle1    ; If heading back, go to other routine.
         lda   SprI+1,x
         and   #$08
         clc
         adc   SprI+2,x
         adc   #$1C
         sta   DraW+3,y   ; set up sprite
         lda   SprI+2,x
         and   #$02
         lsr
         adc   #$2e
         sta   DraW,y
         lda   SprI+2,x
         beq   TurtleT    ; update only if frame >not< 0
         lda   SprI+7,x   ; if slice = 1, check for obstacle
         cmp   #$01
         beq   TurtleA
         inc
         cmp   #$06
         bne   TurtleE
         inc   SprI+6,x
         rep   #$21
         lda   Tmp3
         adc   #$000C     ; Move the map pointer forward too
         sta   Tmp3
         sep   #$20
         lda   #$01
TurtleE  jmp   Turtle2
TurtleA  ldx   Tmp3
         lda   MapBl+$C,x
         ldx   Tmp
         cmp   #Gppd      ; Horiz obst check 1
         bcs   Turtle7    ; Clear if before
         lda   #$02
         bra   Turtle2
Turtle1  lda   SprI+1,x
         and   #$08
         clc
         adc   SprI+2,x
         adc   #$18       ; Sprite setup
         sta   DraW+3,y
         lda   SprI+2,x
         and   #$02
         lsr
         adc   #$2C
         sta   DraW,y
         lda   SprI+2,x
         beq   TurtleT    ; Update only if frame not 0
         lda   SprI+7,x
         dec
         bne   Turtle2
         ldx   Tmp3
         lda   MapBl-$C,x
         ldx   Tmp
         cmp   #Gppd      ; horiz. check 2
         bcc   Turtle8
Turtle7  lda   SprI+1,x
         eor   #$80
         sta   SprI+1,x
         lda   #$01
         bra   Turtle2
Turtle8  dec   SprI+6,x
         rep   #$20
         lda   Tmp3
         sec
         sbc   #$000C     ; Move the map pointer back
         sta   Tmp3
         sep   #$20
         lda   #$05
Turtle2  sta   SprI+7,x   ; underside check
TurtleT  inc   SprI+3,x
         lda   SprI+5,x
         bne   TurtleQ    ; if the vertical slice isn't 0, he falls
         ldx   Tmp3       ; if it IS 0, we check for the block under
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #Gplt
         bcc   :Br1       ; If it's not solid, don't reset the Vv
         lda   #$80
         sta   SprI+3,x
         jmp   Turtle4
:Br1     lda   SprI+7,x
         cmp   #$01       ; If the slime thang is not on a
         beq   TurtleQ    ; single block, check the block "in front"
         rep   #$21
         lda   Tmp3
         adc   #$000D
         tax
         sep   #$20
         lda   MapBl,x
         ldx   Tmp
         cmp   #Gplt
         Bcc   TurtleQ
         lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
TurtleL  jmp   Turtle4
TurtleQ  lda   SprI+3,x   ; Next we need to update it to the location.
         cmp   #$80       ; If the speed is neutral,
         beq   TurtleL    ; don't bother to update
         eor   #$80
         cmp   #$80
         bcc   TurtleU    ; If it's rising, do a flat addition.
         eor   #$FF
         clc
         adc   SprI+5,x
         sta   Tmp2
         and   #$0F
         sta   SprI+5,x   ; number of sections up
         lda   Tmp2
         LSRS  4
         clc
         adc   SprI+4,x   ; number of blocks up
         sta   SprI+4,x
         jmp   Turtle4
TurtleU  sta   Tmp2       ; If it's falling, do a slow increment.
         beq   TurtleL
TurtleX  dec   Tmp2       ; REM: Tmp = Sprite loc  Tmp3 = Map loc
         dec   SprI+5,x
         lda   SprI+5,x
         cmp   #$FF
         bne   TurtleW
         ldx   Tmp3
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #Gplt
         bcc   TurtleJ    ; If it's not solid, don't reset the Vv
         lda   #$80
         sta   SprI+3,x
         stz   SprI+5,x
         bra   Turtle4
TurtleJ  lda   SprI+7,x
         cmp   #$01       ; If the turtle is not on a
         beq   TurtleK    ; single block, check the block "in front"
         rep   #$21
         lda   Tmp3
         adc   #$000D
         tax
         sep   #$20
         lda   MapBl,x
         ldx   Tmp
         cmp   #Gplt
         Bcc   TurtleK
         lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
         stz   SprI+5,x
         bra   Turtle4
TurtleK  lda   #$0F
         sta   SprI+5,x
         dec   SprI+4,x
         lda   SprI+4,x
         cmp   #$F0       ; If he falls off,
         bcc   TurtleW    ; He's gone!
         jmp   KillDis
TurtleW  lda   Tmp2
         beq   Turtle4
         jmp   TurtleX
Turtle4  ldx   Tmp
         lda   SprI+6,x
         inc
         cmp   Mhb
         bcc   Turtle9    ; Too far before the freak
         dec
         dec
         dec
         cmp   Mhb
         bcs   Turtle9    ; Too far after the bozo
         lda   SprI+6,x
         cmp   Mhb
         beq   TurtleI    ; If on the same block, contact.
         bcs   TurtleH    ; If before marioguy, check section
         lda   SprI+7,x   ; Same if after (dec here)
         dec
         cmp   Mhs
         bcs   TurtleI    ; Not within boundary? No contact.
Turtle9  bra   Turtle5
TurtleH  lda   SprI+7,x
         cmp   Mhs
         bcs   Turtle5    ; ^^^ was a bcc
TurtleI  lda   Mvb
         inc
         inc
         cmp   SprI+4,x
         bcc   Turtle5    ; V check above
         lda   SprI+4,x
         inc
         cmp   Mvb        ; V check below
         bcc   Turtle5
         lda   SprI+4,x   ; Both on same block?
         cmp   Mvb
         beq   TurtleC    ; Then it's a contest.
         inc
         cmp   Mvb        ; Is slime one below?
         beq   TurtleS    ; Either he dies, or no contact.
         lda   Mvb
         inc              ; we must always increase, to avoid 0 wrap.
         inc
         cmp   SprI+4,x   ; Is Guido 2 below?
         beq   TurtleY    ; Either HE dies, or no contact.
]lp      rep   #$30       ; You see, by elimination, the turtle
         jsr   Verdict
         MX    %10
         cmp   #$69
         beq   Turtle5
         rep   #$30
         pla              ; must be right in Guidos face.
         pla              ; And there, at any slot difference,
         jmp   Die        ; he's always whacked.
         MX    %10
TurtleY  lda   SprI+5,x
         cmp   Mvs
         bcs   Turtle5    ; Two above check
         bra   ]lp
TurtleC  lda   SprI+5,x
         cmp   Mvs        ; Contest check
         bcc   TurtleD
         bra   ]lp
TurtleS  lda   SprI+5,x
         cmp   Mvs        ; One below check
         bcc   Turtle5
TurtleD  inc   SprI,x     ; Make I.D into empty shell
         rep   #$20
         lda   SprI+1,x
         and   #$0008
         LSRS  2
         ora   #$0001     ; Freeze shell, adapt type bit for "shell"
         sta   SprI+1,x   ; and reset animation.
         lda   #$0072
         sta   Mvv        ; Make Guido bounce up
         phy
         phx
         lda   #$0205     ; Award 25 points
         sta   Score2
         jsr   ScoreAdd
         rep   #$10
         plx
         ply
Turtle5  rep   #$20
         lda   SprI+7,x
         and   #$00FF
         dec
         sta   Tmp
         lda   SprI+6,x
         and   #$00FF
         sta   Tmp2
         ASLS  2
         adc   Tmp2
         adc   Tmp        ; Slice in map now in A
         sta   Tmp
         cmp   ClBk
         bcs   Turtle3    ; Not on screen
         lda   ClBk
         sec
         sbc   Tmp
         cmp   #$004d
         bcc   :Br1       ; On screen
         cmp   #$0068
         bcc   Turtle3    ; Not on screen, but still in area
         jmp   KillDis    ; Not on screen, and left behind area - Erase!
:Br1     sta   Tmp3
         lda   SprI+4,x   ; My name is Sydney
         and   #$000F     ; I'm an awesome hunk
         ASLS  4          ; I got a new snack
         sta   Tmp2       ; Ya don't just eat- ya dunk!
         lda   SprI+5,x
         and   #$000F     ; Cookies on one side-
         adc   Tmp2       ; Frosting on the other.
         dec              ; Creamy taste'll drive ya WIIILD
         dec              ; "LET'S HAVE ANOTHER!"
         sta   Tmp2
         ASLS  2          ; Dunk-a-rooz,
         adc   Tmp2       ; Dunk-a-rooz,
         ASLS  4          ; Ya don't just eat-
         adc   Tmp3       ; Ya dunk a rooz!
         inc
         sta   DraW+4,y
         clc
         adc   #$50*9
         sta   DraW+1,y
         inc   ErAc
         inc   ErAc
Turtle3  sep   #$20
         rts

         lst   on
* Sprite: Shell v0.06
         lst   off

         MX    %10
Shell    ldx   Tmp
         rep   #$20       ; 1- bit 8=backward, bit 2=red, bit 1=still
         lda   SprI+6,x   ; 2- shell anim. stage
         and   #$00FF     ; 3- VV
         ASLS  2          ; 4- VB
         sta   Tmp2       ; 5- VS
         asl              ; 6- HB
         adc   Tmp2       ; 7- HS
         sta   Tmp2
         lda   SprI+4,x
         and   #$F
         eor   #$F
         sec
         sbc   #$4        ; Same as subtracting it from $b
         clc
         adc   Tmp2
         sta   Tmp3       ; Map location in Tmp3
         sep   #$21
         lda   SprI+1,x
         and   #$02
         lsr
         ora   #$28
         sta   DraW,y     ; Set up the picture
         lda   SprI+1,x
         and   #$01
         beq   *+5        ; freeze flag
         jmp   Shell77
         lda   SprI+1,x
         bpl   ShellGam
         lda   SprI+2,x
         and   #$01       ; Option of choosing 2nd version if moving
         asl              ; backwards
         ora   DraW,y
         bra   ShellAck
ShellGam lda   SprI+2,x
         inc
         and   #$02       ; Option of choosing 2nd version if moving
         ora   DraW,y     ; forwards
ShellAck sta   DraW,y
         lda   SprI+2,x
         and   #$01
         inc
         sta   Tmp2
         lda   SprI+2,x   ; Increment anim. from 0 to 3
         inc
         cmp   #$04
         bne   *+4
         lda   #$00
         sta   SprI+2,x
Shell19  lda   SprI+1,x
         bmi   Shell6     ; If heading back, go to other routine.
         lda   SprI+7,x   ; if slice = 0, check for obstacle
         beq   :Br1
         inc
         cmp   #$05
         bne   Shell33
         inc   SprI+6,x
         rep   #$21
         lda   Tmp3
         adc   #$000C     ; Move the map pointer forward too
         sta   Tmp3
         sep   #$20
         lda   #$00
         bra   Shell8
:Br1     ldx   Tmp3
         lda   MapBl+$C,x
         ldx   Tmp
         cmp   #Gppd      ; Horiz obst check 1
         bcc   Shell5     ; Clear if before
         lda   SprI+1,x
         ora   #$80       ; Reverse direction
         sta   SprI+1,x
         lda   #$00
         bra   Shell8
Shell5   lda   #$01
         bra   Shell33
Shell6   lda   SprI+7,x
         dec
         bpl   Shell33
         ldx   Tmp3
         lda   MapBl-$C,x
         ldx   Tmp
         cmp   #Gppd      ; horiz. check 2
         bcc   Shell7
         lda   SprI+1,x
         and   #$7F
         sta   SprI+1,x
         lda   #$00
         bra   Shell8
Shell7   dec   SprI+6,x
         rep   #$20
         lda   Tmp3
         sec
         sbc   #$000C     ; Move the map pointer back
         sta   Tmp3
         sep   #$20
         lda   #$04
Shell33  sta   SprI+7,x   ; underside check:
         dec   Tmp2
         bne   Shell19
         bra   Shell77
Shell8   sta   SprI+7,x   ; If last contact was obstacle,
Shell77  inc   SprI+3,x   ; stop updating H no matter what it was.
         lda   SprI+5,x
         bne   Shell10    ; if the vertical slice isn't 0, he falls
         ldx   Tmp3       ; if it IS 0, we check for the block under
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #Gplt
         bcs   Shell9     ; If it's not solid, don't reset the Vv
         lda   SprI+7,x   ; If shell is not on a
         beq   Shell10    ; single block, check the block "in front"
         ldx   Tmp3
         lda   MapBl+$D,x
         ldx   Tmp
         cmp   #Gplt
         Bcc   Shell10
Shell9   lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
Shell11  jmp   Shell16
Shell10  lda   SprI+3,x   ; Next we need to update it to the location.
         cmp   #$80       ; If the speed is neutral,
         beq   Shell11    ; don't bother to update
         eor   #$80
         cmp   #$80
         bcc   Shell12    ; If it's rising, do a flat addition.
         eor   #$FF
         clc
         adc   SprI+5,x
         sta   Tmp2
         and   #$0F
         sta   SprI+5,x   ; number of sections up
         lda   Tmp2
         LSRS  4
         clc
         adc   SprI+4,x   ; number of blocks up
         sta   SprI+4,x
         bra   Shell16
Shell12  dec
         sta   Tmp2       ; If falling, do slow increment w/checking
         dec   SprI+5,x
         bpl   Shell15
         ldx   Tmp3
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #Gplt
         bcs   Shell13    ; If it's not solid, don't reset the Vv
         lda   SprI+7,x
         cmp   #$00       ; If not on a
         beq   Shell14    ; single block, check the block "in front"
         ldx   Tmp3
         lda   MapBl+$D,x
         ldx   Tmp
         cmp   #Gplt
         Bcc   Shell14
Shell13  lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
         stz   SprI+5,x
         bra   Shell16
Shell14  lda   #$0F
         sta   SprI+5,x
         dec   SprI+4,x
         lda   SprI+4,x
         cmp   #$F0       ; If he falls off,
         bcc   Shell15    ; He's gone!
         jmp   KillDis
Shell15  lda   Tmp2
         bne   Shell12
Shell16  lda   SprI+6,x
         inc
         cmp   Mhb
         bcc   Shell69    ; Too far before the freak
         dec
         dec              ; was one more dec
         cmp   Mhb
         bcs   Shell69    ; Too far after the bozo
         lda   SprI+6,x
         cmp   Mhb
         beq   Shell18    ; If on the same block, contact.
         bcs   Shell17    ; If before marioguy, check section
         lda   Mhs
         cmp   SprI+7,x   ; Same if after
         bcc   Shell18    ; Not within boundary? No hit.
Shell69  bra   Shell24
Shell17  lda   SprI+7,x
         cmp   Mhs
         bcs   Shell24
Shell18  lda   Mvb
         inc
         inc
         cmp   SprI+4,x
         bcc   Shell24    ; V check above
         lda   SprI+4,x
         inc
         cmp   Mvb        ; V check below
         bcc   Shell24
         lda   SprI+4,x   ; Both on same block?
         cmp   Mvb
         beq   Shell26    ; Then it's a contest.
         inc
         cmp   Mvb        ; One below?
         beq   Shell22    ; Either he's nabbed, or no contact.
         lda   Mvb
         inc              ; Avoid 0 wrap!
         inc
         cmp   SprI+4,x   ; Is Guido 2 below?
         beq   Shell21    ; Either HE dies, or no contact.
]lp      lda   SprI+1,x   ; Now by elimination, it's in his face.
         and   #$01
         beq   Shell27    ; If it's moving, Guido gets hit.
         rep   #$20
         lda   Mdir
         XBA
         lsr
         and   #$0080     ; Otherwise, make it move, in his direction.
         ora   SprI+1,x
         sta   SprI+1,x
         bra   Shell24
Shell27  rep   #$30
         jsr   Verdict
         MX    %10
         cmp   #$69
         beq   Shell24
         rep   #$30
         pla              ; is right in Guidos face.
         pla              ; And there, at any slot difference,
         jmp   Die        ; he's always smacked
         MX    %10
Shell21  lda   SprI+5,x
         cmp   Mvs
         bcs   Shell24    ; Two above check
         bra   ]lp
Shell26  lda   SprI+5,x
         cmp   Mvs        ; Contest check
         bcc   Shell23
         bra   ]lp
Shell22  lda   SprI+5,x
         cmp   Mvs        ; One below check
         bcc   Shell24
Shell23  lda   SprI+1,x
         eor   #$01
         sta   SprI+1,x   ; Invert movement bit
         lda   #$72
         sta   Mvv        ; Make Guido bounce up
Shell24  rep   #$20
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
         cmp   ClBk
         bcs   Shell25    ; Not on screen
         lda   ClBk
         sec
         sbc   Tmp
         cmp   #$004d
         bcc   :Br1       ; On screen
         cmp   #$0068
         bcc   Shell25    ; Not on screen, but still in area
         jmp   KillDis    ; Also left behind- kill!
:Br1     sta   Tmp3
         lda   SprI+4,x
         and   #$000F
         ASLS  4
         sta   Tmp2
         lda   SprI+5,x
         and   #$000F
         adc   Tmp2
         dec
         dec
         sta   Tmp2
         ASLS  2
         adc   Tmp2
         ASLS  4
         adc   Tmp3
         inc
         sta   DraW+1,y
         inc   ErAc
Shell25  sep   #$20
         rts
