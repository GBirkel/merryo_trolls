         lst   on
*
* Debug window v1.0 (c) Garote 94
         lst   off

DebugWin phy
         phx
         pha
         php
         sep   #$20
         lda   #$00
         phb
         pha
         plb
         lda   #$41
         sta   $c029
         lda   #$a0
         sta   $c022
         rep   #$30
         ldx   #$03F6
]lp      ldal  DebugDat,x
         stal  $e00400,x
         dex
         dex
         bpl   ]lp
         rep   #$30
         lda   #118
]lp      stal  Temps
         ldal  Temps
         tax
         lda   $00,x
         stal  Temps+2
         sep   #$30
         and   #$0F
         tax
         ldal  HexNuts,x
         xba
         ldal  Temps+2
         and   #$F0
         LSRS  4
         tax
         ldal  HexNuts,x
         rep   #$20
         stal  Temps+4
         sep   #$20
         ldal  Temps+3
         and   #$0F
         tax
         ldal  HexNuts,x
         xba
         ldal  Temps+3
         and   #$F0
         LSRS  4
         tax
         ldal  HexNuts,x
         rep   #$30
         stal  Temps+2
         ldal  Temps
         tax
         ldal  SpamTabs,x
         tax
         ldal  Temps+2
         sta   $400,x
         ldal  Temps+4
         sta   $402,x
         ldal  Temps
         dec
         dec
         bpl   ]lp
         jsr   WaitKey
         sep   #$20
         lda   #$C1
         sta   $c029
         stz   $c022
         plb
         plp
         pla
         plx
         ply
         rts

Temps    DA    0,0,0

HexNuts  INV   "0123456789ABCDEF"

SpamTabs DA    $205,$285,$305,$385
         DA    $02D,$0aD,$12D,$1aD
         DA    $22D,$2aD,$32D,$3aD
         DA    $055,$0d5,$155,$1d5
         DA    $255,$2d5,$355,$3d5
         DA    $20F,$28F,$30F,$38F
         DA    $037,$0b7,$137,$1b7
         DA    $237,$2b7,$337,$3b7
         DA    $05F,$0dF,$15F,$1dF
         DA    $25F,$2dF,$35F,$3dF
         DA    $219,$299,$319,$399
         DA    $041,$0c1,$141,$1c1
         DA    $241,$2c1,$341,$3c1
         DA    $069,$0e9,$169,$1e9
         DA    $269,$2e9,$369,$3e9

DebugDat ASC   " Super? Merryo Trolls Debug Screen v1.0 " ; 0
         ASC   "Tmp3:0000 JHlv:0000 SCnt:0000  00000000 " ; 8
         ASC   "GXBk:0000 SprH:0000 SizT:0000           " ; 16
         DS    8
         ASC   "                                        " ; 1
         ASC   "Tmp4:0000 JHdr:0000 SAnt:0000  00000000 " ; 9
         ASC   "GXf :0000 SprM:0000 SizS:0000           " ; 17
         DS    8
         ASC   "If anything's fucked up, it's your fault" ; 2
         ASC   "DCnt:0000 JB01:0000 ErCn:0000 Time1:    " ; 10
         ASC   "GYBk:0000 SprE:0000 ExSt:0000           " ; 18
         DS    8
         ASC   "                                        " ; 3
         ASC   "WXEB:0000 B0Dn:0000 SpCn:0000  000000   " ; 11
         ASC   "GYSl:0000 SprR:0000 Pal :0000           " ; 19
         DS    8
         ASC   "ST  :0000 GYVR:0000 FlgT:0000 Score1:   " ; 4
         ASC   "WXBI:0000 WPEA:0000 IMsp:0000 Time2:    " ; 12
         ASC   "GVX :0000 SprL:0000 Pal2:0000           " ; 20
         DS    8
         ASC   "MapI:0000 JMPS:0000 FlgF:0000  00000000 " ; 5
         ASC   "WXBF:0000 WGui:0000 DMsp:0000  00000000 " ; 13
         ASC   "GVY :0000 SprB:0000                     " ; 21
         DS    8
         ASC   "Tmp :0000 JRdX:0000 Itm :0000  00000000 " ; 6
         ASC   "WXTF:0000 Lupe:0000 OVRt:0000           " ; 14
         ASC   "GSld:0000 SpLA:0000                     " ; 22
         DS    8
         ASC   "Tmp2:0000 JRdY:0000 Itm2:0000 Score2:   " ; 7
         ASC   "GXSF:0000 Acnt:0000 DWNt:0000           " ; 15
         ASC   "GXVR:0000 SpLB:0000                     " ; 23
