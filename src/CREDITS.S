         lst   on
* Warping credits scroller v0.53
* (c) Garote '93
* Special thanx to Emily
         LST   OFF
         TR    ADR
         XC
         XC

         DUM   $F000      ; "InDirect" page in bank $02
ST       DS    2          ; Temporary stack storage
LetX     DS    2
LetY     DS    2
Loop     DS    2
StrLngth DS    2
OffSet   DS    2          ; Storage for line indent
Dend     DS    2
Flag     DS    2
Flag2    DS    2
Mode     DS    2
PozLey   DS    2
Mode2Cnt DS    2
Mode3Cnt DS    2
Mode3Sw  DS    2
         DEND

KeyChek  =     0
Modes    =     4          ; Number of available modes

ASLS     MAC
         lup   ]1
         asl
         --^
         EOM

LIT      MAC
         DW    16-]3*4
         DFB   ]2         ; SCB
         DFB   ]3
         INV   ]1
         EOM

BIG      MAC
         DW    16-]3*4
         DFB   ]2         ; SCB
         DFB   ]3         ; Length must be included due to
         HEX   ]1         ; assembler limitations
         EOM

EMP      MAC
         HEX   FFFF       ; Code for blank lines
         DFB   00         ; SCB to use
         DFB   ]1         ; Number of lines to remain empty
         EOM

Loader   =     $009000
ThisProg =     $020000
CharLoc  =     $024000
Char2Loc =     $028000

         ORG   ThisProg
         MX    %00

         clc
         xce
         rep   #$30
         lda   #$0045     ; Character set 1
         jsl   Loader
         lda   #$0046     ; Character set 2
         jsl   Loader
         sep   #$30
         lda   #$41
         stal  $e1c035
         rep   #$30
         pea   $0000
         plb
         plb
         ldx   #$0000
         lda   #$0000
]lp      sta   $0000,x
         inx              ; Blank out bank 00
         inx
         bne   ]lp
         lda   #$9900
         tcs
         pea   $0101
         plb
         plb
         lda   #$0000
]lp      sta   $2000,x
         inx              ; Blank out SHR screen
         inx
         cpx   #$8000
         bne   ]lp
         sep   #$20
         lda   #$c1
         stal  $e1c029
         rep   #$20
         ldx   #$01FE     ; Set palettes
]lp      ldal  CredPal1,x
         sta   $9e00,x
         dex
         dex
         bpl   ]lp
         pea   #>ThisProg
         plb
         plb
         lda   #$9800
         sta   Dend
         lda   #$0002
         sta   Flag
AgainMsg sta   Mode
         stz   Mode2Cnt
         stz   Mode3Cnt
         stz   Mode3Sw
         stz   Flag2
         stz   PozLey
         stz   LetY       ; Reset to top segment of char map
         stz   Loop

Again    sep   #$20       ; Next segment of letters
         ldx   LetY
         lda   Message+2,x ; Next SCB in list
         sta   Flag
         rep   #$20
         lda   Message,x  ; Next indent value in list
         cmp   #$FFFF
         beq   FaxPause
         cmp   #$FFFE     ; End of message?
         bne   NoEnder    ; Then loop it.
         stz   LetY
         lda   Mode
         inc
         inc
         cmp   #Modes*2   ; Done all modes?
         bne   AgainMsg   ; Then loop them.
         lda   #$0000
         bra   AgainMsg
FaxPause lda   Message+3,x
         and   #$00FF
         sta   PozLey
         lup   4
         inx
         --^
         stx   LetY       ; Increase over data, since it's used
         jmp   PozPrep
NoEnder  sta   OffSet
         lda   Message+3,x ; Length of string
         and   #$001F
         sta   StrLngth
         lup   4
         inx
         --^
         stx   LetY       ; Increase over data, since it's used
Again2   stz   LetX
BackMore lda   LetY       ; Index into message + index into line
         clc
         adc   LetX
         tax
         lda   Message,x
         and   #$00FF
         ASLS  4          ; A = Let x $10
         adc   Loop
         ASLS  3          ; A = Let x $80 + Loop x $08
         tax              ; And that's the storage location!!
         lda   Dend
         tcd
         lda   #$0040
         sec
         sbc   OffSet
         asl
         asl
         sta   Aheader+1
Aheader  brl   Aheader    ; Skip over portion of STZ-loop prep. accoriding
]a       =     $3E        ; to value of indent
         LUP   $20
         stz   ]a
         stz   $7E-]a
         stz   $80+]a
         stz   $FE-]a
]a       =     ]a-2
         --^
         lda   LetX
         ASLS  3          ; A = X x8
         adc   Dend       ; A = X x8 + Dend + OffSet
         adc   OffSet
         tcd              ; and that's the pei location!!
         lda   CharLoc,x
         sta   $00
         lda   CharLoc+2,x
         sta   $02        ; Segment of char 1
         lda   CharLoc+4,x
         sta   $04
         lda   CharLoc+6,x
         sta   $06
         lda   Char2Loc,x
         sta   $80
         lda   Char2Loc+2,x
         sta   $82        ; Segment of char 2
         lda   Char2Loc+4,x
         sta   $84
         lda   Char2Loc+6,x
         sta   $86
         inc   LetX
         lda   LetX
         cmp   StrLngth
         beq   *+5
         jmp   BackMore
         jmp   AheadMor

PozPrep  lda   Dend
         tcd
]a       =     $3E        ; Erase entire SCB for pause
         LUP   $20
         stz   ]a
         stz   $7E-]a
         stz   $80+]a
         stz   $FE-]a
]a       =     ]a-2
         --^

AheadMor pea   $0000
         plb
         plb

         ldx   #$FF38     ; Move scanlines in a tricky way
]lp      lda   $9dc9,x    ; so we don't need a compare
         sta   $9dc8,x
         inx
         inx
         bmi   ]lp

         pea   #>ThisProg
         plb
         plb
         lda   Flag
         stal  $019dc7

         ldx   Mode
         lda   MRetList,x
         sta   PeiFin+2   ; Run through the PEI displayer
         jmp   (ModeList,x)

ModeRet  rep   #$31
         tdc
         tcs
         lda   Dend
         adc   #$0100
         sta   Dend
         lda   PozLey
         beq   NoPozNow
         dec   PozLey
         bne   *+5
         jmp   Again
         jmp   PozPrep
NoPozNow inc   Loop
         lda   Loop
         cmp   #$0010
         bne   After
         stz   Loop
         lda   LetY
         clc
         adc   StrLngth
         sta   LetY
         DO    KeyChek
         sep   #$20
         lda   #$FF       ; (keycheck routine, install on option)
         stal  $e1c010
]lp      ldal  $e1c000
         bpl   ]lp
         jmp   Again      ; Move to next line
         ELSE
         jmp   Again
         FIN
         DO    KeyChek
