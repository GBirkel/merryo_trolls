         lst   on
* Sprite: SlimBal v0.1A
         lst   off

SlimBal  ldx   Tmp
         lda   SprI+2,x
         inc
         cmp   #$03       ; 1- bit 8=backwards, bits 1-2:
         bne   :Br1       ;    0=active, 1=bug-eye, 2=flat
         lda   #$00       ; 2- animation stage (1-3)
:Br1     sta   SprI+2,x   ; 3- VV
         rep   #$20       ; 4- VB
         lda   SprI+6,x   ; 5- VS (1-16)
         and   #$00FF     ; 6- HB
         ASLS  2          ; 7- HS (1-5)
         sta   Tmp2
         asl              ; map location in Tmp3
         adc   Tmp2
         sta   Tmp2
         lda   SprI+4,x
         and   #$000F
         eor   #$000F
         sec
         sbc   #$0004     ; Same as subtracting it from $b
         clc
         adc   Tmp2
         sta   Tmp3
         stx   Tmp
         sep   #$20
         lda   SprI+1,x
         and   #$0F
         beq   SlimBalO   ; Squished check
         cmp   #$01       ; flat check
         beq   SlimBalH
         lda   SprI+1,x
         asl
         lda   #$0A       ; and add
         rol
         sta   DraW,y
         lda   SprI+2,x
         cmp   #$20
         bne   SlimBalV
         jmp   KillDis
SlimBalH lda   SprI+1,x
         asl
         lda   #$09       ; Get high bit of 1 in carry, & add
         rol              ; Values
         sta   DraW,y
         lda   SprI+2,x
         cmp   #$20       ; Bug eye time
         bne   SlimBalV
         lda   #$08
         sta   SprI+2,x
         inc   SprI+1,x
SlimBalV jmp   SlimBalT
SlimBalO lda   SprI+1,x
         and   #$f0
         bne   SlimBal1   ; If heading back, go to other routine.
         lda   SprI+2,x
         clc
         adc   #$0F
         sta   DraW,y     ; set up sprite
         lda   SprI+2,x
         bne   SlimBalV   ; update only if frame = 0
         lda   SprI+7,x   ; if slice = 1, check for obstacle
         cmp   #$01
         beq   SlimBalA
         inc
         cmp   #$06
         bne   :Br1
         inc   SprI+6,x
         rep   #$21
         lda   Tmp3
         adc   #$000C     ; Move the map pointer forward too
         sta   Tmp3
         sep   #$20
         lda   #$01
:Br1     jmp   SlimBal2
SlimBalA ldx   Tmp3
         lda   MapBl+$C,x
         ldx   Tmp
         cmp   #Gppd      ; Horiz obst check 1
         bcs   SlimBal7   ; Clear if before
         lda   #$02
         bra   SlimBal2
SlimBal1 lda   SprI+2,x
         clc
         adc   #$0C       ; Sprite setup
         sta   DraW,y
         lda   SprI+2,x
         bne   SlimBalT   ; Update only if frame = 0
         lda   SprI+7,x
         dec
         bne   SlimBal2
         ldx   Tmp3
         lda   MapBl-$C,x
         ldx   Tmp
         cmp   #Gppd      ; horiz. check 2
         bcc   SlimBal8
SlimBal7 lda   SprI+1,x
         eor   #$80
         sta   SprI+1,x
         lda   #$01
         bra   SlimBal2
SlimBal8 dec   SprI+6,x
         rep   #$21
         lda   Tmp3
         sbc   #$000B     ; Move the map pointer back
         sta   Tmp3
         sep   #$20
         lda   #$05
SlimBal2 sta   SprI+7,x   ; underside check
SlimBalT inc   SprI+3,x
         lda   SprI+5,x
         bne   SlimBalQ   ; if the vertical slice isn't 0, he falls
         ldx   Tmp3       ; if it IS 0, we check for the block under
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #Gplt
         bcc   :Br1       ; If it's not solid, don't reset the Vv
         lda   #$80
         sta   SprI+3,x
         jmp   SlimBal4
:Br1     lda   SprI+7,x
         cmp   #$01       ; If the slime thang is not on a
         beq   SlimBalQ   ; single block, check the block "in front"
         rep   #$21
         lda   Tmp3
         adc   #$000D
         tax
         sep   #$20
         lda   MapBl,x
         ldx   Tmp
         cmp   #Gplt
         Bcc   SlimBalQ
         lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
         jmp   SlimBal4
SlimBalQ lda   SprI+3,x   ; Next we need to update it to the location.
         cmp   #$80       ; If the speed is neutral,
         bne   *+5        ; don't bother to update
         jmp   SlimBal4
         eor   #$80
         cmp   #$80
         bcc   :Br1       ; If it's rising, do a flat addition.
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
         jmp   SlimBal4
:Br1     sta   Tmp2       ; If it's falling, do a slow increment.
         bne   SlimBalX
         jmp   SlimBal4
SlimBalX dec   Tmp2       ; REM: Tmp = Sprite loc  Tmp3 = Map loc
         dec   SprI+5,x
         lda   SprI+5,x
         cmp   #$FF
         bne   SlimBalW
         ldx   Tmp3
         lda   MapBl+1,x
         ldx   Tmp
         cmp   #Gplt
         bcc   SlimBalJ   ; If it's not solid, don't reset the Vv
         lda   SprI+3,x
         cmp   #$90
         bcc   :Br1
         lda   SprI+1,x
         and   #$0F
         bne   :Br1       ; if he ain't already
         inc   SprI+1,x   ; Squish 'im
         lda   #$1E
         sta   SprI+2,x
