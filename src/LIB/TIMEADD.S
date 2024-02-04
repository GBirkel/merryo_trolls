TimeAdd  rep   #$10
         ldy   #$0004     ; Updates only the changed digits!
         ldx   #$0000
         sep   #$20       ; Warning- over 999 calories can
         phb              ; result in death as well!
         pea   #>SHR
         plb
         plb
]lp      lda   Time2,x
         beq   NextIsE    ; If 0, Nothing to alter
         clc
         adc   Time1,x
         cmp   #$0A       ; If below 10,
         bcc   AhAh       ; no carry
         sec
         sbc   #$0A
         inc   Time2+1,x
AhAh     sta   Time1,x
         stz   Time2,x    ; Automatically clears for next add
         jsr   TimeDraw
NextIsE  inx
         dey
         dey
         bpl   ]lp
         plb
         rts

TimeDraw stx   Tmp        ; then do next char
         rep   #$20
         and   #$00FF
         ASLS  4
         tax
         LDal  Char+$740,x
         sta   $2062,y
         LDAl  Char+$742,x
         sta   $2102,y
         LDAl  Char+$744,x
         sta   $21A2,y
         ldal  Char+$746,x
         sta   $2242,y
         ldal  Char+$748,x
         sta   $22E2,y
         ldal  Char+$74A,x
         sta   $2382,y
         ldal  Char+$74C,x
         sta   $2422,y
         sep   #$20
         ldx   Tmp
         rts
