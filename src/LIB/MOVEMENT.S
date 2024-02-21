         lst   on
* Guido motion handler v0.1
         lst   off

         sep   #$30
         lda   JoystkBtns01 ; Reset Button0Lifted if button 0 is up
         bmi   :KeepZ
         stz   Button0Lifted

:KeepZ   ldx   JoystkHDir
         lda   JoystkHLev

         cpx   #$04               ; Right Full
         bne   :NotRF
         cmp   #GVelocityHRunning ; If we're right full,
         bcs   :Done              ; but Guido is not at running speed to the right,
         inc                      ; speed him up
         bra   :Done

:NotRF   cmp   #GVelocityHWalking ; If we're not right full,
         bcc   *+3                ; but Guido is going right faster than a walk,
         dec                      ; slow him down

         cpx   #$03               ; Unless we're at Right,
         bne   :NotR              ; in which case we don't slow him down,
         inc                      ; but speed him up if he's not walking yet.
         bra   :Done

:NotR    cpx   #$00                ; Left Full
         bne   :NotLF
         cmp   #$100-GVelocityHRunning ; If we're left full,
         bcc   :Done                   ; but Guido is not at running speed to the left,
         dec                           ; speed him up
         bra   :Done

:NotLF   cmp   #$100-GVelocityHWalking ; If we're not left full,
         bcs   *+3                     ; but Guido is going left faster than a walk,
         inc                           ; slow him down

         cpx   #$01                ; Unless we're at Left,
         bne   :Done               ; in which case we don't slow him down,
         dec                       ; but speed him up if he's not walking yet

:Done    sta   JoystkHLev

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