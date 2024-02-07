         lst   on
* Sprite: AnBrik v0.14
         lst   off

* 1- animation stage (1-3)
* 2- color of brick x3
* 3- bit 1=offscreen, bit 8=moving backwards
* 4,5- HS
* 6- VS 1=bottom of screen
* 7- Vertical Velocity <$80=down

AnBrik   sep   #$20
         ldx   Tmp
         lda   SprI+3,x
         bmi   :Left    ; increment the horizontal
         rep   #$20
         inc   SprI+4,x   ; movement according to direction
         bra   AnBrik2
:Left    REP   #$20
         dec   SprI+4,x
AnBrik2  sep   #$20
         inc   SprI+7,x
         lda   SprI+7,x   ; increment the vertical speed
         cmp   #$80       ; If the speed is neutral,
         beq   AnBrik8    ; don't bother to update
         eor   #$80
         bpl   AnBrik9
         eor   #$FF
         sta   Tmp
         lda   SprI+6,x
         sec
         adc   Tmp
         sta   SprI+6,x
         cmp   #$C0
         bcc   AnBrik8    ; If offscreen, skip it.
         sep   #$20
         lda   SprI+3,x
         ora   #$01
         sta   SprI+3,x
         bra   AnBrik8
AnBrik9  sta   Tmp
         lda   SprI+6,x
AnBrikA  cmp   #$00
         bne   AnBrikC
AnBrikD  jmp   KillDis
AnBrikC  dec
         dec   Tmp
         bne   AnBrikA
         sta   SprI+6,x
AnBrik8  rep   #$20
         lda   SprI+4,x
         cmp   WinXEdgeTotalFifths
         bcs   AnBrikD    ; Not on screen
         lda   WinXEdgeTotalFifths
         sec
         sbc   SprI+4,x
         cmp   #$004E
         bcs   AnBrikD    ; Not on screen
         sta   DraW+1,y
         lda   SprI+6,x
         and   #$00ff
         sta   Tmp        ; 1- animation stage (1-3)
         ASLS  2          ; 2- color of brick x3
         adc   Tmp        ; 3- bit 1=offscreen, bit 8=backwards
         ASLS  4          ; 4,5- HS
         adc   DraW+1,y   ; 6- VS 1=bottom of screen
         sta   DraW+1,y    ; 7- VV <$80=down
         sep   #$20
         lda   SprI+3,x
         and   #$FE
         sta   SprI+3,x
AnBrik4  lda   SprI+3,x
         and   #$0F
         bne   AnBrik5    ; If offscreen, don't update shit.
         lda   SprI+1,x
         dec              ; Current animation stage (0-3)
         clc              ; +
         adc   SprI+2,x   ; Color of brick x3
         sta   DraW,y     ; = current sprite
         lda   SprI+3,x   ; Direction of rot/mov
         bmi   AnBrik6    ; 1=backwards
         dec   SprI+1,x
         lda   SprI+1,x
         bne   AnBrik7
         lda   #$03       ; Update the animation frame
         sta   SprI+1,x
         bra   AnBrik7
AnBrik6  inc   SprI+1,x
         lda   SprI+1,x
         cmp   #$04       ; Update the frame if going the other way
         bne   AnBrik7
         lda   #$01
         sta   SprI+1,x
AnBrik7  inc   ErAc
AnBrik5  rts
