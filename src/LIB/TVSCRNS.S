         DUM   ]ZPPlay
TVcntr   DA    2
]ZPPlay  =     *
         DEND

DrawScrn php
         rep   #$30
         phb
         pea   #>ForegPeaField
         plb
         plb
         ldal  PeaJumpPtr
         tay
         lda   TVcntr
         and   #$0003
         bne   DrawSkip
         lda   TVcntr
         and   #$007C
         ASLS  2
         tax
         jsr   (Scrns+14,x)
         LUP   7
         iny
         iny
         iny
         dex
         dex
         jsr   (Scrns+14,x)
         --^
DrawSkip inc   TVcntr
         lda   TVcntr
         cmp   #$0080
         bne   :Br1
         stz   TVcntr
:Br1     plb
         plp
         rts
         MX    %00

Scrns    DA    Scrn0,Scrn1,Scrn1,Scrn1,Scrn1,Scrn1,Scrn1,Scrn7
         DA    Scrn8,Scrn9,Scrn10,Scrn11,Scrn12,Scrn13,Scrn14,Scrn15
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn24,Scrn25,Scrn26,Scrn27,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn36,Scrn37,Scrn38,Scrn16
         DA    Scrn16,Scrn41,Scrn42,Scrn43,Scrn44,Scrn16,Scrn16,Scrn16
         DA    Scrn16,Scrn49,Scrn50,Scrn51,Scrn52,Scrn53,Scrn54,Scrn55
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn64,Scrn65,Scrn65,Scrn65,Scrn65,Scrn65,Scrn65,Scrn71
         DA    Scrn72,Scrn73,Scrn74,Scrn75,Scrn76,Scrn77,Scrn78,Scrn79
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn88,Scrn89,Scrn90,Scrn91,Scrn92,Scrn93,Scrn94,Scrn95
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn104,Scrn105,Scrn106,Scrn107,Scrn108,Scrn109,Scrn110,Scrn111
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn16,Scrn16,Scrn122,Scrn123,Scrn123,Scrn125,Scrn126,Scrn16
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn136,Scrn137,Scrn137,Scrn137,Scrn137,Scrn141,Scrn142,Scrn143
         DA    Scrn144,Scrn145,Scrn146,Scrn147,Scrn148,Scrn149,Scrn150,Scrn151
         DA    Scrn152,Scrn153,Scrn154,Scrn155,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn160,Scrn161,Scrn162,Scrn163,Scrn164,Scrn165,Scrn16,Scrn16
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn16,Scrn177,Scrn178,Scrn179,Scrn180,Scrn180,Scrn182,Scrn183
         DA    Scrn184,Scrn185,Scrn186,Scrn187,Scrn188,Scrn189,Scrn190,Scrn191
         DA    Scrn16,Scrn16,Scrn194,Scrn195,Scrn196,Scrn197,Scrn198,Scrn199
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn208,Scrn209,Scrn210,Scrn211,Scrn212,Scrn213,Scrn214,Scrn215
         DA    Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16,Scrn16
         DA    Scrn224,Scrn225,Scrn226,Scrn227,Scrn228,Scrn229,Scrn230,Scrn231
         DA    Scrn232,Scrn233,Scrn233,Scrn233,Scrn233,Scrn233,Scrn233,Scrn239
         DA    Scrn224,Scrn225,Scrn226,Scrn227,Scrn228,Scrn229,Scrn230,Scrn231
         DA    Scrn232,Scrn233,Scrn233,Scrn233,Scrn233,Scrn233,Scrn233,Scrn239

Scrn0    LDA   #21777
         STA:  4561,y
         STA:  1,y
         LDA   #21781
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn1    LDA   #21845
         STA:  4561,y
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         STA:  1,y
         RTS

Scrn7    LDA   #4437
         STA:  4561,y
         STA:  1,y
         LDA   #20821
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn8    LDA   #62741
         STA:  4321,y
         STA:  4081,y
         STA:  3601,y
         STA:  3361,y
         LDA   #65301
         STA:  3841,y
         RTS

