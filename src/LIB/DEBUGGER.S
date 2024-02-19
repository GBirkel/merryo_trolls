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

DebugDat ASC   " Super? Merryo Trolls Debug Screen v1.0 "
         ASC   "FifT:0000 Xaxs:0000 ErAc:0000  00000000 "
         ASC   "GSF :0000 Ahed:0000 SizT:0000           "
         DS    8
         ASC   "                                        "
         ASC   "MIdx:0000 JoyZ:0000 SCnt:0000  00000000 "
         ASC   "PXB :0000 Alrm:0000 SizS:0000           "
         DS    8
         ASC   "If anything's fucked up, it's your fault"
         ASC   "Tmp :0000 Jcnt:0000 ErCn:0000 Time1:    "
         ASC   "PXF :0000 Awlb:0000 ExSt:0000           "
         DS    8
         ASC   "                                        "
         ASC   "Tmp2:0000 WPEA:0000 SpCn:0000  000000   "
         ASC   "JHL :0000 Artm:0000 Pal :0000           "
         DS    8
         ASC   "ST  :0000 GVY :0000 AblC:0000 Score1:   "
         ASC   "Tmp3:0000 WING:0000 IMsp:0000 Time2:    "
         ASC   "JHD :0000 Awlk:0000 Pal2:0000           "
         DS    8
         ASC   "WinX:0000 Mdir:0000 Aeye:0000  00000000 "
         ASC   "Tmp4:0000 Bt01:0000 DMsp:0000  00000000 "
         ASC   "GVX :0000 Amth:0000                     "
         DS    8
         ASC   "WBCl:0000 NoFl:0000 Itm :0000  00000000 "
         ASC   "DCnt:0000 Lupe:0000 OVRt:0000           "
         ASC   "PYB :0000 Ably:0000                     "
         DS    8
         ASC   "WSbB:0000 Yaxs:0000 Itm2:0000 Score2:   "
         ASC   "DCsl:0000 Acnr:0000 DWNt:0000           "
         ASC   "PYS :0000 Amtf:0000                     "