After    sep   #$20
         lda   #$FF       ; (keycheck routine, install on option)
         stal  $e1c010
]lp      ldal  $e1c000
         bpl   ]lp
         jmp   Again2     ; Draw new portion of same line
         ELSE
After    jmp   Again2
         FIN

ModeList DA    Mode1,Mode2,Mode3,Mode4
MRetList DA    Mode1Fin,Mode2Fin,Mode3Fin,Mode4Fin

PeiFin   tcs
         jmp   Mode1Fin

Mode1    sep   #$20       ; Mapped scroll
         STAl  $e1C005
         STAl  $e1C005
         REP   #$30
         LDA   #$9CFF
         TCS
         lda   Dend
         TCD
         ldx   #$018E
PeiStr   tsc
         sec
         jmp   (JumpTbl,x)
Mode1Fin tdc
         sec
         sbc   #$0100
         tcd
         dex
         dex
         bpl   PeiStr
         SEP   #$20
         STAl  $e1C004
         STAl  $e1C004
         jmp   ModeRet

JumpTbl  DA    P1,P1,P1,P1,P1,P1,P1,P1
         DA    P1,P1,P1,P1,P1,P1,P2,P2
         DA    P2,P2,P3,P3,P4,P4,P5,P5
         DA    P6,P6,P7,P7,P8,P8,P9,P9
         DA    PA,PA,PB,PB,PC,PC,PB,PA
         DA    P9,P8,P7,P6,P5,P4,P3,P2
         DA    P1,P1,P1,P1,P1,P2,P3,P4
         DA    P5,P6,P7,P8,P9,PA,PB,PC
         DA    PD,PE,PF,PE,PD,PC,PB,PA
         DA    P9,P8,P7,P6,P5,P4,P3,P2
         DA    P1,P1,P1,P1,P1,P1,P1,P1
         DA    P1,P1,P1,P1,P2,P2,P2,P2
         DA    P3,P3,P3,P4,P4,P4,P5,P5
         DA    P6,P6,P7,P8,P9,PA,PA,PB
         DA    PB,PC,PC,PC,PD,PD,PD,PE
         DA    PE,PE,PE,PF,PF,PF,PF,PF
         DA    PF,PE,PE,PE,PE,PD,PD,PD
         DA    PC,PC,PC,PB,PB,PA,PA,P9
         DA    P8,P7,P6,P6,P7,P8,P9,PB
         DA    PC,PC,PC,PC,PB,PB,PB,PB
         DA    PA,PA,PA,PA,P9,P9,P9,P9
         DA    P8,P8,P8,P8,P7,P7,P7,P7
         DA    P6,P6,P6,P6,P5,P5,P5,P5
         DA    P4,P4,P4,P4,P3,P3,P3,P3
         DA    P2,P2,P2,P2,P1,P1,P1,P1

Mode2    sep   #$20       ; Scrunch-scroll
         STAl  $e1C005
         STAl  $e1C005
         REP   #$30
         LDA   #$9CFF
         TCS
         lda   Dend
         TCD
         ldx   Mode2Cnt
         ldy   #$00C7
BackHere  tsc
         sec
         jmp   (StrgtTbl,x)
Mode2Fin tdc
         sec
         sbc   #$0100
         tcd
         dey
         bpl   BackHere
         SEP   #$20
         STAl  $e1C004
         STAl  $e1C004
         inc   Mode2Cnt
         inc   Mode2Cnt
         lda   Mode2Cnt
         cmp   #56
         bne   Scooby
         stz   Mode2Cnt
Scooby   jmp   ModeRet

StrgtTbl DA    P1,P2,P3,P4,P5,P6,P7
         DA    P8,P9,PA,PB,PC,PD,PE
         DA    PF,PE,PD,PC,PB,PA,P9
         DA    P8,P7,P6,P5,P4,P3,P2

Mode3    REP   #$30       ; Heat-wave scroll
         lda   Dend
         TCD
         LDA   #$9CFF
         TCS
         lda   Mode3Cnt
         asl
         tax
         lda   WaveList,x
         sta   Mode3Mod+1
         sep   #$20
         STAl  $e1C005
         STAl  $e1C005
         rep   #$30
         ldx   #$002A     ; lda Mode3Sw, bne *+5, ldx #$0020
         ldy   #$00C7
Moby     tsc
         sec
         jmp   P1
Mode3Fin clc
Mode3Mod adc   Rave1,x
         tcs
         tdc
         sec
         sbc   #$0100
         tcd
         dex
         dex
         bpl   Extacy
         ldx   #$002A
Extacy   dey
         bpl   Moby
         SEP   #$20
         STAl  $e1C004
         STAl  $e1C004
         rep   #$30
         inc   Mode3Cnt
         lda   Mode3Cnt
         cmp   #$0014     ; was 20
         bcc   Shaggy
         stz   Mode3Cnt   ; lda Mode3Sw, eor #$0001, sta Mode3Sw
Shaggy   jmp   ModeRet

WaveList DA    Rave1,Rave2,Rave3,Rave4,Rave5
         DA    Rave6,Rave5,Rave4,Rave3,Rave2
         DA    Rave1,Wave2,Wave3,Wave4,Wave5
         DA    Wave6,Wave5,Wave4,Wave3,Wave2

Rave1    DA    $0000,$0000,$0000,$0000,$0000,$0,$0000,$0000,$0000,$0000,$0000
         DA    $0000,$0000,$0000,$0000,$0000,$0,$0000,$0000,$0000,$0000,$0000
Rave2    DA    $0000,$0001,$0000,$0000,$0000,$0,$0000,$0000,$0000,$FFFF,$0000
Wave2    DA    $0000,$FFFF,$0000,$0000,$0000,$0,$0000,$0000,$0000,$0001,$0000
         DA    $0000,$0001,$0000,$0000,$0000,$0,$0000,$0000,$0000,$FFFF,$0000
Rave3    DA    $0001,$0000,$0001,$0000,$0000,$0,$0000,$0000,$FFFF,$0000,$FFFF
Wave3    DA    $FFFF,$0000,$FFFF,$0000,$0000,$0,$0000,$0000,$0001,$0000,$0001
         DA    $0001,$0000,$0001,$0000,$0000,$0,$0000,$0000,$FFFF,$0000,$FFFF
Rave4    DA    $0001,$0001,$0000,$0001,$0000,$0,$0000,$FFFF,$0000,$FFFF,$FFFF
Wave4    DA    $FFFF,$FFFF,$0000,$FFFF,$0000,$0,$0000,$0001,$0000,$0001,$0001
         DA    $0001,$0001,$0000,$0001,$0000,$0,$0000,$FFFF,$0000,$FFFF,$FFFF