Scrn9    LDA   #65525
         STA:  4321,y
         STA:  3841,y
         STA:  3361,y
         LDA   #62965
         STA:  4081,y
         STA:  3601,y
         RTS

Scrn10   LDA   #24415
         STA:  4321,y
         STA:  4081,y
         LDA   #63319
         STA:  3841,y
         LDA   #62805
         STA:  3601,y
         STA:  3361,y
         RTS

Scrn11   LDA   #24405
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         RTS

Scrn12   LDA   #24415
         STA:  4321,y
         STA:  4081,y
         STA:  3601,y
         STA:  3361,y
         LDA   #24567
         STA:  3841,y
         RTS

Scrn13   LDA   #63327
         STA:  4321,y
         STA:  3361,y
         LDA   #24415
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         RTS

Scrn14   LDA   #65367
         STA:  4321,y
         LDA   #21855
         STA:  4081,y
         LDA   #63319
         STA:  3841,y
         LDA   #24405
         STA:  3601,y
         LDA   #63327
         STA:  3361,y
         RTS

Scrn15   LDA   #20831
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3361,y
         RTS

Scrn16   RTS

Scrn24   LDA   #24085
         STA:  2881,y
         RTS

Scrn25   LDA   #24302
         STA:  2881,y
         LDA   #24293
         STA:  2641,y
         STA:  2401,y
         RTS

Scrn26   LDA   #24302
         STA:  2881,y
         LDA   #24045
         STA:  2641,y
         LDA   #21854
         STA:  2401,y
         RTS

Scrn27   LDA   #21854
         STA:  2881,y
         LDA   #21997
         STA:  2641,y
         LDA   #21989
         STA:  2401,y
         RTS

Scrn36   LDA   #61022
         STA:  2881,y
         LDA   #58709
         STA:  2641,y
         STA:  2401,y
         RTS

Scrn37   LDA   #24158
         STA:  2881,y
         STA:  2401,y
         LDA   #61022
         STA:  2641,y
         RTS

Scrn38   LDA   #61022
         STA:  2881,y
         STA:  2401,y
         LDA   #58718
         STA:  2641,y
         RTS

Scrn41   LDA   #58709
         STA:  1921,y
         STA:  1441,y
         LDA   #61013
         STA:  1681,y
         RTS

Scrn42   LDA   #24158
         STA:  1921,y
         STA:  1681,y
         LDA   #24302
         STA:  1441,y
         RTS

Scrn43   LDA   #24302
         STA:  1921,y
         LDA   #24293
         STA:  1681,y
         LDA   #24046
         STA:  1441,y
         RTS

Scrn44   LDA   #24149
         STA:  1921,y
         LDA   #24158
         STA:  1681,y
         LDA   #60901
         STA:  1441,y
         RTS

Scrn49   LDA   #22869
         STA:  961,y
         STA:  241,y
         LDA   #23125
         STA:  721,y
         STA:  481,y
         RTS

Scrn50   LDA   #23210
         STA:  961,y
         STA:  241,y
         LDA   #23125
         STA:  721,y
         STA:  481,y
         RTS

Scrn51   LDA   #23210
         STA:  961,y
         STA:  241,y
         LDA   #23205
         STA:  721,y
         LDA   #23125
         STA:  481,y
         RTS

Scrn52   LDA   #23209
         STA:  961,y
         LDA   #23130
         STA:  721,y
         STA:  241,y
         LDA   #23208
         STA:  481,y
         RTS

Scrn53   LDA   #22954
         STA:  961,y
         LDA   #23205
         STA:  721,y
         LDA   #23125
         STA:  481,y
         LDA   #23210
         STA:  241,y
         RTS

Scrn54   LDA   #23209
         STA:  961,y
         LDA   #23130
         STA:  721,y
         STA:  241,y
         LDA   #23210
         STA:  481,y
         RTS

Scrn55   LDA   #20901
         STA:  241,y
         RTS

Scrn64   LDA   #47889
         STA:  4561,y
         STA:  1,y
         LDA   #47899
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn65   LDA   #48059
         STA:  4561,y
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         STA:  1,y
         RTS

