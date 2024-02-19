         lst   on
* Joystick interpreter v0.16
         lst   off

         SEP   $30
         LDAL  $E0C070
         LDY   #$60
         STZ   JoystkReadX
         STZ   JoystkReadY
]lp      LDAL  $E0C064
         BMI   *+6
         NOP              ; FTA's joystick routine
         NOP              ; /:)
         BRA   *+4
         INC   JoystkReadX
         LDAL  $E0C065
         BMI   *+6
         NOP
         NOP
         BRA   *+4
         INC   JoystkReadY
         LDAL  $E0C066
         BMI   *+6
         NOP
         NOP
         BRA   *+5
         NOP
         NOP
         NOP
         LDAL  $E0C067
         BMI   *+6
         NOP
         NOP
         BRA   *+5
         NOP
         NOP
         NOP
         BRA   *+2
         DEY
         BPL   ]lp

         rep   #$30
         LDA   JoystkReadX       ; Set JoystkHDir:
         ldx   #$0000
         cmp   #15        ; <-15,30,76,87->
         Bcc   Stork2     ; F Left
         inx
         cmp   #30
         Bcc   Stork2     ; S Left
         inx
         cmp   #76
         Bcc   Stork2     ; Middle
         inx
         cmp   #87
         Bcc   Stork2     ; S Right
         inx              ; F Right
Stork2   stx   JoystkHDir

         sep   #$30
         stz   JoystkBtns01
         ldx   #$40
         ldal  $00c062
         bmi   Turkey
         ldx   #$00
Turkey   stx   JoystkBtns01
         ldal  $00c061
         and   #$80
         tsb   JoystkBtns01

AutoSkip sep   #$30
         lda   JoystkBtns01 ; Reset JoyZ if button 0 is up
         bmi   Jiggle
         stz   JoyZ

Jiggle   ldx   JoystkHDir
         lda   JoystkHLev        ; Affect JoystkHLev:
         cpx   #$04
         beq   Stick1
         cmp   #MhMsv
         bcc   Stick5     ; Non-FR
         dec              ; slowdown
Stick5   cpx   #$03
         bne   Stick3
         inc
         bra   Stick2
Stick1   cmp   #MhMfv     ; Fast right inc
         bcs   Stick2     ; with overflow control
         inc
         bra   Stick2
Stick3   cpx   #$00
         beq   Stick4
         cmp   #$100-MhMsv
         bcs   Stick6     ; Non-FL
         inc              ; slowdown
Stick6   cpx   #$01
         bne   Stick2
         dec
         bra   Stick2
Stick4   cmp   #$100-MhMfv
         bcc   Stick2     ; Fast left dec
         dec              ; with overflow control
Stick2   sta   JoystkHLev

         tay              ; Affect GVelocityX:
         lda   GVelocityX
         cpy   #MhMsv
         bcc   Stuck1
         cmp   #$81
         bcs   Stuck3
         inc
Stuck3   cpy   #MhMfv     ; Hold at R
         bcc   Stuck2
         cmp   #$82
         bcs   Stuck2
         inc
         bra   Stuck2
Stuck1   cpy   #$100-MhMsv
         bcs   Stuck5
         cmp   #$80
         bcc   Stuck4
         dec
Stuck4   cpy   #$101-MhMfv ; Hold at L
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
