         lst   on
* Sprite: PufSmok v0.11
         lst   off

PuffSmoke rep   #$20       ; actual entry point
         ldx   Tmp
         lda   SprI+4,x
         cmp   WinXEdgeTotalFifths
         bcs   PufSmokB   ; Not on screen
         lda   WinXEdgeTotalFifths
         sec
         sbc   SprI+4,x
         cmp   #$004E
         bcs   PufSmokB   ; Not on screen
         sta   Tmp2
         lda   SprI+6,x   ; 1- animation stage (0-3)
         and   #$00ff     ; 4,5- H strip
         sta   Tmp        ; 6- V strip (bottom=1)
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
         beq   PufSmokB
         inc   ErAc       ; Update the animation frame
         rts
PufSmokB jmp   KillDis
