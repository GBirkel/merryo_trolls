         lst   on
* Joystick reader v0.16
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