Scrn71   LDA   #4539
         STA:  4561,y
         STA:  1,y
         LDA   #45499
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn72   LDA   #48923
         STA:  4081,y
         STA:  3601,y
         LDA   #64283
         STA:  3841,y
         LDA   #65307
         STA:  3121,y
         RTS

Scrn73   LDA   #49151
         STA:  4081,y
         LDA   #49083
         STA:  3841,y
         LDA   #49147
         STA:  3601,y
         LDA   #49087
         STA:  3361,y
         LDA   #48123
         STA:  3121,y
         RTS

Scrn74   LDA   #49083
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         LDA   #65467
         STA:  3361,y
         LDA   #49151
         STA:  3121,y
         RTS

Scrn75   LDA   #49083
         STA:  4081,y
         LDA   #64443
         STA:  3841,y
         LDA   #48063
         STA:  3601,y
         STA:  3361,y
         LDA   #65467
         STA:  3121,y
         LDA   #65471
         STA:  2401,y
         RTS

Scrn76   LDA   #48127
         STA:  4081,y
         LDA   #48063
         STA:  3841,y
         STA:  3121,y
         STA:  2881,y
         LDA   #49087
         STA:  3601,y
         LDA   #49151
         STA:  3361,y
         LDA   #48123
         STA:  2641,y
         RTS

Scrn77   LDA   #65471
         STA:  4081,y
         LDA   #49147
         STA:  3841,y
         LDA   #49083
         STA:  3601,y
         LDA   #65467
         STA:  3361,y
         LDA   #49151
         STA:  3121,y
         RTS

Scrn78   LDA   #48063
         STA:  4081,y
         STA:  3361,y
         STA:  3121,y
         LDA   #49087
         STA:  3841,y
         LDA   #64447
         STA:  3601,y
         RTS

Scrn79   LDA   #45567
         STA:  4081,y
         RTS

Scrn88   LDA   #48923
         STA:  2161,y
         STA:  1921,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         LDA   #65307
         STA:  1681,y
         RTS

Scrn89   LDA   #48123
         STA:  2401,y
         LDA   #49147
         STA:  1681,y
         LDA   #64443
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn90   LDA   #49083
         STA:  1681,y
         STA:  481,y
         LDA   #64507
         STA:  1441,y
         LDA   #64443
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         RTS

Scrn91   LDA   #49083
         STA:  1681,y
         STA:  481,y
         LDA   #64507
         STA:  1441,y
         STA:  1201,y
         STA:  721,y
         LDA   #49147
         STA:  961,y
         RTS

Scrn92   LDA   #49083
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1201,y
         STA:  961,y
         LDA   #65467
         STA:  1681,y
         LDA   #49147
         STA:  1441,y
         STA:  721,y
         RTS

Scrn93   LDA   #49147
         STA:  1681,y
         STA:  481,y
         LDA   #64443
         STA:  1441,y
         STA:  1201,y
         STA:  721,y
         LDA   #65467
         STA:  961,y
         RTS

Scrn94   LDA   #49083
         STA:  1681,y
         STA:  481,y
         LDA   #64507
         STA:  1441,y
         STA:  1201,y
         STA:  721,y
         LDA   #64443
         STA:  961,y
         RTS

Scrn95   LDA   #45563
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn104  LDA   #65307
         STA:  4321,y
         LDA   #63003
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         LDA   #47899
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn105  LDA   #49003
         STA:  4321,y
         LDA   #63222
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  2881,y
         STA:  2641,y
         LDA   #63083
         STA:  3121,y
         LDA   #49142
         STA:  2401,y
         LDA   #48059
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn106  LDA   #49003
         STA:  4321,y
         STA:  2401,y
         LDA   #63222
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         LDA   #48059
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn107  LDA   #49003
         STA:  4321,y
         STA:  2401,y
         LDA   #63222
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  2881,y
         STA:  2641,y
         LDA   #49142
         STA:  3361,y
         LDA   #48118
         STA:  3121,y
         LDA   #48059
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn108  LDA   #65387
         STA:  4321,y
         LDA   #49142
         STA:  4081,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         LDA   #49083
         STA:  3841,y
         STA:  3601,y
         LDA   #49003
         STA:  3361,y
         STA:  2401,y
         LDA   #48059
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         RTS