Rave5    DA    $0002,$0001,$0000,$0001,$0000,$0,$0000,$FFFF,$0000,$FFFF,$FFFE
Wave5    DA    $FFFE,$FFFF,$0000,$FFFF,$0000,$0,$0000,$0001,$0000,$0001,$0002
         DA    $0002,$0001,$0000,$0001,$0000,$0,$0000,$FFFF,$0000,$FFFF,$FFFE
Rave6    DA    $0002,$0001,$0001,$0001,$0000,$0,$0000,$FFFF,$FFFF,$FFFF,$FFFE
Wave6    DA    $FFFE,$FFFF,$FFFF,$FFFF,$0000,$0,$0000,$0001,$0001,$0001,$0002
         DA    $0002,$0001,$0001,$0001,$0000,$0,$0000,$FFFF,$FFFF,$FFFF,$FFFE



Mode4    sep   #$20       ; Mirror scroll
         STAl  $e1C005
         STAl  $e1C005
         REP   #$30
         LDA   #$9CFF
         TCS
         lda   Dend
         TCD
         ldx   #$018E
Busoms   tsc
         clc
         adc   MirorTbl,x
         sec
         jmp   (JumpTbl,x)
Mode4Fin tdc
         sec
         sbc   #$0100
         tcd
         dex
         dex
         bpl   Busoms
         SEP   #$20
         STAl  $e1C004
         STAl  $e1C004
         jmp   ModeRet

MirorTbl HEX   A0000000E001C0FE200380FD600440FC
         HEX   A00500FBE006C0F9200880F8600940F7
         HEX   A00A00F6E00BC0F4200D80F3600E40F2
         HEX   A00F00F1E010C0EF201280EE601340ED
         HEX   A01400ECE015C0EA201780E9601840E8
         HEX   A01900E7E01AC0E5201C80E4601D40E3
         HEX   A01E00E2E01FC0E0202180DF602240DE
         HEX   A02300DDE024C0DB202680DA602740D9
         HEX   A02800D8E029C0D6202B80D5602C40D4
         HEX   A02D00D3E02EC0D1203080D0603140CF
         HEX   A03200CEE033C0CC203580CB603640CA
         HEX   A03700C9E038C0C7203A80C6603B40C5
         HEX   A03C00C4E03DC0C2203F80C1604040C0
         HEX   A04100BFE042C0BD204480BC604540BB
         HEX   A04600BAE047C0B8204980B7604A40B6
         HEX   A04B00B5E04CC0B3204E80B2604F40B1
         HEX   A05000B0E051C0AE205380AD605440AC
         HEX   A05500ABE056C0A9205880A8605940A7
         HEX   A05A00A6E05BC0A4205D80A3605E40A2
         HEX   A05F00A1E060C09F2062809E6063409D
         HEX   A064009CE065C09A2067809960684098
         HEX   A0690097E06AC095206C8094606D4093
         HEX   A06E0092E06FC0902071808F6072408E
         HEX   A073008DE074C08B2076808A60774089
         HEX   A0780088E079C086207B8085607C4084

Message  BIG   4A4B,242B,2425,2425,2021,2663;0;12 ; Merryo
         BIG   5A5B,3A3B,5657,5657,5E5F,362C;0;12
         EMP   8
         BIG   4243,2425,2663,4849,4849,6667;0;12 ; Trolls
         BIG   7879,5657,362C,5859,5859,7677;0;12
         EMP   32
         LIT   'MASTER';7;6
         LIT   'PROGRAMMER';7;10
         BIG   2667,2223,2425,2663,4243,242B;5;12 ; Garote
         BIG   363f,3233,5657,362C,7879,3A3B;5;12
         EMP   16
         LIT   'MUZAK';4;5
         LIT   'PROGRAMMER';4;10
         BIG   2223,2627,242B;6;6 ; Ace
         BIG   3233,3637,3A3B;6;6
         EMP   16
         LIT   'MUZAK@BY';7;8
         BIG   5C5D,2663,2667;5;6 ; Zog
         BIG   6C6D,362C,363F;5;6
         LIT   'AND';7;3
         BIG   2667,2223,2425,2663,4243,242B;5;12 ; Garote
         BIG   363f,3233,5657,362C,7879,3A3B;5;12
         EMP   16
         LIT   'GRAFIX';2;6
         LIT   'PROGRAMMER';2;10
         BIG   2667,2223,2425,2663,4243,242B;5;12 ; Garote
         BIG   363f,3233,5657,362C,7879,3A3B;5;12
         EMP   16
         LIT   'GRAFIX@BY';6;9
         BIG   2223,2627,242B;6;6 ; Ace
         BIG   3233,3637,3A3B;6;6
         LIT   'AND';6;3
         BIG   2667,2223,2425,2663,4243,242B;5;12 ; Garote
         BIG   363f,3233,5657,362C,7879,3A3B;5;12
         EMP   16
         LIT   'SOUND';2;5
         LIT   'PROGRAMMER';2;10
         BIG   2223,2627,242B;6;6 ; Ace
         BIG   3233,3637,3A3B;6;6
         EMP   16
         LIT   'SPRITE';2;6
         LIT   'PROGRAMMER';2;10
         BIG   2667,2223,2425,2663,4243,242B;5;12 ; Garote
         BIG   363f,3233,5657,362C,7879,3A3B;5;12
         EMP   16
         LIT   'SPRITE';2;6
         LIT   'FORMAT@BY';2;9
         BIG   2223,2627,242B;6;6 ; Ace
         BIG   3233,3637,3A3B;6;6
         EMP   16
         LIT   'THE@ORIGINAL';7;12
         LIT   'CONCEPT@OF@THIS';8;15
         LIT   'GAME@WAS@PART';9;13
         LIT   'OF@A@YEAR@LONG';10;14
         LIT   'ROUND@ROBIN';11;11
         LIT   'STORY@THAT@WAS';12;14
         LIT   'WRITTEN@AND';13;11
         LIT   'RESIDES@ON@THE';14;14
         BIG   2663,4A4B,4C4D,4243,0000,2425,2425,6667;0;16 ; Omni BBS
         BIG   362C,5A5B,5A5B,5253,0000,3435,3435,7677;0;16
         LIT   'IN@SANTA@CRUZ';1;13
         DW    16
         DFB   0
         DFB   12
         HEX   60,0F,6F,00,60,72,6F,00,60,6F,6F,62 ; 408 438 4882
         EMP   32
         LIT   'INSPIRATION@FROM';3;16
         LIT   '[@@[';6;4
         LIT   '[@SHONEN@KNIFE@[';5;16
         LIT   '[[[@DEEE@LITE[[[';4;16
         LIT   '[[[@MINISTRY@[[[';5;16
         LIT   '[@MONTY@PYTHON@[';4;16
         LIT   '[WARREN@FARREL@[';5;16
         LIT   '[@[@MR@@BILL@[@[';4;16
         LIT   '[[@MUSSORGSKY@[[';5;16
         LIT   '[@[@DELERUIM@[@[';4;16
         LIT   '[MY@LITTLE@PONY[';5;16
         LIT   '[@NEGATIVLAND@@[';4;16
         LIT   '[PEIRS@@ANTHONY[';5;16
         LIT   '[[@PINK@FLOYD@[[';4;16
         LIT   '[[STEPHEN@KING[[';5;16
         LIT   '[@TCHAIKOVSKY@[[';4;16
         LIT   '[@[@[@MOBY@[@[@[';5;16
         LIT   '[@SKINNY@PUPPY@[';4;16
         LIT   '[[@DAVID@BOWIE@[';5;16
         LIT   '[@[@LAIBACH@@[@[';4;16
         LIT   '[[@@INTERMIX@@[[';5;16
         LIT   '[[@STOKOWSKI@[[[';4;16
         LIT   '[@HELLO@KITTY@@[';5;16
         LIT   '[[@@CHESTER@@@[[';4;16
         LIT   '[[[@@MOZART@@[[[';5;16
         EMP   32
         LIT   'DEFINITELY@NO';3;13
         LIT   'INSPIRATION@FROM';3;16
         LIT   '[@@[';6;4
         LIT   '[@GUNS@N@ROSES@[';4;16
         LIT   '[[@@MEATLOAF@@[[';5;16
         LIT   '[[@[@BARNEY@[@[[';4;16
         LIT   '[[@@@MADONNA@@[[';5;16
         EMP   64
         EMP   64
         EMP   64
         EMP   16
         HEX   FEFF

         MX    %00
