         lst   on
* Fast mouse routine v0.1, (c) Ace '93
* Fast mouse routine v0.1b, Garote '93
* Fast mouse routine v0.24, Garote '94
* Fast mouse routine v0.26, Ace '94
*
         lst   off

         DUM   ]ZPSys
MouseX   DS    2          ; Mouse zp
MouseY   DS    2
Button   DS    2
OldMIndx DS    2
]ZPSys      =     *
         DEND

         MX    %00
DoMouse  phb
         pea   #>ShrA
         plb
         plb
         SEP   #$20
         LDA   $C027
         BPL   :Br1
         AND   #%00000010
         BEQ   DataFull
         LDA   $C024      ;kill corrupt byte
:Br1     rep   #$30
         JMP   DrawMous   ; No data? Draw anyway!

         mx    %10
DataFull LDA   $C024
         REP   #$21
         BIT   #%0000000001000000
         BEQ   :Br1
         ORA   #%1111111110000000
         adc   MouseX
         BPL   GetY
         LDA   #$0000
         BRA   GetY

:Br1     AND   #%0000000001111111
         ADC   MouseX
         CMP   #312
         BCC   GetY
         LDA   #312
GetY     STA   MouseX

         SEP   #$30
         ldx   #$ff
         stx   Button
         LDA   $C024
         Bpl   *+4        ; If button is down now,
         stz   Button     ; but wasn't before, set flag.

         REP   #$31
         AND   #%0000000001111111
         BIT   #%0000000001000000
         BEQ   :Br1
         ORA   #%1111111110000000
         adc   MouseY
         BPL   DoneMRd
         LDA   #$0000
         BRA   DoneMRd

:Br1     ADC   MouseY
         CMP   #188
         BCC   DoneMRd
         LDA   #188
DoneMRd  STA   MouseY
         LDX   OldMIndx
         LDA   $2000,X
         STA   $2000,X
         LDA   $20A0,X
         STA   $20A0,X
         LDA   $2140,X
         STA   $2140,X
         LDA   $21E0,X
         STA   $21E0,X
         LDA   $2280,X
         STA   $2280,X
         LDA   $2282,X
         STA   $2282,X
         LDA   $2320,X
         STA   $2320,X
         LDA   $2322,X
         STA   $2322,X
         LDA   $23C0,X
         STA   $23C0,X
         LDA   $23C2,X
         STA   $23C2,X
         LDA   $2460,X
         STA   $2460,X
         LDA   $2462,X
         STA   $2462,X
         LDA   $2501,X
         STA   $2501,X
         LDA   $25A2,X
         STA   $25A2,X
         SEP   #$20
         LDA   $2142,X
         STA   $2142,X
         LDA   $21E2,X
         STA   $21E2,X
         LDA   $23C4,X
         STA   $23C4,X
         LDA   $2464,X
         STA   $2464,X
         LDA   $2503,X
         STA   $2503,X
         rep   #$20
DrawMous LDA   MouseY
         AND   #$00FF
         ASLS  5
         STA   Tmp
         ASLS  2
         ADC   Tmp        ; MouseY x $A0
         ASl              ; MouseY x $140
         adc   MouseX     ; MouseY x $140 + MouseX
         lsr              ; MouseY x $A0 + MouseX / $2
         STA   OldMIndx
         TAX
         pea   #>ShrB     ; $E1
         plb
         plb
         LDA   MouseX
         BIT   #$0001
         BNE   *+5
         jmp   MouseAr1
         LDA   $2000,X
         AND   #$FF0
         ORA   #$F00F
         STA   $2000,X
         LDA   $20A0,X
         AND   #$F0
         ORA   #$F0F
         STA   $20A0,X
         LDA   $2140,X
         AND   #$F0
         ORA   #$F
         STA   $2140,X
         LDA   $21E0,X
         AND   #$F0
         ORA   #$F
         STA   $21E0,X
         LDA   $2280,X
         AND   #$F0
         ORA   #$F
         STA   $2280,X
         LDA   $2282,X
         AND   #$F00
         ORA   #$F000
         STA   $2282,X
         LDA   $2320,X
         AND   #$F0
         ORA   #$F
         STA   $2320,X
         LDA   #$F00
         STA   $2322,X
         LDA   $23C0,X
         AND   #$F0
         ORA   #$F
         STA   $23C0,X
         STZ   $23C2,X
         LDA   $2460,X
         AND   #$F0
         ORA   #$FF0F
         STA   $2460,X
         LDA   #$FF00
         STA   $2462,X
         LDA   #$FF0
         STA   $2502,X
         LDA   $25A2,X
         AND   #$F0
         ORA   #$FF0F
         STA   $25A2,X
         SEP   #$20
         LDA   $2142,X
         AND   #$F
         ORA   #$F0
         STA   $2142,X
         LDA   #$F
         STA   $21E2,X
         LDA   $23C4,X
         AND   #$F
         ORA   #$F0
         STA   $23C4,X
         LDA   $2464,X
         AND   #$F
         ORA   #$F0
         STA   $2464,X
         PLB
         RTS

         MX    %00
MouseAr1 LDA   $20A0,X
         AND   #$F00
         ORA   #$F0F0
         STA   $20A0,X
         LDA   #$FF0
         STA   $2140,X
         STA   $2461,X
         LDA   #$F0
         STA   $21E0,X
         STA   $2280,X
         STA   $2320,X
         STA   $23C0,X
         LDA   $2322,X
         AND   #$F00
         ORA   #$F000
         STA   $2322,X
         LDA   #$F00
         STA   $23C2,X
         LDA   $2501,X
         AND   #$F0
         ORA   #$F
         STA   $2501,X
         LDA   $25A2,X
         AND   #$F00
         ORA   #$F0FF
         STA   $25A2,X
         SEP   #$20
         LDA   #$FF
         STA   $2000,X
         STA   $2460,X
         STA   $2463,X
         LDA   $21E2,X
         AND   #$F
         ORA   #$F0
         STA   $21E2,X
         LDA   #$F
         STA   $2282,X
         LDA   $2503,X
         AND   #$F
         ORA   #$F0
         STA   $2503,X
         PLB
         RTS