Scrn109  LDA   #65526
         STA:  4321,y
         LDA   #63083
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  2881,y
         STA:  2641,y
         LDA   #65387
         STA:  3121,y
         STA:  2401,y
         LDA   #48059
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn110  LDA   #65526
         STA:  4321,y
         LDA   #63163
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  2881,y
         STA:  2641,y
         LDA   #65387
         STA:  3121,y
         LDA   #63222
         STA:  2401,y
         LDA   #48059
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn111  LDA   #45419
         STA:  4321,y
         STA:  3121,y
         LDA   #45558
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         LDA   #45499
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn122  LDA   #62975
         STA:  1921,y
         LDA   #48117
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         LDA   #23551
         STA:  961,y
         RTS

Scrn123  LDA   #62975
         STA:  1921,y
         STA:  241,y
         LDA   #48117
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  721,y
         STA:  481,y
         LDA   #23551
         STA:  961,y
         RTS

Scrn125  LDA   #62975
         STA:  1921,y
         LDA   #23487
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn126  LDA   #48117
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  241,y
         RTS

Scrn136  LDA   #34833
         STA:  4561,y
         STA:  1,y
         LDA   #34840
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn137  LDA   #34952
         STA:  4561,y
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         STA:  1,y
         RTS

Scrn141  LDA   #34952
         STA:  4561,y
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         STA:  1,y
         LDA   #18563
         STA:  2881,y
         LDA   #17283
         STA:  2641,y
         LDA   #17544
         STA:  2401,y
         LDA   #33928
         STA:  2161,y
         RTS

Scrn142  LDA   #34952
         STA:  4561,y
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         STA:  1,y
         LDA   #14388
         STA:  3121,y
         STA:  1921,y
         LDA   #18500
         STA:  2881,y
         LDA   #8996
         STA:  2641,y
         LDA   #13364
         STA:  2401,y
         LDA   #17476
         STA:  2161,y
         RTS

Scrn143  LDA   #4488
         STA:  4561,y
         STA:  1,y
         LDA   #33160
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         LDA   #33091
         STA:  2881,y
         STA:  2641,y
         LDA   #33096
         STA:  2401,y
         RTS

Scrn144  LDA   #61208
         STA:  4321,y
         STA:  3841,y
         LDA   #63512
         STA:  4081,y
         RTS

Scrn145  LDA   #65528
         STA:  4321,y
         LDA   #65416
         STA:  4081,y
         LDA   #63736
         STA:  3841,y
         RTS

Scrn146  LDA   #63736
         STA:  4321,y
         LDA   #63640
         STA:  4081,y
         LDA   #61432
         STA:  3841,y
         RTS

Scrn147  LDA   #63736
         STA:  4321,y
         LDA   #65528
         STA:  4081,y
         LDA   #63720
         STA:  3841,y
         RTS

Scrn148  LDA   #36495
         STA:  4321,y
         LDA   #36767
         STA:  4081,y
         LDA   #36607
         STA:  3841,y
         RTS

Scrn149  LDA   #36863
         STA:  4321,y
         STA:  3841,y
         LDA   #36744
         STA:  4081,y
         RTS

Scrn150  LDA   #36751
         STA:  4321,y
         LDA   #36607
         STA:  4081,y
         LDA   #34959
         STA:  3841,y
         RTS

Scrn151  LDA   #33167
         STA:  4321,y
         LDA   #33278
         STA:  4081,y
         LDA   #33272
         STA:  3841,y
         RTS

Scrn152  LDA   #18456
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         LDA   #17432
         STA:  2641,y
         RTS

Scrn153  LDA   #17026
         STA:  3361,y
         LDA   #33924
         STA:  3121,y
         STA:  2641,y
         LDA   #17540
         STA:  2881,y
         RTS

Scrn154  LDA   #17028
         STA:  3361,y
         STA:  2881,y
         LDA   #33924
         STA:  3121,y
         STA:  2641,y
         RTS