P1       sbc   #$0010
         tcs
]A       =     $7E
         LUP   64
         PEI   ]A
]A       =     ]A-2
         --^
         sbc   #$0090
         jmp   PeiFin

P2       sbc   #$0010
         tcs
         PEI   $FE
         PEI   $FC
         PEI   $FA
         PEI   $F8
         PEI   $F6
         PEI   $F4
         PEI   $F2
         PEI   $F0
         PEI   $EE
         PEI   $EC
         PEI   $EA
         PEI   $E8
         PEI   $E6        ; 21 block
         PEI   $E4
         PEI   $E2
         PEI   $E0
         PEI   $DE
         PEI   $DC
         PEI   $DA
         PEI   $D8
         PEI   $D6
         PEI   $54        ; Skip ahead 1
         PEI   $52
         PEI   $50
         PEI   $4E
         PEI   $4C
         PEI   $4A
         PEI   $48        ; 22 block
         PEI   $46
         PEI   $44
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         PEI   $3A
         PEI   $38
         PEI   $36
         PEI   $34
         PEI   $32
         PEI   $30
         PEI   $2E
         PEI   $2C
         PEI   $2A
         sbc   #$0055     ; back 1
         tcs
         PEI   $A8
         PEI   $A6
         PEI   $A4
         PEI   $A2
         PEI   $A0
         PEI   $9E
         PEI   $9C
         PEI   $9A
         PEI   $98
         PEI   $96        ; 21 block
         PEI   $94
         PEI   $92
         PEI   $90
         PEI   $8E
         PEI   $8C
         PEI   $8A
         PEI   $88
         PEI   $86
         PEI   $84
         PEI   $82
         PEI   $80
         sbc   #$003b
         jmp   PeiFin

P3       sbc   #$0011     ; Ahead 1, dots in: 2
         tcs
         PEI   $7E
         PEI   $7C
         PEI   $7A
         PEI   $78
         PEI   $76
         PEI   $74
         PEI   $72        ; 13 block
         PEI   $70
         PEI   $6E
         PEI   $6C
         PEI   $6A
         PEI   $68
         PEI   $66
         sbc   #$0019     ; Shift back 1
         tcs              ; left: 3 (1)
         PEI   $E4        ; inverted
         PEI   $E2
         PEI   $E0
         PEI   $DE        ; 13 block
         PEI   $DC
         PEI   $DA
         PEI   $D8
         PEI   $D6
         PEI   $D4
         PEI   $D2
         PEI   $D0
         PEI   $CE
         PEI   $CC
         PEI   $4A        ; Shift back 1, left: 2 (1)
         PEI   $48
         PEI   $46        ; inverted
         PEI   $44        ; 12 block
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         PEI   $3A
         PEI   $38
         PEI   $36
         PEI   $34
         sbc   #$0031     ; Back 1
         tcs              ; left: 1 (0)
         PEI   $B2        ; inverted
         PEI   $B0
         PEI   $AE
         PEI   $AC
         PEI   $AA
         PEI   $A8        ; 13 block
         PEI   $A6
         PEI   $A4
         PEI   $A2
         PEI   $A0
         PEI   $9E
         PEI   $9C
         PEI   $9A
         PEI   $18        ; inverted,
         PEI   $16        ; shifted back one dot.
         PEI   $14        ; left: 0 (0)
         PEI   $12
         PEI   $10
         PEI   $0E        ; 13 block
         PEI   $0C
         PEI   $0A
         PEI   $08
         PEI   $06
         PEI   $04
         PEI   $02
         PEI   $00
         sbc   #$0045     ; Ahead one, dots in: 4
         jmp   PeiFin

P4       sbc   #$0011     ; Ahead 2 (+2)
         tcs
         PEI   $FE        ; Ahead 1 (+3)
         PEI   $FC
         PEI   $FA
         PEI   $F8
         PEI   $F6        ; 9 block
         PEI   $F4
         PEI   $F2
         PEI   $F0
         PEI   $EE
         PEI   $6C        ; Back 1 (+2)
         PEI   $6A        ; inverted
         PEI   $68
         PEI   $66        ; 9 block
         PEI   $64
         PEI   $62
         PEI   $60
         PEI   $5E
         PEI   $5C
         sbc   #$0023
         tcs              ; Back 2,
         PEI   $DA        ; up 1 (+1)
         PEI   $D8
         PEI   $D6        ; inverted
         PEI   $D4
         PEI   $D2        ; 9 block
         PEI   $D0
         PEI   $CE
         PEI   $CC
         PEI   $CA
         PEI   $48        ; Back 1 (0)
         PEI   $46
         PEI   $44
         PEI   $42
         PEI   $40
         PEI   $3E        ; 10 block
         PEI   $3C
         PEI   $3A
         PEI   $38
         PEI   $36
         sbc   #$0025
         tcs              ; Back 2,
         PEI   $B4        ; up 1 (-1)
         PEI   $B2
         PEI   $B0        ; inverted
         PEI   $AE
         PEI   $AC
         PEI   $AA        ; 9 block
         PEI   $A8
         PEI   $A6
         PEI   $A4
         PEI   $22        ; Back 1 (-2)
         PEI   $20        ; inverted
         PEI   $1E
         PEI   $1C
         PEI   $1A        ; 9 block
         PEI   $18
         PEI   $16
         PEI   $14
         PEI   $12
         sbc   #$0023
         tcs              ; Back 2,
         PEI   $90        ; ahead 1 (-3)
         PEI   $8E
         PEI   $8C        ; inverted
         PEI   $8A        ; 9 block
         PEI   $88
         PEI   $86
         PEI   $84
         PEI   $82
         PEI   $80
         sbc   #$0024     ; Ahead 4 (+1)
         jmp   PeiFin

