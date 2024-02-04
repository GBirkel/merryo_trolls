         lst   on
* Sprite: CoinGet v0.12
         lst   off

CoinGet  rep   #$20       ; actual entry point
         ldx   Tmp
         lda   SprI+4,x   ; 1- animation stage (0-4)
         cmp   ClBk       ; 2- flip count
         bcs   CoinGetC   ; 4,5- H strip
         lda   ClBk       ; 6- V strip (bottom=1)
         sec
         sbc   SprI+4,x
         cmp   #$004F
         bcs   CoinGetC   ; Not on screen
         sta   Tmp2
         lda   SprI+6,x
         and   #$00ff
         cmp   #$00B0     ; Off screen vertically?
         bcs   CoinGetC   ; Bye bye!
         ASLS  4          ; x $10
         sta   Tmp
         ASLS  2          ; x $40
         adc   Tmp        ; Vert.strip x $50
         adc   Tmp2       ; plus horizontal offset
         sta   DraW+1,y
         sep   #$20
         lda   SprI+1,x   ; Current animation stage
         clc              ; +
         adc   #$70       ; offset into sprite data
         sta   DraW,y     ; = current sprite
         inc   SprI+1,x
         inc   ErAc
         inc   SprI+6,x
         inc   SprI+6,x   ; Move up two vertical strips
         lda   SprI+1,x
         cmp   #$05
         bne   CoinGetB
         stz   SprI+1,x   ; Update the animation frame
         inc   SprI+2,x
         lda   SprI+2,x
         cmp   #$02
         bne   CoinGetB
         lda   #$03       ; This is risky I suppose,
         sta   SprI,x     ; Since we're actually changing
         dec              ; the I.D. of this sprite to another
         sta   SprI+1,x   ; on the fly...
CoinGetB rts              ; Better call the subroutine
CoinGetC jmp   KillDis    ; at $FA/6607!