Scrn155  LDA   #17028
         STA:  3361,y
         STA:  2641,y
         LDA   #33924
         STA:  3121,y
         STA:  2881,y
         RTS

Scrn160  LDA   #13080
         STA:  2161,y
         STA:  1681,y
         LDA   #14360
         STA:  1921,y
         STA:  1441,y
         RTS

Scrn161  LDA   #14376
         STA:  2161,y
         STA:  1681,y
         LDA   #14392
         STA:  1921,y
         LDA   #9096
         STA:  1441,y
         RTS

Scrn162  LDA   #9016
         STA:  2161,y
         LDA   #14392
         STA:  1921,y
         LDA   #13112
         STA:  1681,y
         LDA   #14376
         STA:  1441,y
         RTS

Scrn163  LDA   #14466
         STA:  2161,y
         LDA   #34947
         STA:  1921,y
         STA:  1441,y
         LDA   #14467
         STA:  1681,y
         RTS

Scrn164  LDA   #14467
         STA:  2161,y
         STA:  1681,y
         LDA   #34867
         STA:  1921,y
         LDA   #33587
         STA:  1441,y
         RTS

Scrn165  LDA   #33667
         STA:  1441,y
         RTS

Scrn177  LDA   #36232
         STA:  721,y
         STA:  481,y
         RTS

Scrn178  LDA   #56973
         STA:  961,y
         LDA   #65503
         STA:  721,y
         LDA   #57053
         STA:  481,y
         LDA   #56797
         STA:  241,y
         LDA   #56717
         STA:  1,y
         RTS

Scrn179  LDA   #56797
         STA:  1201,y
         STA:  241,y
         STA:  1,y
         LDA   #65519
         STA:  961,y
         STA:  481,y
         LDA   #65535
         STA:  721,y
         RTS

Scrn180  LDA   #56797
         STA:  1201,y
         STA:  241,y
         STA:  1,y
         LDA   #65535
         STA:  961,y
         STA:  721,y
         STA:  481,y
         RTS

Scrn182  LDA   #35032
         STA:  1201,y
         LDA   #56814
         STA:  961,y
         STA:  481,y
         LDA   #65535
         STA:  721,y
         LDA   #56797
         STA:  241,y
         STA:  1,y
         RTS

Scrn183  LDA   #33245
         STA:  721,y
         STA:  481,y
         LDA   #33240
         STA:  241,y
         RTS

Scrn184  LDA   #63512
         STA:  4321,y
         STA:  3841,y
         LDA   #34840
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  1681,y
         STA:  1441,y
         LDA   #13336
         STA:  2401,y
         STA:  2161,y
         LDA   #33816
         STA:  1921,y
         RTS

Scrn185  LDA   #36857
         STA:  4321,y
         LDA   #40959
         STA:  4081,y
         LDA   #65528
         STA:  3841,y
         LDA   #34952
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         LDA   #17283
         STA:  2641,y
         STA:  1441,y
         LDA   #17540
         STA:  2401,y
         LDA   #16946
         STA:  2161,y
         LDA   #17219
         STA:  1921,y
         LDA   #17476
         STA:  1681,y
         RTS

Scrn186  LDA   #34952
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3361,y
         STA:  2641,y
         STA:  1441,y
         LDA   #33672
         STA:  3121,y
         STA:  2881,y
         LDA   #14468
         STA:  2401,y
         LDA   #14388
         STA:  2161,y
         LDA   #34884
         STA:  1921,y
         LDA   #34888
         STA:  1681,y
         RTS

Scrn187  LDA   #34952
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         LDA   #13448
         STA:  3361,y
         STA:  2161,y
         LDA   #17480
         STA:  3121,y
         LDA   #9283
         STA:  2881,y
         LDA   #13380
         STA:  2641,y
         LDA   #17540
         STA:  2401,y
         RTS

Scrn188  LDA   #34952
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         LDA   #34872
         STA:  3361,y
         STA:  2161,y
         LDA   #17224
         STA:  3121,y
         LDA   #17187
         STA:  2881,y
         LDA   #18484
         STA:  2641,y
         LDA   #34884
         STA:  2401,y
         RTS

