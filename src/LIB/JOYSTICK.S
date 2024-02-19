         lst   on
* Joystick interpreter v0.16
         lst   off

         lda   GameFlags    ; Skip new reads if autopilot is running
         bmi   AutoPilotSkip

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
         Bcc   :Match     ; F Left
         inx
         cmp   #30
         Bcc   :Match     ; S Left
         inx
         cmp   #76
         Bcc   :Match     ; Middle
         inx
         cmp   #87
         Bcc   :Match     ; S Right
         inx              ; F Right
:Match   stx   JoystkHDir

         sep   #$30
         ldx   #$40
         ldal  $00c062
         bmi   :Button1
         ldx   #$00
:Button1 stx   JoystkBtns01
         ldal  $00c061
         and   #$80
         tsb   JoystkBtns01

AutoPilotSkip = *
         sep   #$30
         lda   JoystkBtns01 ; Reset JoyZ if button 0 is up
         bmi   :KeepZ
         stz   JoyZ

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
