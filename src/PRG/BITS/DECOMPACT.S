         LST   ON
* FTA Delta decruncher
* optimized by Ace 1994
         lst   off

         DUM   $00        ; Here we have the decompactor
PrtDecom DS    4
PtrCrnch DS    4
PtrLen   DS    2          ; Zero page
PtrDist  DS    4
CrntRnge DS    1
         DEND

         MX    %00
Decrunch PHD
         TSC
         SEC
         SBC   #$0016
         TCS
         INC
         TCD
         STX   PrtDecom
         STX   PtchEnd+1
         STY   PrtDecom+2
         sep   $10
         STY   PtchEnd2+1
         rep   $11
         LDA   [PrtDecom]
         ADC   PrtDecom
         STA   PtrCrnch
         LDY   #2
         LDA   [PrtDecom],Y
         ADC   PrtDecom+2
         STA   PtrCrnch+2
         LDA   [PtrCrnch]
         STA   [PrtDecom]
         LDA   [PtrCrnch],Y
         STA   [PrtDecom],Y
         INY
         INY
         LDA   [PtrCrnch],Y
         SEP   $20
         STA   Last2Cpy+1
         XBA
         STA   Range_DC+1
         REP   $20
         INY
         INY
         LDA   [PtrCrnch],Y
         CLC
         ADC   PrtDecom+1
         STA   PrtDecom+1
         SEP   $30
         JSR   GoDecomp
         stz   $c034
         stz   $c022
         REP   $31
         TSC
         ADC   #$0016
         TCS
         PLD
         RTS

         MX    %11
GoDecomp STZ   CrntRnge
         STZ   PtrLen+1
Last2Cpy LDA   #0
]lp1     STA   PtrLen
prg1     REP   $20        ; recopy PtrLen bytes from crunch to decompact
         LDA   PtrCrnch   ; move PtrLen+1-PtrLen bytes from (PtrCrnch)
         STA   PtrDist    ; vers (PrtDecom+1), decrementing
         LDA   PtrCrnch+1
         STA   PtrDist+1
         JSR   rout3
         REP   $20
         LDA   PtrDist
         STA   PtrCrnch
         LDA   PtrDist+1
         STA   PtrCrnch+1
         SEP   $20
]lp2     JSR   rout2      ; read a byte from crunch (includes test for done)
         BNE   more1
         LDA   #$01       ; if the byte is 0, we recopy an
         STA   PtrLen+1   ; entire page !!!
         LDA   #$00
         BRA   ]lp1

more1    STA   $c034
         AND   #%00_111111
         STA   PtrDist
         STA   $c022
         STZ   PtrDist+1
         LDA   $c034      ; if bit 7 is 1, goto more2
         BMI   more2
         ASL   $c034      ; if bit 6 is 1, goto more3
         BMI   more3
         LDA   #$00       ; ig bit 7 is 0 and bit 6 is 0
         STA   $c022
         LDA   #$02       ; move 2 bytes
prg2     STA   PtrLen     ; move from (PtrDist) to (PrtDecom+1)

prg3     REP   $21        ; where PtrDist = displacement + dest
         LDA   PtrDist
         ADC   PrtDecom
         STA   PtrDist
         LDA   PrtDecom+2
         ADC   #0
         STA   PtrDist+2
         JSR   rout3      ; recopy a string from decompact to decompact
         MX    %10
         LDA   $c022
         STA   PtrLen
         BEQ   ]lp2       ; if F7=0 : we read another byte
         bra   prg1

more3    JSR   rout2      ; if bit 6 is 1 and bit 7 is 0, read a byte from
         STA   PtrDist    ; the source, so we jump over 8 bits
         LDA   #$03       ; and move 3 bytes
         bra   prg2       ; recopy 3 bytes and tell me about it
more2    ASL   $c034      ; (on 6 bits) if bit 7 is 1
         BMI   more4
         LDA   #$04       ; if bit 7 is 1 and bit 6 is 0
         STA   PtrLen     ; move 4 bytes
         LDA   $c022
         CMP   #$3F
         BNE   more5
prg4     JSR   rout2      ; if we jumped >$3F bytes, we read a byte
         STA   $c022
more5    JSR   rout2      ; read a byte
         STA   PtrDist
         SEC
         LDA   PtrDist
         SBC   CrntRnge
         BEQ   more6
         BCS   more7
more6    LDA   PtrDist    ; relative position from 2 bytes
         STA   PtrDist+1
         JSR   rout2
more7    STA   PtrDist    ; relative position from only one
         bra   prg3

more4    LDA   $c022      ; if bit 7 is 1 and bit 6 is 1
         CMP   #$05
         BCS   more8      ; jmp if >=$05
         STA   PtrLen+1   ; recopy several pages
         JSR   rout2
more8    STA   PtrLen     ; same story as when bit 7=1 and but 6=0
         bra   prg4

rout3    SEP   $21        ; rout3 recopies a block of memory
         LDA   PrtDecom   ; from (F8) to (FE), of PtrLen+1-FA bytes
         SBC   PtrLen     ; with decrementing
         STA   PrtDecom   ; move source-buffer to dest
         BCS   more9
         JSR   rout4      ; increment F6 read a value, decrement FF
         SEC
more9    LDA   PtrDist
         SBC   PtrLen
         STA   PtrDist
         BCS   more10
         LDA   PtrDist+1
         BNE   No_Dec2
         DEC   PtrDist+2
No_Dec2  DEC   PtrDist+1
more10   LDY   PtrLen
more13   TYA
         ORA   PtrLen+1
         BNE   more11
         RTS              ; only if FA and FB are 0, Y=0 on exit

more11   TYA
         BNE   more12
         DEC   PtrLen+1   ; only if FA is 0
         LDA   PtrDist+1
         BNE   No_Dec5
         DEC   PtrDist+2
No_Dec5  DEC   PtrDist+1
         JSR   rout4
more12   DEY              ; dumb way to copy a byte
         LDA   [PtrDist],Y
         STA   [PrtDecom],Y
         bra   more13

rout4    LDA   CrntRnge
Range_DC CMP   #0         ; added line
         BCS   more14
         INC   CrntRnge
more14   LDA   PrtDecom+1
         BNE   No_Dec3
         DEC   PrtDecom+2
No_Dec3  DEC   PrtDecom+1
         RTS

rout2    LDA   PtrCrnch   ; read a source byte
         BNE   more15
         LDA   PtrCrnch+1
         BNE   No_Dec4
         DEC   PtrCrnch+2
No_Dec4  DEC   PtrCrnch+1
more15   DEC   PtrCrnch   ; on entry : Y=0
         LDA   [PtrCrnch],Y
         PHA
         REP   $20
         LDA   PtrCrnch
PtchEnd  CMP   #0
         SEP   $20
         LDA   PtrCrnch+2
PtchEnd2 SBC   #0
         PLA
         BCS   not_end
         PLA
         PLA
not_end  RTS