Scrn189  LDA   #34952
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  1441,y
         RTS

Scrn190  LDA   #34952
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         RTS

Scrn191  LDA   #33160
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         RTS

Scrn194  LDA   #36744
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         RTS

Scrn195  LDA   #63640
         STA:  4321,y
         LDA   #63743
         STA:  4081,y
         LDA   #63624
         STA:  3841,y
         RTS

Scrn196  LDA   #63736
         STA:  4321,y
         STA:  4081,y
         LDA   #65528
         STA:  3841,y
         RTS

Scrn197  LDA   #63624
         STA:  4321,y
         LDA   #65416
         STA:  4081,y
         LDA   #63736
         STA:  3841,y
         RTS

Scrn198  LDA   #63736
         STA:  4321,y
         LDA   #63640
         STA:  4081,y
         LDA   #35064
         STA:  3841,y
         LDA   #63624
         STA:  3601,y
         RTS

Scrn199  LDA   #33272
         STA:  4321,y
         STA:  4081,y
         STA:  3601,y
         RTS

Scrn208  LDA   #34840
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         RTS

Scrn209  LDA   #34952
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         RTS

Scrn210  LDA   #34952
         STA:  3121,y
         STA:  2881,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         LDA   #18563
         STA:  1201,y
         LDA   #17283
         STA:  961,y
         LDA   #17631
         STA:  721,y
         LDA   #57309
         STA:  481,y
         RTS

Scrn211  LDA   #34952
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         LDA   #13108
         STA:  1441,y
         LDA   #17220
         STA:  1201,y
         LDA   #8996
         STA:  961,y
         LDA   #13364
         STA:  721,y
         LDA   #17476
         STA:  481,y
         RTS

Scrn212  LDA   #34952
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         LDA   #13448
         STA:  1681,y
         LDA   #17480
         STA:  1441,y
         LDA   #13379
         STA:  1201,y
         STA:  961,y
         LDA   #17476
         STA:  721,y
         LDA   #13364
         STA:  481,y
         RTS

Scrn213  LDA   #34952
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         LDA   #34872
         STA:  1681,y
         LDA   #17219
         STA:  1441,y
         STA:  721,y
         LDA   #17444
         STA:  1201,y
         LDA   #16946
         STA:  961,y
         LDA   #17476
         STA:  481,y
         RTS

Scrn214  LDA   #34952
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         LDA   #14548
         STA:  1201,y
         LDA   #15668
         STA:  961,y
         LDA   #65348
         STA:  721,y
         LDA   #56654
         STA:  481,y
         RTS

Scrn215  LDA   #33160
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         RTS

Scrn224  LDA   #56593
         STA:  4561,y
         STA:  1,y
         LDA   #30493
         STA:  4321,y
         LDA   #30237
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         LDA   #26141
         STA:  2641,y
         LDA   #56605
         STA:  2401,y
         LDA   #43549
         STA:  2161,y
         LDA   #43293
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         LDA   #38941
         STA:  241,y
         RTS

Scrn225  LDA   #56797
         STA:  4561,y
         STA:  2401,y
         STA:  2161,y
         STA:  1,y
         LDA   #30583
         STA:  4321,y
         LDA   #26214
         STA:  4081,y
         STA:  3361,y
         STA:  2641,y
         LDA   #21845
         STA:  3841,y
         STA:  3121,y
         LDA   #30567
         STA:  3601,y
         STA:  2881,y
         LDA   #56733
         STA:  1921,y
         LDA   #56729
         STA:  1681,y
         LDA   #40345
         STA:  1441,y
         LDA   #39305
         STA:  1201,y
         LDA   #39309
         STA:  961,y
         LDA   #55693
         STA:  721,y
         LDA   #56717
         STA:  481,y
         STA:  241,y
         RTS

