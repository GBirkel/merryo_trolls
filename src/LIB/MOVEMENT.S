         lst   on
* Guido motion handler v0.3
         lst   off

         sep   #$30
         lda   JoystkBtns01 ; Reset Button0StillDown if button 0 is up
         bmi   :KeepZ
         stz   Button0StillDown

:KeepZ   ldy   #$01
         lda   GOnSolidGround     ; Note this is the flag value from the
         beq   *+4                ; previous game cycle.
         ldy   #$02               ; Standing on solid ground makes velocity

         ldx   JoystkHDir
         lda   JoystkHLev
]lp      jsr   InterpretHDir      ; We apply the direction to the velocity
         dey                      ; once if Guido is in the air, twice if
         bne   ]lp                ; on solid ground.
         bra   CalculatedHLev

InterpretHDir = *
         cpx   #$04               ; If we're Right Full,
         bne   :NotRF
         cmp   #GVelocityHRunning
         bcs   :Done              ; but Guido is not at running speed to the right,
         inc                      ; speed him up
         bra   :Done

:NotRF   cpx   #$00               ; If we're Left Full,
         bne   :NotLF
         cmp   #$101-GVelocityHRunning
         bcc   :Done              ; but Guido is not at running speed to the left,
         dec                      ; speed him up
         bra   :Done

:NotLF   cpx   #$03               ; If we're at Right (but not Full)
         bne   :NotR
         cmp   #GVelocityHWalking+1
         bcs   *+5                ; and Guido is going right faster than a walk,
         dec                      ; slow him down.
         bra   :Done
         cmp   #GVelocityHWalking ; But if he's going slower than a walk,
         bcc   *+5                ; speed him up.
         inc
         bra   :Done

:NotR    cpx   #$01               ; If we're Left (but not Full)
         bne   :NotL
         cmp   #$100-GVelocityHWalking
         bcs   *+5                ; and Guido is going left faster than a walk,
         inc                      ; slow him down.
         bra   :Done
         cmp   #$101-GVelocityHWalking ; But if he's going slower than a walk,
         bcc   *+5                     ; speed him up.
         dec
         bra   :Done

:NotL    cmp   #$80               ; The only remaining position is centered
         bcs   *+5                ; so we decelerate towards neutral (#$80)
         inc
         bra   :Done
         cmp   #$81
         bcc   *+3
         dec

:Done    rts

CalculatedHLev = *
         sta   JoystkHLev
         tay              ; Translate thresholds into GVelocityX:
         lda   #$82
         cpy   #GVelocityHRunning     ; Hold at R
         bcs   :Done2
         lda   #$81
         cpy   #GVelocityHWalking
         bcs   :Done2
         lda   #$7E
         cpy   #$101-GVelocityHRunning ; Hold at L
         bcc   :Done2
         lda   #$7F
         cpy   #$101-GVelocityHWalking
         bcc   :Done2
         lda   #$80
:Done2   sta   GVelocityX