P5       sbc   #$0012     ; In 2 (+4)
         tcs
         PEI   $7E
         PEI   $7C
         PEI   $7A
         PEI   $78        ; 7 block
         PEI   $76
         PEI   $74
         PEI   $72
         sbc   #$000d
         tcs              ; Back 2,
         PEI   $F0        ; Ahead 1 (+3)
         PEI   $EE
         PEI   $EC
         PEI   $EA        ; 7 block
         PEI   $E8
         PEI   $E6
         PEI   $E4
         PEI   $62        ; Back 1 (+2)
         PEI   $60
         PEI   $5E
         PEI   $5C        ; 7 block
         PEI   $5A
         PEI   $58
         PEI   $56
         tsc
         inc
         tcs              ; Back 2,
         PEI   $D4        ; Ahead 1 (+1)
         PEI   $D2
         PEI   $D0
         PEI   $CE        ; 7 block
         PEI   $CC
         PEI   $CA
         PEI   $C8
         PEI   $46        ; Ahead 1 (0)
         PEI   $44
         PEI   $42
         PEI   $40
         PEI   $3E        ; 8 block
         PEI   $3C
         PEI   $3A
         PEI   $38
         tsc
         inc
         tcs              ; Back 2,
         PEI   $B6        ; Ahead 1 (-1)
         PEI   $B4
         PEI   $B2
         PEI   $B0        ; 7 block
         PEI   $AE
         PEI   $AC
         PEI   $AA
         PEI   $28        ; Ahead 1 (-2)
         PEI   $26
         PEI   $24
         PEI   $22        ; 7 block
         PEI   $20
         PEI   $1E
         PEI   $1C
         tsc
         inc
         tcs              ; Back 2,
         PEI   $9A        ; Ahead 1 (-3)
         PEI   $98
         PEI   $96
         PEI   $94        ; 7 block
         PEI   $92
         PEI   $90
         PEI   $8E
         PEI   $0C        ; Ahead 1 (-4)
         PEI   $0A
         PEI   $08
         PEI   $06        ; 7 block
         PEI   $04
         PEI   $02
         PEI   $00
         tsc
         sec
         sbc   #$0012     ; Back 4 (0)
         jmp   PeiFin

P6       sbc   #$0012     ; Back 4 (-4)
         tcs
         PEI   $FE        ; Back 1 (-5)
         PEI   $FC
         PEI   $FA
         PEI   $F8
         PEI   $F6
         PEI   $74        ; I think you've
         PEI   $72        ; got the idea now.
         PEI   $70        ; No more comments.
         PEI   $6E
         PEI   $6C
         PEI   $6A
         sbc   #$0015
         tcs
         PEI   $E8
         PEI   $E6
         PEI   $E4
         PEI   $E2
         PEI   $E0
         PEI   $DE
         PEI   $5C
         PEI   $5A
         PEI   $58
         PEI   $56
         PEI   $54
         PEI   $52
         sbc   #$0017
         tcs
         PEI   $D0
         PEI   $CE
         PEI   $CC
         PEI   $CA
         PEI   $C8
         PEI   $C6
         PEI   $44
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         PEI   $3A
         sbc   #$0017
         tcs
         PEI   $B8
         PEI   $B6
         PEI   $B4
         PEI   $B2
         PEI   $B0
         PEI   $AE
         PEI   $2C
         PEI   $2A
         PEI   $28
         PEI   $26
         PEI   $24
         PEI   $22
         sbc   #$0017
         tcs
         PEI   $A0
         PEI   $9E
         PEI   $9C
         PEI   $9A
         PEI   $98
         PEI   $96
         PEI   $14
         PEI   $12
         PEI   $10
         PEI   $0E
         PEI   $0C
         PEI   $0A
         sbc   #$0017
         tcs
         PEI   $88
         PEI   $86
         PEI   $84
         PEI   $82
         PEI   $80
         sbc   #$001d
         jmp   PeiFin

P7       sbc   #$0013     ; Ahead 6 (+6)
         tcs
         PEI   $7E
         PEI   $7C
         PEI   $7A
         PEI   $78
         PEI   $76
         sbc   #$0009
         tcs
         PEI   $F4
         PEI   $F2
         PEI   $F0
         PEI   $EE
         PEI   $EC
         PEI   $6A
         PEI   $68
         PEI   $66
         PEI   $64
         PEI   $62
         sbc   #$0013
         tcs
         PEI   $E0
         PEI   $DE
         PEI   $DC
         PEI   $DA
         PEI   $D8
         PEI   $56
         PEI   $54
         PEI   $52
         PEI   $50
         PEI   $4E
         sbc   #$0013
         tcs
         PEI   $CC
         PEI   $CA
         PEI   $C8
         PEI   $C6
         PEI   $C4
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         sbc   #$0011
         tcs
         PEI   $BA
         PEI   $B8
         PEI   $B6
         PEI   $B4
         PEI   $B2
         PEI   $30
         PEI   $2E
         PEI   $2C
         PEI   $2A
         PEI   $28
         sbc   #$0013
         tcs
         PEI   $A6
         PEI   $A4
         PEI   $A2
         PEI   $A0
         PEI   $9E
         PEI   $1C
         PEI   $1A
         PEI   $18
         PEI   $16
         PEI   $14
         sbc   #$0013
         tcs
         PEI   $92
         PEI   $90
         PEI   $8E
         PEI   $8C
         PEI   $8A
         PEI   $08
         PEI   $06
         PEI   $04
         PEI   $02
         PEI   $00
         sbc   #$0027     ; Ahead 6 (0)
         jmp   PeiFin