Scrn226  LDA   #56797
         STA:  4561,y
         STA:  2401,y
         STA:  1,y
         LDA   #56694
         STA:  4321,y
         LDA   #23910
         STA:  4081,y
         STA:  2881,y
         LDA   #23926
         STA:  3841,y
         STA:  3121,y
         LDA   #56677
         STA:  3601,y
         STA:  2641,y
         LDA   #56678
         STA:  3361,y
         LDA   #40362
         STA:  2161,y
         LDA   #36265
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         LDA   #36249
         STA:  961,y
         STA:  721,y
         STA:  481,y
         LDA   #36312
         STA:  241,y
         RTS

Scrn227  LDA   #56797
         STA:  4561,y
         STA:  2401,y
         STA:  1,y
         LDA   #28023
         STA:  4321,y
         LDA   #23926
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         LDA   #26470
         STA:  2881,y
         LDA   #21974
         STA:  2641,y
         LDA   #43738
         STA:  2161,y
         LDA   #39338
         STA:  1921,y
         LDA   #39081
         STA:  1681,y
         LDA   #36265
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         LDA   #39593
         STA:  721,y
         LDA   #39306
         STA:  481,y
         LDA   #35032
         STA:  241,y
         RTS

Scrn228  LDA   #56797
         STA:  4561,y
         STA:  2401,y
         STA:  1,y
         LDA   #30423
         STA:  4321,y
         LDA   #26071
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         LDA   #25974
         STA:  2881,y
         LDA   #23893
         STA:  2641,y
         LDA   #36266
         STA:  2161,y
         LDA   #43161
         STA:  1921,y
         LDA   #39049
         STA:  1681,y
         LDA   #39130
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         LDA   #39081
         STA:  721,y
         LDA   #34969
         STA:  481,y
         LDA   #36232
         STA:  241,y
         RTS

Scrn229  LDA   #56797
         STA:  4561,y
         STA:  2401,y
         STA:  1,y
         LDA   #30423
         STA:  4321,y
         LDA   #26071
         STA:  4081,y
         STA:  3841,y
         LDA   #26327
         STA:  3601,y
         LDA   #26333
         STA:  3361,y
         LDA   #55261
         STA:  3121,y
         STA:  2881,y
         LDA   #55005
         STA:  2641,y
         LDA   #43482
         STA:  2161,y
         LDA   #39130
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         LDA   #39386
         STA:  721,y
         STA:  481,y
         LDA   #39129
         STA:  241,y
         RTS

Scrn230  LDA   #56797
         STA:  4561,y
         STA:  2401,y
         STA:  1,y
         LDA   #30685
         STA:  4321,y
         LDA   #30429
         STA:  4081,y
         STA:  3841,y
         LDA   #26231
         STA:  3601,y
         LDA   #25958
         STA:  3361,y
         LDA   #23910
         STA:  3121,y
         STA:  2881,y
         LDA   #23893
         STA:  2641,y
         LDA   #43741
         STA:  2161,y
         LDA   #43485
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         LDA   #43437
         STA:  961,y
         LDA   #43417
         STA:  721,y
         LDA   #39305
         STA:  481,y
         LDA   #39389
         STA:  241,y
         RTS

Scrn231  LDA   #4573
         STA:  4561,y
         STA:  1,y
         LDA   #53613
         STA:  4321,y
         LDA   #53597
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         LDA   #53725
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         LDA   #53661
         STA:  2161,y
         LDA   #53645
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn232  LDA   #56593
         STA:  4561,y
         STA:  1,y
         LDA   #56605
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS

Scrn233  LDA   #56797
         STA:  4561,y
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         STA:  1,y
         RTS

Scrn239  LDA   #4573
         STA:  4561,y
         STA:  1,y
         LDA   #53725
         STA:  4321,y
         STA:  4081,y
         STA:  3841,y
         STA:  3601,y
         STA:  3361,y
         STA:  3121,y
         STA:  2881,y
         STA:  2641,y
         STA:  2401,y
         STA:  2161,y
         STA:  1921,y
         STA:  1681,y
         STA:  1441,y
         STA:  1201,y
         STA:  961,y
         STA:  721,y
         STA:  481,y
         STA:  241,y
         RTS
