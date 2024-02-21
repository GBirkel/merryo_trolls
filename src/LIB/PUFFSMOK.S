         lst   on
* Sprite: PufSmok v0.11
         lst   off

* 1- animation stage (0-4)
* 4+5- Map X in block fifths
* 6- Map Y in block 16ths (from bottom)

PuffSmoke rep   #$20       ; actual entry point
         ldx   Tmp
         lda   SprI+4,x
         cmp   WinXEdgeTotalFifths
         bcc   *+5         ; Not on screen
         jmp   KillDis
         lda   WinXEdgeTotalFifths
         sec
         sbc   SprI+4,x
         cmp   #$004E
         bcc   *+5        ; Not on screen
         jmp   KillDis
         sta   Tmp2
         lda   SprI+6,x
         and   #$00ff
         sta   Tmp
         ASLS  2
         adc   Tmp        ; Vert.strip x 5
         ASLS  4          ; x 80
         adc   Tmp2       ; plus horizontal offset
         sta   DraW+1,y
         sep   #$20
         lda   SprI+1,x   ; Current animation stage
         clc              ; +
         adc   #$68       ; offset into sprite data
         sta   DraW,y     ; = current sprite
         inc   SprI+1,x
         lda   SprI+1,x
         cmp   #$05
         bne   *+5
         jmp   KillDis
         inc   SpritesOnScreenCnt ; Update the animation frame
         rts