P8       sbc   #$0013
         tcs
         PEI   $FE
         PEI   $FC
         PEI   $FA
         PEI   $F8
         PEI   $F6
         PEI   $74
         PEI   $72
         PEI   $70
         PEI   $6E
         sbc   #$0011
         tcs
         PEI   $EC
         PEI   $EA
         PEI   $E8
         PEI   $E6
         PEI   $64
         PEI   $62
         PEI   $60
         PEI   $5E
         sbc   #$000f
         tcs
         PEI   $DC
         PEI   $DA
         PEI   $D8
         PEI   $D6
         PEI   $D4
         PEI   $52
         PEI   $50
         PEI   $4E
         PEI   $4C
         sbc   #$0011
         tcs
         PEI   $CA
         PEI   $C8
         PEI   $C6
         PEI   $C4
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         sbc   #$000f
         tcs
         PEI   $BA
         PEI   $B8
         PEI   $B6
         PEI   $B4
         PEI   $32
         PEI   $30
         PEI   $2E
         PEI   $2C
         sbc   #$000f
         tcs
         PEI   $AA
         PEI   $A8
         PEI   $A6
         PEI   $A4
         PEI   $A2
         PEI   $20
         PEI   $1E
         PEI   $1C
         PEI   $1A
         sbc   #$0011
         tcs
         PEI   $98
         PEI   $96
         PEI   $94
         PEI   $92
         PEI   $10
         PEI   $0E
         PEI   $0C
         PEI   $0A
         sbc   #$000f
         tcs
         PEI   $88
         PEI   $86
         PEI   $84
         PEI   $82
         PEI   $80
         sbc   #$001e
         jmp   PeiFin

P9       sbc   #$0014
         tcs
         PEI   $7E
         PEI   $7C
         PEI   $7A
         PEI   $78
         sbc   #$0007
         tcs
         PEI   $F6
         PEI   $F4
         PEI   $F2
         PEI   $F0
         PEI   $6E
         PEI   $6C
         PEI   $6A
         sbc   #$000d
         tcs
         PEI   $E8
         PEI   $E6
         PEI   $E4
         PEI   $E2
         PEI   $60
         PEI   $5E
         PEI   $5C
         PEI   $5A
         sbc   #$000f
         tcs
         PEI   $D8
         PEI   $D6
         PEI   $D4
         PEI   $D2
         PEI   $50
         PEI   $4E
         PEI   $4C
         sbc   #$000d
         tcs
         PEI   $CA
         PEI   $C8
         PEI   $C6
         PEI   $C4
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         sbc   #$000f
         tcs
         PEI   $BA
         PEI   $B8
         PEI   $B6
         PEI   $B4
         PEI   $32
         PEI   $30
         PEI   $2E
         sbc   #$000d
         tcs
         PEI   $AC
         PEI   $AA
         PEI   $A8
         PEI   $A6
         PEI   $24
         PEI   $22
         PEI   $20
         PEI   $1E
         sbc   #$000f
         tcs
         PEI   $9C
         PEI   $9A
         PEI   $98
         PEI   $96
         PEI   $14
         PEI   $12
         PEI   $10
         sbc   #$000d
         tcs
         PEI   $8E
         PEI   $8C
         PEI   $8A
         PEI   $88
         PEI   $06
         PEI   $04
         PEI   $02
         PEI   $00
         sbc   #$0024
         jmp   PeiFin

PA       sbc   #$0014      ; 64/19=3, 3x19=57, 64-57=7, 19-7=12
         tcs              ; 12 groups of 3, 7 groups of 4 = 18 gaps
         PEI   $FE        ; 18 gaps = 9 bytes in,
         PEI   $FC        ; 4.5 bytes on either side.
         PEI   $FA
         PEI   $F8        ; so we subtract four bytes
         PEI   $76        ; and start with the $80-$FF section
         PEI   $74
         PEI   $72        ; get it? B)
         sbc   #$000d
         tcs
         PEI   $F0
         PEI   $EE
         PEI   $EC
         PEI   $6A
         PEI   $68
         PEI   $66
         PEI   $64
         sbc   #$000d
         tcs
         PEI   $E2
         PEI   $E0
         PEI   $DE
         PEI   $5C
         PEI   $5A
         PEI   $58
         sbc   #$000b
         tcs
         PEI   $D6
         PEI   $D4
         PEI   $D2
         PEI   $D0
         PEI   $4E
         PEI   $4C
         PEI   $4A
         sbc   #$000d
         tcs
         PEI   $C8
         PEI   $C6
         PEI   $C4
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         sbc   #$000d
         tcs
         PEI   $BA
         PEI   $B8
         PEI   $B6
         PEI   $34
         PEI   $32
         PEI   $30
         sbc   #$000b
         tcs
         PEI   $AE
         PEI   $AC
         PEI   $AA
         PEI   $A8
         PEI   $26
         PEI   $24
         PEI   $22
         sbc   #$000d
         tcs
         PEI   $A0
         PEI   $9E
         PEI   $9C
         PEI   $1A
         PEI   $18
         PEI   $16
         PEI   $14
         sbc   #$000d
         tcs
         PEI   $92
         PEI   $90
         PEI   $8E
         PEI   $0C
         PEI   $0A
         PEI   $08
         sbc   #$000b
         tcs
         PEI   $86
         PEI   $84
         PEI   $82
         PEI   $80
         sbc   #$001D
         jmp   PeiFin

PB       sbc   #$0015
         tcs
         PEI   $7E
         PEI   $7C
         PEI   $7A
         sbc   #$0005
         tcs
         PEI   $F8
         PEI   $F6
         PEI   $F4
         PEI   $72
         PEI   $70
         PEI   $6E
         sbc   #$000b
         tcs
         PEI   $EC
         PEI   $EA
         PEI   $E8
         PEI   $66
         PEI   $64
         PEI   $62
         sbc   #$000b
         tcs
         PEI   $E0
         PEI   $DE
         PEI   $DC
         PEI   $5A
         PEI   $58
         PEI   $56
         sbc   #$000b
         tcs
         PEI   $D4
         PEI   $D2
         PEI   $D0
         PEI   $4E
         PEI   $4C
         PEI   $4A
         sbc   #$000b
         tcs
         PEI   $C8
         PEI   $C6
         PEI   $C4
         PEI   $42
         PEI   $40
         PEI   $3E
         PEI   $3C
         sbc   #$000d
         tcs
         PEI   $BA
         PEI   $B8
         PEI   $B6
         PEI   $34
         PEI   $32
         PEI   $30
         sbc   #$000b
         tcs
         PEI   $AE
         PEI   $AC
         PEI   $AA
         PEI   $28
         PEI   $26
         PEI   $24
         sbc   #$000b
         tcs
         PEI   $A2
         PEI   $A0
         PEI   $9E
         PEI   $1C
         PEI   $1A
         PEI   $18
         sbc   #$000b
         tcs
         PEI   $96
         PEI   $94
         PEI   $92
         PEI   $10
         PEI   $0E
         PEI   $0C
         sbc   #$000b
         tcs
         PEI   $8A
         PEI   $88
         PEI   $86
         PEI   $04
         PEI   $02
         PEI   $00
         sbc   #$0021
         jmp   PeiFin

