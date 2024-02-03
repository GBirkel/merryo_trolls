
ScoreAdd rep   #$10
         ldy   #$000E     ; Updates only the changed digits!
         ldx   #$0000
         sep   #$20
         phb
         pea   #>SHR
         plb
         plb
]lp      lda   Score2,x
         beq   MyBaby     ; If 0, Nothing to alter
         clc
         adc   Score1,x
         cmp   #$0A       ; If below 10,
         bcc   Stream     ; no carry
         sec
         sbc   #$0A
         inc   Score2+1,x
Stream   sta   Score1,x
         stx   Tmp
         rep   #$20
         and   #$00FF
         ASLS  4
         tax
         LDal  Char+$740,x
         sta   $201c,y
         LDAl  Char+$742,x
         sta   $20Bc,y
         LDAl  Char+$744,x
         sta   $215c,y
         ldal  Char+$746,x
         sta   $21Fc,y
         ldal  Char+$748,x
         sta   $229c,y
         ldal  Char+$74A,x
         sta   $233c,y
         ldal  Char+$74C,x
         sta   $23dc,y
         sep   #$20
         ldx   Tmp
         stz   Score2,x   ; Automatically clears for next add
MyBaby   inx
         dey
         dey
         bpl   ]lp
         plb
         rts
