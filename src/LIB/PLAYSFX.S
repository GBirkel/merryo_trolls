         LST   ON
*
* SFX v0.01 (c) ace 1994, v0.01m garote 1994
         LST   OFF

         DUM   ]ZPPlay
IntVol   DS    2          ;volume
]ZPPlay  =     *
         DEND

SFXsetup PHP
         PHD
         PHB
         rep   #$30
         pea   #Zpl
         pld
         lda   #$0000
         ldx   #SFXdata
         tay
         SEP   #$20
         LDAL  $E100CA    ;CP volume
         AND   #%00001111 ;retain volume
         STA   IntVol     ;doc, no inc
         ORA   #%00100000 ;doc, auto inc
         STA   IntVol+1
         STAL  EsqC
         LDA   #$E1
         STAL  EsqA
         LDA   #52        ;26 osc enable
         STAL  EsqD
         LDA   #$3F       ;move 16k
         REP   #$30       ;a = # of pages to move
         PHY              ;x = loc to move from
         TAY              ;y = loc to move to
         LDA   #$C000     ;EsqC = IntVol+1
         TCD              ;
         PLA
         STA   $3E
         SEP   #$20
         LDA   #^SFXdata
         PHA
         PLB
         LDA   $3C
         ORA   #%01100000 ;DOC ram, auto inc
         STA   $3C
]A       =     0
]lp      LUP   $100       ;move DOCdata into DOC ram
         LDA:  ]A,X       ;256 bytes at a time
         STA   $3D
]A       =     ]A+1
         --^
         DEY
         BEQ   :Br1
         REP   #$21
         TXA
         ADC   #$0100
         TAX
         SEP   #$20
         JMP   ]lp
:Br1     PLB
         PLD
         LDA   IntVol+1
         STAL  EsqC
         PLP
         RTS

PlaySFX  PHP
         sep   #$20
         rep   #$10
         ldx   #$0001
         LDA   IntVol
         STAL  EsqC
         LDA   #$b8
         STAL  EsqA
         LDAL  EsqD
         LDAL  EsqD
         ORA   #$01
         STAL  EsqD
         lda   #$b9
         STAL  EsqA
         LDAL  EsqD
         LDAL  EsqD
         ORA   #$01
         STAL  EsqD       ;stop oscb
         LDA   IntVol+1
         STAL  EsqC
         lda   #$18       ;stuff regs
         STAL  EsqA
         ldy   SFXPitch,x
         lda   FreqTbl,y
         STAL  EsqD
         STAL  EsqD
         lda   #$38
         STAL  EsqA
         lda   FreqTbl+1,y
         STAL  EsqD
         STAL  EsqD
         lda   #$58
         STAL  EsqA
         LDA   SFXVA,X
         TAY
         LDA   VolTbl,Y
         STAL  EsqD
         LDA   SFXVB,X
         TAY
         LDA   VolTbl,Y
         STAL  EsqD
         lda   #$98
         STAL  EsqA
         LDA   SFXWTblA,X
         STAL  EsqD
         LDA   SFXWTblB,X
         STAL  EsqD
         lda   #$d8
         STAL  EsqA
         LDA   SFXWSzA,X
         STAL  EsqD
         LDA   SFXWSzB,X
         STAL  EsqD
         lda   #$b8
         STAL  EsqA
         LDA   SFXCntlA,X
         STAL  EsqD
         LDA   SFXCntlB,X
         STAL  EsqD
         plp
         RTS

FreqTbl  HEX   0000000000000000
         HEX   00001600170018001A001B001D001E002000220024002600
         HEX   29002B002E003100330036003A003D004100450049004D00
         HEX   520056005C00610067006D0073007A008100890091009A00
         HEX   A300AD00B700C200CE00D900E600F4000201120122013301
         HEX   46015A016F0184019B01B401CE01E9010602250246026902
         HEX   8D02B402DD020903370368039C03D3030D044A048C04D104
         HEX   1A056805BA0511066E06D0063707A5071A0895081809A209
         HEX   350AD00A750B230CDC0C9F0D6F0E4B0F33102A112F124413
         HEX   6914A015E9164618B7193F1BDE1C951E
                          ;org last 4: 662054225E248826
VolTbl   HEX   0012141517181A1B1D1E202123242627
         HEX   292A2C2D2F303233353638393B3C3E3F
         HEX   4142444547484A4B4D4E505153545657
         HEX   595A5C5D5F606263656668696B6C6E6F
         HEX   7172747577787A7B7D7E808183848687
         HEX   898A8C8D8F909293959698999B9C9E9F
         HEX   A1A2A4A5A7A8AAABADAEB0B1B3B4B6B7
         HEX   B9BABCBDBFC0C2C3C5C6C8C9CBCCCECF

SFXPitch HEX   003C       ;about 5.5 kHz

SFXVA    HEX   007F       ;full volume
SFXVB    HEX   007F

SFXWSzA  HEX   0024       ;4k sample
SFXWSzB  HEX   0024

SFXWTblA HEX   0000       ;at address $00
SFXWTblB HEX   0000

SFXCntlA HEX   0102       ;one-shot mode
SFXCntlB HEX   0112       ;(in stereo)
