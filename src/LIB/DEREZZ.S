         LST   ON
* Chunky rez-out module v0.2 (c) garote 1994
         LST   OFF

RezzOut  PHB
         REP   $31
         stz   Tmp        ; Move original pic
         PEA   #>BackgPeaField-2 ; into storage
         PLB              ; for reference
         PLB
         ldx   #$7d00-$500
]lp      ldal  ShrB+$500-2,x
         stal  ShrA+$500-2,x ; (Note that this confirms the
         sta   BackgPeaField-2,x ; accuracy of bank 01, AND overwrites
         dex              ;  the established PEA fields)
         dex
         bne   ]lp

         PEA   #>BackgPeaField
         PLB
         PLB
         LDX   #0         ; Magnify 2
]lp2     LDY   #80
]lp      LDA   BackgPeaField,X
         AND   #$F0F0
         STA   Tmp
         LSRS  4
         ora   Tmp
         STA   BackgPeaField+$8000,X ; Store the conversion over the background
         STA   BackgPeaField+$8000+$A0,X ; PEA feild, for quick display later
         INX
         INX
         DEY
         BNE   ]lp
         TXA
         CLC
         ADC   #$A0
         TAX
         CPX   #$A0*192
         BNE   ]lp2

         PEA   #>ForegPeaField
         PLB
         PLB
         LDX   #0         ; Magnify 3
         TXA
]lp2     LDY   #53
]lp      rep   #$20
         LDAl  BackgPeaField+$A0,X
         AND   #$0FF0
         sep   #$20
         STA   Tmp
         STA   Tmp+1
         LSRS  4
         rep   #$20
         ORA   Tmp
         STA   ForegPeaField,X
         STA   ForegPeaField+$A0,X
         STA   ForegPeaField+$140,X
         xba
         sep   #$20
         and   #$0F
         sta   Tmp
         ASLS  4
         ora   Tmp
         STA   ForegPeaField+2,x
         STA   ForegPeaField+$A2,X
         STA   ForegPeaField+$142,X
         INX
         INX
         INX
         DEY
         BNE   ]lp
         REP   #$31
         TXA
         ADC   #$141
         TAX
         CPX   #$A0*192
         BCC   ]lp2

         ldx   #BackgPeaField+$8000 ; Display 2
         ldy   #SHR
         lda   #$77FE
         MVN   BackgPeaField+$8000,SHR

         jsr   Fade
         ldx   #ForegPeaField   ; Display 3
         ldy   #SHR
         lda   #$77FE
         MVN   ForegPeaField,SHR

         jsr   Fade
         LDX   #0         ; Magnify 4
]lp2     ldy   #80
]lp      ldal  BackgPeaField+$a1,x
         and   #$000f
         sta   Tmp
         sta   Tmp+1
         ora   Tmp
         ASLS  4
         ora   Tmp        ; No need for XBA this way
         STA   SHR,X
         STA   SHR+$A0,X
         STA   SHR+$140,X
         INX
         INX
         DEy
         BNE   ]lp
         TXA
         CLC
         ADC   #$A0*2
         TAX
         CMP   #$A0*192
         BCC   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify 5
]lp2     LDY   #32
]lp      LDAl  2*$a0+BackgPeaField,X
         AND   #$F000
         sta   Tmp+1
         sta   Tmp
         ora   Tmp+1
         LSRS  4
         ora   Tmp+1      ; No need for XBA this way
         STA   SHR,X
         STA   SHR+$A0,X
         STA   SHR+$140,X
         STA   SHR+$1e0,X
         sep   #$20
         ldal  2*$a0+BackgPeaField+4,x
         and   #$0F
         sta   Tmp
         ORA   Tmp+1
         STA   SHR+2,x
         STA   SHR+$A2,X
         STA   SHR+$142,X
         STA   SHR+$1e2,X
         ASLS  4
         ora   Tmp
         sta   Tmp
         xba
         lda   Tmp
         rep   #$21
         STA   SHR+3,X
         STA   SHR+$A3,X
         STA   SHR+$143,X
         STA   SHR+$1e3,X
         txa
         adc   #$0005
         tax
         DEY
         BNE   ]lp
         TXA
         ADC   #$a0*3
         TAX
         CPX   #$A0*192
         BCs   *+5
         jmp   ]lp2

         jsr   Fade
         LDX   #2         ; Magnify 6
]lp2     LDY   #26
]lp      LDAl  2*$a0+BackgPeaField+2,X
         AND   #$000F
         sta   Tmp
         sta   Tmp+1
         ora   Tmp
         ASLS  4
         ora   Tmp        ; No need for XBA this way
         STA   SHR,X
         STA   SHR+$A0,X
         STA   SHR+$140,X
         STA   SHR+$1e0,X
         sep   #$20
         INX
         inx
         ldal  2*$a0+BackgPeaField+2,x
         and   #$0F
         sta   Tmp+1
         ASLS  4
         ora   Tmp+1
         sta   Tmp
         XBA
         rep   #$20
         STA   SHR,x
         STA   SHR+$A0,X
         STA   SHR+$140,X
         STA   SHR+$1e0,X
         INX
         INX
         sep   #$20
         lda   Tmp
         rep   #$21
         STA   SHR,X
         STA   SHR+$A0,X
         STA   SHR+$140,X
         STA   SHR+$1e0,X
         INX
         inx
         DEY
         Beq   *+5
         jmp   ]lp
         TXA
         ADC   #$a0*3+4
         TAX
         CPX   #$A0*192
         BCs   *+5
         jmp   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify 7
         stz   Tmp        ; this one is infuriating
]lp2     LDY   #22
]lp      LDAl  3*$A0+BackgPeaField+1,x
         AND   #$F000
         sta   Tmp+1
         sta   Tmp
         ora   Tmp+1
         LSRS  4
         ora   Tmp+1      ; No need for XBA this way
]A       =     0
         LUP   6
         STA   ]A*$A0+SHR,X
]A       =     ]A+1
         --^
         and   #$F0FF
         sta   Tmp+2
         ldal  3*$a0+BackgPeaField+5,x
         AND   #$000F
         STA   Tmp
         ASLS  4
         ORA   Tmp
         sep   #$20
]A       =     0
         LUP   6
         STA   ]A*$A0+SHR+6,X
]A       =     ]A+1
         --^
         rep   #$21
         sta   Tmp
         Xba
         ora   Tmp
]A       =     0
         LUP   6
         STA   ]A*$A0+SHR+4,X
]A       =     ]A+1
         --^
         and   #$0F00
         ora   Tmp+2
]A       =     0
         LUP   6
         STA   ]A*$A0+SHR+2,X
]A       =     ]A+1
         --^
         txa
         adc   #$0007
         tax
         DEY
         BEq   *+5
         jmp   ]lp
         LDA   3*$A0+BackgPeaField+1,X
         AND   #$F000
         STA   Tmp        ; Extra single block to fill up remainder
         LSRS  4
         ORA   Tmp
         sta   Tmp
         Xba
         ora   Tmp
]A       =     0
         LUP   6
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
]A       =     ]A+1
         --^
         TXA
         ADC   #5*$A0+6
         TAX
         CPX   #$A0*192
         BCS   *+5
         jmp   ]lp2

         jsr   Fade
         stz   Tmp
         LDX   #0         ; Magnify 8
]lp2     LDy   #40
]lp      ldal  3*$a0+BackgPeaField+2,x
         and   #$000f
         sta   Tmp
         sta   Tmp+1
         ora   Tmp
         ASLS  4
         ora   Tmp        ; No need for XBA this way
]A       =     0
         LUP   6
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
]A       =     ]A+1
         --^
         INX
         INX
         INX
         INX
         dey
         BNE   ]lp
         TXA
         CLC
         ADC   #$A0*5
         TAX
         CPX   #$A0*192
         BCC   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify10
]lp2     LDy   #32
]lp      ldal  4*$a0+BackgPeaField+3,x
         and   #$000f
         sta   Tmp
         sta   Tmp+1
         ora   Tmp
         ASLS  4
         ora   Tmp        ; No need for XBA this way
]A       =     0
         LUP   8
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
         STA   ]A*$A0+SHR+3,X
]A       =     ]A+1
         --^
         txa
         clc
         adc   #$0005
         tax
         dey
         BEQ   *+5
         jmp   ]lp
         ADC   #$A0*7
         TAX
         CPX   #$A0*192
         BCs   *+5
         jmp   ]lp2

         jsr   Fade
         stz   Tmp
         LDX   #2         ; Magnify 12
]lp2     LDy   #26
]lp      ldal  5*$a0+BackgPeaField+3,x
         and   #$000f
         sta   Tmp
         sta   Tmp+1
         ora   Tmp
         ASLS  4
         ora   Tmp        ; No need for XBA this way
]A       =     0
         LUP   10
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
         STA   ]A*$A0+SHR+4,X
]A       =     ]A+1
         --^
         txa
         adc   #$0006
         tax
         dey
         BEq   *+5
         jmp   ]lp
         TXA
         CLC
         ADC   #$A0*9+4
         TAX
         CPX   #$A0*183
         BCs   *+5
         jmp   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify 16
]lp2     LDy   #20
]lp      ldal  6*$a0+BackgPeaField+4,x
         and   #$000f
         sta   Tmp
         sta   Tmp+1
         ora   Tmp
         ASLS  4
         ora   Tmp        ; No need for XBA this way
]A       =     0
         LUP   12
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
         STA   ]A*$A0+SHR+4,X
         STA   ]A*$A0+SHR+6,X
]A       =     ]A+1
         --^
         TXA
         CLC
         ADC   #$0008
         TAX
         DEy
         BEQ   *+5
         jmp   ]lp
         ADC   #$A0*11
         TAX
         CPX   #$A0*192
         BCS   *+5
         jmp   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify 20
]lp2     LDy   #16
]lp      ldal  8*$a0+BackgPeaField+5,x
         and   #$000f
         sta   Tmp
         sta   Tmp+1
         ora   Tmp
         ASLS  4
         ora   Tmp        ; No need for XBA this way
]A       =     0
         LUP   16
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
         STA   ]A*$A0+SHR+4,X
         STA   ]A*$A0+SHR+6,X
         STA   ]A*$A0+SHR+8,X
]A       =     ]A+1
         --^
         TXA
         CLC
         ADC   #10
         TAX
         DEy
         BEQ   *+5
         jmp   ]lp
         ADC   #$A0*15
         TAX
         CPX   #$A0*192
         BCS   *+5
         jmp   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify24
]lp2     LDy   #13        ; This one is evil
]lp      ldal  10*$a0+BackgPeaField+6,x
         and   #$000f
         STA   Tmp
         ASLS  4
         ORA   Tmp
         sta   Tmp
         Xba
         ora   Tmp
]A       =     0
         LUP   20
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
         STA   ]A*$A0+SHR+4,X
         STA   ]A*$A0+SHR+6,X
         STA   ]A*$A0+SHR+8,X
         STA   ]A*$A0+SHR+10,X
]A       =     ]A+1
         --^
         TXA
         CLC
         ADC   #12
         TAX
         DEy
         BEQ   *+5
         jmp   ]lp
         ADC   #$A0*19+4
         TAX
         CPX   #$A0*180
         BCS   *+5
         jmp   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify32
]lp2     LDy   #10
]lp      ldal  12*$a0+BackgPeaField+8,x
         and   #$000f
         STA   Tmp
         ASLS  4
         ORA   Tmp
         sta   Tmp
         Xba
         ora   Tmp
]A       =     0
         LUP   24
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
         STA   ]A*$A0+SHR+4,X
         STA   ]A*$A0+SHR+6,X
         STA   ]A*$A0+SHR+8,X
         STA   ]A*$A0+SHR+10,X
         STA   ]A*$A0+SHR+12,X
         STA   ]A*$A0+SHR+14,X
]A       =     ]A+1
         --^
         TXA
         CLC
         ADC   #16
         TAX
         DEy
         BEQ   *+5
         jmp   ]lp
         ADC   #$A0*23
         TAX
         CPX   #$A0*192
         BCS   *+5
         jmp   ]lp2

         jsr   Fade
         LDX   #0         ; Magnify 40
]lp2     LDy   #8
]lp      ldal  16*$a0+BackgPeaField+10,x
         and   #$000f
         STA   Tmp
         ASLS  4
         ORA   Tmp
         sta   Tmp
         Xba
         ora   Tmp
]A       =     0
         LUP   32
         STA   ]A*$A0+SHR,X
         STA   ]A*$A0+SHR+2,X
         STA   ]A*$A0+SHR+4,X
         STA   ]A*$A0+SHR+6,X
         STA   ]A*$A0+SHR+8,X
         STA   ]A*$A0+SHR+10,X
         STA   ]A*$A0+SHR+12,X
         STA   ]A*$A0+SHR+14,X
         STA   ]A*$A0+SHR+16,X
         STA   ]A*$A0+SHR+18,X
]A       =     ]A+1
         --^
         TXA
         CLC
         ADC   #20
         TAX
         DEy
         BEQ   *+5
         jmp   ]lp
         ADC   #$A0*31
         TAX
         CPX   #$A0*192
         BCS   *+5
         jmp   ]lp2
         PLB
         RTS

Fade     rep   #$30
         LDX   #8*$20-2
]lp      LDA   $9E00,X
         beq   Zero4
         tay
         AND   #$0F00
         BEQ   Zero1
         tya
         SBC   #$0100
         tay
Zero1    tya
         AND   #$00F0
         BEQ   :Br1
         tya
         SBC   #$0010
         tay
:Br1     tya
         AND   #$000F
         BEQ   Zero3
         dey
Zero3    tya
         STA   $9E00,X
Zero4    DEX
         DEX
         BPL   ]lp        ; Continue for the next color
         RTS
