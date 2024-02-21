         lst   on
* Guido motion handler v0.1
         lst   off

         sep   #$30
         lda   JoystkBtns01 ; Reset Button0Lifted if button 0 is up
         bmi   :KeepZ
         stz   Button0Lifted

:KeepZ   ldx   JoystkHDir
         lda   JoystkHLev        ; Affect JoystkHLev:
         cpx   #$04
         beq   Stick1
         cmp   #GVelocityHWalking
         bcc   Stick5     ; Non-FR
         dec              ; slowdown
Stick5   cpx   #$03
         bne   Stick3
         inc
         bra   Stick2
Stick1   cmp   #GVelocityHRunning     ; Fast right inc
         bcs   Stick2     ; with overflow control
         inc
         bra   Stick2
Stick3   cpx   #$00
         beq   Stick4
         cmp   #$100-GVelocityHWalking
         bcs   Stick6     ; Non-FL
         inc              ; slowdown
Stick6   cpx   #$01
         bne   Stick2
         dec
         bra   Stick2
Stick4   cmp   #$100-GVelocityHRunning
         bcc   Stick2     ; Fast left dec
         dec              ; with overflow control
Stick2   sta   JoystkHLev

         tay              ; Affect GVelocityX:
         lda   GVelocityX
         cpy   #GVelocityHWalking
         bcc   Stuck1
         cmp   #$81
         bcs   Stuck3
         inc
Stuck3   cpy   #GVelocityHRunning     ; Hold at R
         bcc   Stuck2
         cmp   #$82
         bcs   Stuck2
         inc
         bra   Stuck2
Stuck1   cpy   #$100-GVelocityHWalking
         bcs   Stuck5
         cmp   #$80
         bcc   Stuck4
         dec
Stuck4   cpy   #$101-GVelocityHRunning ; Hold at L
         bcs   Stuck2
         cmp   #$7F
         bcc   Stuck2
         dec
         bra   Stuck2
Stuck5   cmp   #$80       ; Rubber-band back to 0
         bcs   Stuck6
         inc
         bra   Stuck2
Stuck6   cmp   #$81
         bcc   Stuck2
         dec
Stuck2   sta   GVelocityX