:Br1     lda   #$80
         sta   SprI+3,x
         stz   SprI+5,x
         bra   SlimBal4
SlimBalJ lda   SprI+7,x
         cmp   #$01       ; If the slime thang is not on a
         beq   SlimBalK   ; single block, check the block "in front"
         rep   #$21
         lda   Tmp3
         adc   #$000D
         tax
         sep   #$20
         lda   MapBl,x
         ldx   Tmp
         cmp   #Gplt
         Bcc   SlimBalK
         lda   SprI+3,x
         cmp   #$90
         bcc   SlimBalM
         lda   SprI+1,x
         and   #$0F
         bne   SlimBalM
         inc   SprI+1,x
         lda   #$03
         sta   SprI+2,x
SlimBalM lda   #$80       ; Okay, now we've checked for a drop
         sta   SprI+3,x   ; and incremented the Vv.
         stz   SprI+5,x
         bra   SlimBal4
SlimBalK lda   #$0F
         sta   SprI+5,x
         dec   SprI+4,x
         lda   SprI+4,x
         cmp   #$F0       ; If he falls off,
         bcc   SlimBalW   ; He's gone!
         jmp   KillDis
SlimBalW lda   Tmp2
         beq   SlimBal4
         jmp   SlimBalX
SlimBal4 ldx   Tmp
         lda   SprI+1,x
         and   #$0F       ; If not in an active state,
         bne   :Br1       ; contact is irrelevant. Skip it.
         lda   SprI+6,x
         inc
         cmp   Mhb
         bcc   :Br1       ; Too far before the freak
         dec
         dec
         dec
         cmp   Mhb
         bcs   :Br1       ; Too far after the bozo
         lda   SprI+6,x
         cmp   Mhb
         beq   Fondle     ; If on the same block, contact.
         bcs   ZamFir     ; If before Guido, check section
         lda   SprI+7,x   ; Same if after (dec here)
         dec
         cmp   Mhs
         bcs   Fondle     ; Not within boundary? No squish.
:Br1     bra   SlimBal5
ZamFir   lda   SprI+7,x
         cmp   Mhs
         bcs   SlimBal5   ; ^^^ was a bcc
Fondle   lda   Mvb
         inc
         inc
         cmp   SprI+4,x
         bcc   SlimBal5   ; V check above
         lda   SprI+4,x
         inc
         cmp   Mvb        ; V check below
         bcc   SlimBal5
         lda   SprI+4,x   ; Both on same block?
         cmp   Mvb
         beq   SlimBalC   ; Then it's a contest.
         inc
         cmp   Mvb        ; Is slime one below?
         beq   SlimBalS   ; Either he dies, or no contact.
         lda   Mvb
         inc              ; we must always increase, to avoid 0 wrap.
         inc
         cmp   SprI+4,x   ; Is Guido 2 below?
         beq   SlimBalY   ; Either HE dies, or no contact.
]lp      jsr   Verdict
         MX    %10
         cmp   #$69
         beq   SlimBal5
         rep   #$30       ; By elimination the snail
         pla              ; must be right in Guidos face.
         pla              ; And there, at any slot difference,
         jmp   Die        ; he's always whacked.
         MX    %10
SlimBalY lda   SprI+5,x
         cmp   Mvs
         bcs   SlimBal5   ; Two above check
         bra   ]lp
SlimBalC lda   SprI+5,x
         cmp   Mvs        ; Contest check
         bcc   SlimBalD
         bra   ]lp
SlimBalS lda   SprI+5,x
         cmp   Mvs        ; One below check
         bcc   SlimBal5
SlimBalD inc   SprI+1,x
         lda   #$1E       ; Squish him mercilessly
         sta   SprI+2,x
         lda   #$75
         sta   Mvv        ; Make Guido bounce up
         phx              ; Never tried this before...
         phy
         rep   #$20
         lda   #$0205     ; Award 25 points
         sta   Score2
         jsr   ScoreAdd
         rep   #$10
         ply
         plx
SlimBal5 rep   #$21
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
         bcs   SlimBal3   ; Not on screen
         lda   ClBk
         sec
         sbc   Tmp
         cmp   #$004d
         bcc   :Br1       ; On screen
         cmp   #$0068
         bcc   SlimBal3   ; Not on screen, but still in area
         jmp   KillDis    ; Not on screen, and left behind area - Erase!
:Br1     sta   Tmp3
         lda   SprI+4,x   ; Staring in the face of condemnation
         and   #$000F     ; Laughter fills the sky instead of rain
         ASLS  4          ; Live my life alone in resignation
         sta   Tmp2       ; Arms outstretched for those who cannot see
         lda   SprI+5,x   ; Scarecrow
         and   #$000F     ; Cruxified and left in isolation
         adc   Tmp2       ; This is how I lost morality
         dec              ; Scarecrow
         dec              ; Scarecrow
         sta   Tmp2       ; Eyeless stares invite his own damnation
         ASLS  2          ; Rotting corpse of inhumanity
         adc   Tmp2       ; Scarecorw
         ASLS  4          ; Scarecrow
         sec
         adc   Tmp3
         sta   DraW+1,y
         inc   ErAc
SlimBal3 sep   #$20
         rts