PC       sbc   #$0015      ; 18 out of 23 will be 3
         tcs              ; 5 out of 23 will be 2
         PEI   $FE
         PEI   $FC
         PEI   $FA
         PEI   $78
         PEI   $76
         PEI   $74
         sbc   #$000b
         tcs
         PEI   $F2
         PEI   $F0
         PEI   $EE
         PEI   $6C
         PEI   $6A
         sbc   #$0009
         tcs
         PEI   $E8
         PEI   $E6
         PEI   $E4
         PEI   $62
         PEI   $60
         PEI   $5E
         sbc   #$000b
         tcs
         PEI   $DC
         PEI   $DA
         PEI   $D8
         PEI   $56
         PEI   $54
         sbc   #$0009
         tcs
         PEI   $D2
         PEI   $D0
         PEI   $CE
         PEI   $4C
         PEI   $4A
         PEI   $48
         sbc   #$000b
         tcs
         PEI   $C6
         PEI   $C4
         PEI   $C2
         PEI   $40
         PEI   $3E
         sbc   #$0009
         tcs
         PEI   $BC
         PEI   $BA
         PEI   $B8
         PEI   $36
         PEI   $34
         PEI   $32
         sbc   #$000b
         tcs
         PEI   $B0
         PEI   $AE
         PEI   $AC
         PEI   $2A
         PEI   $28
         sbc   #$0009
         tcs
         PEI   $A6
         PEI   $A4
         PEI   $A2
         PEI   $20
         PEI   $1E
         PEI   $1C
         sbc   #$000b
         tcs
         PEI   $9A
         PEI   $98
         PEI   $96
         PEI   $14
         PEI   $12
         sbc   #$0009
         tcs
         PEI   $90
         PEI   $8E
         PEI   $8C
         PEI   $0A
         PEI   $08
         PEI   $06
         sbc   #$000b
         tcs
         PEI   $84
         PEI   $82
         PEI   $80
         sbc   #$001C
         jmp   PeiFin

PD       sbc   #$0016      ; 64/25=2.56, 2x25=50, 64-50=14,
         tcs              ; 14 of 25 to be 3, 11 of 25 to be 2
         PEI   $7e         ; 14/11=1.27, interleave - 1:1
         PEI   $7c        ; 14-11=3, closest match= borders of 2
         PEI   $7A        ; Understand?
         sbc   #$0005
         tcs
         PEI   $F8
         PEI   $F6
         PEI   $F4
         PEI   $72
         PEI   $70
         sbc   #$0009
         tcs
         PEI   $EE
         PEI   $EC
         PEI   $EA
         PEI   $68
         PEI   $66
         sbc   #$0009
         tcs
         PEI   $E4
         PEI   $E2
         PEI   $E0
         PEI   $5E
         PEI   $5C
         sbc   #$0009
         tcs
         PEI   $DA
         PEI   $D8
         PEI   $D6
         PEI   $54
         PEI   $52
         sbc   #$0009
         tcs
         PEI   $D0
         PEI   $CE
         PEI   $CC
         PEI   $4A
         PEI   $48
         sbc   #$0009
         tcs
         PEI   $C6
         PEI   $C4
         PEI   $C2
         PEI   $40
         PEI   $3E
         sbc   #$0009
         tcs
         PEI   $BC
         PEI   $BA
         PEI   $B8
         PEI   $36
         PEI   $34
         sbc   #$0009
         tcs
         PEI   $B2
         PEI   $B0
         PEI   $AE
         PEI   $2C
         PEI   $2A
         sbc   #$0009
         tcs
         PEI   $A8
         PEI   $A6
         PEI   $A4
         PEI   $22
         PEI   $20
         sbc   #$0009
         tcs
         PEI   $9E
         PEI   $9C
         PEI   $9A
         PEI   $18
         PEI   $16
         sbc   #$0009
         tcs
         PEI   $94
         PEI   $92
         PEI   $90
         PEI   $0E
         PEI   $0C
         sbc   #$0009
         tcs
         PEI   $8A
         PEI   $88
         PEI   $86
         PEI   $04
         PEI   $02
         PEI   $00
         sbc   #$0022
         jmp   PeiFin

PE       sbc   #$0016      ; 64/27=2.37, 2x27=54, 64-54=10
         tcs              ; 17 of 27 will be 2, 10 of 27 will be 3
         PEI   $fe         ; 17/10=1.7, interleave - A,A,B
         PEI   $Fc        ; 10:15= borders of 2
         PEI   $7A
         PEI   $78
         sbc   #$0007
         tcs
         PEI   $F6
         PEI   $F4
         PEI   $72
         PEI   $70
         PEI   $6E
         sbc   #$0009
         tcs
         PEI   $EC
         PEI   $EA
         PEI   $68
         PEI   $66
         sbc   #$0007
         tcs
         PEI   $E4
         PEI   $E2
         PEI   $E0
         PEI   $5E
         PEI   $5C
         sbc   #$0009
         tcs
         PEI   $DA
         PEI   $D8
         PEI   $56
         PEI   $54
         PEI   $52
         sbc   #$0009
         tcs
         PEI   $D0
         PEI   $CE
         PEI   $4C
         PEI   $4A
         sbc   #$0007
         tcs
         PEI   $C8
         PEI   $C6
         PEI   $C4
         PEI   $42
         PEI   $40
         sbc   #$0009
         tcs
         PEI   $BE
         PEI   $BC
         PEI   $3A
         PEI   $38
         PEI   $36
         sbc   #$0009
         tcs
         PEI   $B4
         PEI   $B2
         PEI   $30
         PEI   $2E
         sbc   #$0007
         tcs
         PEI   $AC
         PEI   $AA
         PEI   $A8
         PEI   $26
         PEI   $24
         sbc   #$0009
         tcs
         PEI   $A2
         PEI   $A0
         PEI   $1E
         PEI   $1C
         PEI   $1A
         sbc   #$0009
         tcs
         PEI   $98
         PEI   $96
         PEI   $14
         PEI   $12
         sbc   #$0007
         tcs
         PEI   $90
         PEI   $8E
         PEI   $8C
         PEI   $0A
         PEI   $08
         sbc   #$0009
         tcs
         PEI   $86
         PEI   $84
         PEI   $02
         PEI   $00
         sbc   #$001F
         jmp   PeiFin

