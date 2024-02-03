         lst   on
* Sprite: Chester v0.11
         lst   off

Chester  sep   #$20       ; actual entry point
         ldx   Tmp
         lda   SprI+3,x
         cmp   SprI+2,x   ; If in timer mode, skip
         bcc   ChesterC   ; 1: animation stage (0-7)
         rep   #$20       ; 2: jump height (velocity)(inverted!)
         lda   ClBk       ; 3: velocity/timer status
         sec              ; 4-5: H strip
         sbc   SprI+4,x   ; 6: V strip (bottom=1)
         cmp   #$004E     ; 7: timer delay value
         bcs   ChesterB
         sta   Tmp2       ; onscreen
         lda   SprI+6,x
         and   #$00ff
         sta   Tmp
         ASLS  2
         adc   Tmp
         ASLS  4
         adc   Tmp2
         sta   DraW+1,y
         sep   #$20
         lda   SprI+1,x
         and   #$04
         lsr
         lsr
         adc   #$16       ; offset into sprite data
         sta   DraW,y     ; = current sprite
         inc   ErAc       ; Update the animation frame
         inc   SprI+1,x
         lda   SprI+3,x
         eor   #$80
         clc
         adc   SprI+6,x   ; Add/subtract velocity
         sta   SprI+6,x
         lda   SprI+3,x
ChesterC dec              ; Decrease timer/velocity
         cmp   SprI+7,x
         bne   ChesterD
         lda   SprI+2,x   ; If it's a zero, jump again
         eor   #$FF
         inc
ChesterD sta   SprI+3,x
         rts
ChesterB jmp   KillDis