PF       sbc   #$0017      ; 64/29=2.2, 2x29=58, 64-58=6
         tcs              ; 6 of 29 will be 3, 23 of 29 will be 2
         PEI   $7e         ; 23/6=3.8, interleave - A:B:B:B
         PEI   $7c        ; 24:6 - 1 chopped
         sbc   #$0003
         tcs
         PEI   $FA
         PEI   $F8
         PEI   $76
         PEI   $74
         sbc   #$0007
         tcs
         PEI   $F2
         PEI   $F0
         PEI   $6E
         PEI   $6C
         PEI   $6A
         sbc   #$0009
         tcs
         PEI   $E8
         PEI   $E6
         PEI   $64
         PEI   $62
         sbc   #$0007
         tcs
         PEI   $E0
         PEI   $DE
         PEI   $5C
         PEI   $5A
         PEI   $58
         sbc   #$0009
         tcs
         PEI   $D6
         PEI   $D4
         PEI   $52
         PEI   $50
         sbc   #$0007
         tcs
         PEI   $CE
         PEI   $CC
         PEI   $4A
         PEI   $48
         PEI   $46
         sbc   #$0009
         tcs
         PEI   $C4
         PEI   $C2
         PEI   $40
         PEI   $3E
         sbc   #$0007
         tcs
         PEI   $BC
         PEI   $BA
         PEI   $38
         PEI   $36
         PEI   $34
         sbc   #$0009
         tcs
         PEI   $B2
         PEI   $B0
         PEI   $2E
         PEI   $2C
         sbc   #$0007
         tcs
         PEI   $AA
         PEI   $A8
         PEI   $26
         PEI   $24
         PEI   $22
         sbc   #$0009
         tcs
         PEI   $A0
         PEI   $9E
         PEI   $1C
         PEI   $1A
         sbc   #$0007
         tcs
         PEI   $98
         PEI   $96
         PEI   $14
         PEI   $12
         PEI   $10
         sbc   #$0009
         tcs
         PEI   $8E
         PEI   $8C
         PEI   $0A
         PEI   $08
         sbc   #$0007
         tcs
         PEI   $86
         PEI   $84
         PEI   $02
         PEI   $00
         sbc   #$001F
         jmp   PeiFin

PG       sbc   #$001F
         tcs
         PEI   $FE        ; 64/63=1, 1x63=63, 64-63=1
         PEI   $7C        ; 1 of 63 will be 2, 62 of 63 will be 1
         sbc   #$0003
         tcs
         PEI   $FA        ; 63/1=63 interleave: (31,1,31)
         PEI   $78        ; 63 divisions= 64 in, 32 per side
         sbc   #$0003
         tcs
         PEI   $F6        ; =16 bytes, no in-shift
         PEI   $74
         sbc   #$0003
         tcs
         PEI   $F2
         PEI   $70
         sbc   #$0003
         tcs
         PEI   $EE
         PEI   $6C
         sbc   #$0003
         tcs
         PEI   $EA
         PEI   $68
         sbc   #$0003
         tcs
         PEI   $E6
         PEI   $64
         sbc   #$0003
         tcs
         PEI   $E2
         PEI   $60
         sbc   #$0003
         tcs
         PEI   $DE
         PEI   $5C
         sbc   #$0003
         tcs
         PEI   $DA
         PEI   $58
         sbc   #$0003
         tcs
         PEI   $D6
         PEI   $54
         sbc   #$0003
         tcs
         PEI   $D2
         PEI   $50
         sbc   #$0003
         tcs
         PEI   $CE
         PEI   $4C
         sbc   #$0003
         tcs
         PEI   $CA
         PEI   $48
         sbc   #$0003
         tcs
         PEI   $C6
         PEI   $44
         sbc   #$0003
         tcs
         PEI   $C2
         PEI   $40
         sbc   #$0003
         tcs
         PEI   $BE
         PEI   $BC
         PEI   $3A
         sbc   #$0005
         tcs
         PEI   $B8
         PEI   $36
         sbc   #$0003
         tcs
         PEI   $B4
         PEI   $32
         sbc   #$0003
         tcs
         PEI   $B0
         PEI   $2E
         sbc   #$0003
         tcs
         PEI   $AC
         PEI   $2A
         sbc   #$0003
         tcs
         PEI   $A8
         PEI   $26
         sbc   #$0003
         tcs
         PEI   $A4
         PEI   $22
         sbc   #$0003
         tcs
         PEI   $A0
         PEI   $1E
         sbc   #$0003
         tcs
         PEI   $9C
         PEI   $1A
         sbc   #$0003
         tcs
         PEI   $98
         PEI   $16
         sbc   #$0003
         tcs
         PEI   $94
         PEI   $12
         sbc   #$0003
         tcs
         PEI   $90
         PEI   $0E
         sbc   #$0003
         tcs
         PEI   $8C
         PEI   $0A
         sbc   #$0003
         tcs
         PEI   $88
         PEI   $06
         sbc   #$0003
         tcs
         PEI   $84
         PEI   $02
         sbc   #$0003
         tcs
         PEI   $80
         sbc   #$0022
         jmp   PeiFin

CredPal1 HEX   00000000F000F003F005F007F009F00B
         HEX   F00DF00FD00FB00F900F700F500F300F
         HEX   000000007F0F7F0E7F0D7F0C7F0B7F0A
         HEX   7F097F087F077F067F057F047F037F02
         HEX   00000000FF0FEE0EDD0DCC0CBB0BAA0A
         HEX   99099808970796069505940493039202
         HEX   00000000E000C000A60089005C003E00
         HEX   0F000E010C030A0508070609030B000D
         HEX   00000000000A000C000D000E000F000E
         HEX   000D000C000B000A0009000800070006
         HEX   000000008008A00AC00CE00EF00FE00E
         HEX   D00DC00CB00BA00A9009800870076006
         HEX   000000008000A000C000E000F000E000
         HEX   D000C000B000A0009000800070006000
         HEX   0000000038033A033C033E033F033E03
         HEX   3D033C033B033A033903380337033603
         HEX   00000000CC0C0000DD0D0000EE0E0000
         HEX   FF0F0000EE0E0000DD0D0000CC0C0000
         HEX   000B000F6F006F006F006F006F006F00
         HEX   6F006F006F006F006F006F006F006F00
         HEX   000000005F0F5F0E5F0D5F0C5F0B5F0A
         HEX   5F095F085F075F065F055F045F035F02
         HEX   000000004F0F4F0E4F0D4F0C4F0B4F0A
         HEX   4F094F084F074F064F054F044F034F02
         HEX   000000003F0F3F0E3F0D3F0C3F0B3F0A
         HEX   3F093F083F073F063F053F043F033F02
         HEX   000000002F0F2F0E2F0D2F0C2F0B2F0A
         HEX   2F092F082F072F062F052F042F032F02
         HEX   000000001F0F1F0E1F0D1F0C1F0B1F0A
         HEX   1F091F081F071F061F051F041F031F02
         HEX   000000000F0F0F0E0F0D0F0C0F0B0F0A
         HEX   0F090F080F070F060F050F040F030F02
